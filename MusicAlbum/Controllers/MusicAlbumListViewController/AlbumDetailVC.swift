//
//  AlbumDetailVC.swift
//  MusicAlbum
//
//  Created by Apple on 25/07/22.
//

import UIKit
import SafariServices


class AlbumDetailVC: UIViewController {

    private(set) lazy var imagView = makeImageView()
    private(set) lazy var titleLabel = makeTitleLabel(font: UIFont.getRegularFont(), alignment: .left)
    private(set) lazy var subTitleLabel = makeSubTitleLabel()
    private(set) lazy var collCategories = makeCategoriesList()
    private(set) lazy var backButton = makeBackButton()
    private(set) lazy var copyRightLabel = makeTitleLabel(font: UIFont.getMediumFontFont(size: 12), alignment: .center)
    private(set) lazy var visitBtn = makeVisitButton()
    
    var detailAlbum : MusicFileDB?
    var copyRight : String?
    var catLayout : TagCellLayout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        let constraints = makeImageViewConstraints() + makeTitleConstraints() + makeSubTitleConstraints() + makeBackButtonConstraints() + makeCollCatConstraints() + makecopyRightConstraints() + makeVisitBtnConstraints()
        self.view.setupViewHierarchy(subviews: [imagView, titleLabel, subTitleLabel, backButton, collCategories, copyRightLabel, visitBtn], constraints: constraints)
        
        collCategories.contentInset = UIEdgeInsets(top: 5, left: 16, bottom: 10, right: 15)
        collCategories.register(CategoriesCC.self, forCellWithReuseIdentifier: "CategoriesCC")
        self.view.backgroundColor = .white
        setDetailData()
        // Do any additional setup after loading the view.
    }

    func setDetailData(){
        titleLabel.text = detailAlbum?.artistName ?? ""
        subTitleLabel.text = detailAlbum?.name ?? ""
        
        if let arrValues = detailAlbum?.artworkUrl100.components(separatedBy: "/100x"), arrValues.count > 0 {
            let strUrl = "\(arrValues[0])\(EnumImageSize.getVal(val: .medinum))"
            self.imagView.loadThumbnail(urlSting: strUrl, placeHolder: Constants.AppImages.dummy)

        }
        if let strDate = DateFormet.formattedDateFromString(dateString: detailAlbum?.releaseDate ?? "", withFormat: DateFormet.monthDateYearFormat) {
         
            copyRightLabel.text = "\(EnumStaticText.getText(value: .released)) \(strDate)\n\(copyRight ?? "")"
        }
    }
    
    
    @objc func btnVisitAlbumPressed() {
        
//        guard let url = URL(string: detailAlbum?.url ?? "") else {
//            return
//        }
//        let svc = SFSafariViewController(url: url)
//        self.present(svc, animated: true, completion: nil)
        
        
        
        if let url = URL(string: detailAlbum?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
  
}

//MARK: Set UI

extension AlbumDetailVC {
    
    func makeVisitButton() -> UIButton {
        let btn = UIButton()
        btn.setTitle(EnumStaticText.getText(value: .visitTheAlbum), for: .normal)
        btn.layer.cornerRadius = Constants.CornerSize.with10
        btn.layer.masksToBounds = true
        btn.backgroundColor = Constants.TextColors.blueColor
        btn.titleLabel?.font =  UIFont.getSemiBoldFont()
        btn.addTarget(self, action: #selector(self.btnVisitAlbumPressed), for: .touchUpInside)
        return btn
    }
    
    func makeBackButton() -> UIControl {
        let control = UIControl()
        control.backgroundColor = Constants.TextColors.grayColor
        control.layer.cornerRadius = 15 // Constants.CornerSize.with12
        control.layer.masksToBounds = true
        control.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.AppImages.arwLeft
        control.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageView.centerYAnchor.constraint(equalTo: control.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: control.centerXAnchor).isActive = true
        
        return control
    }
    
   @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
 
}

//MARK: - coll categories

extension AlbumDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailAlbum?.arrGenres.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCC", for: indexPath) as? CategoriesCC else {
            return UICollectionViewCell()
        }
        let dict = detailAlbum?.arrGenres[indexPath.row]
        cell.titleLabel.text = dict?.name ?? ""
        return cell
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension AlbumDetailVC : TagCellLayoutDelegate{
    var oneLineHeight: CGFloat {
        return 21
    }
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        var s = textSize(text: detailAlbum?.arrGenres[index].name ?? "" , font:UIFont.getRegularFont(size: Constants.FontSize.with12) , collectionView: collCategories)
        s.height += 8.0
       
        return s
    }
    func textSize(text: String, font: UIFont, collectionView: UICollectionView) -> CGSize {
        let collsize = collectionView.bounds
       // f.size.height = 9999.0
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = font
        var txtsize = label.sizeThatFits(collsize.size)
        txtsize.width = txtsize.width + 30
        txtsize.height = max(oneLineHeight, txtsize.height)
        return txtsize
    }
    
}
