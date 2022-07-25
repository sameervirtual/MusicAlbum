//
//  MusicAlbumListViewController.swift
//  MusicAlbum
//
//  Created by Sameer on 7/22/22.
//

import UIKit

class MusicAlbumListViewController: BaseCollectionViewController {
        
    let collectionMargin = CGFloat(10)
    var arrAlbum : [MusicFileDB]?
    
    // MARK: - Initialization
    override init() {
        super.init()
        title = EnumStaticText.getText(value: .top100Alnums)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getMusicData()
        self.collectionView.backgroundColor = .white
        self.collectionView.showsVerticalScrollIndicator = false
        setupUI()
    }
    
    private func getMusicData() {
        
        Webservices.getMusicAlbum(count: 100) { value in
            
            if let value = value, let arrTemp = value.results {
                         
                for obj in arrTemp {

                    DispatchQueue.main.async {
                        if !DBManager.sharedInstance.objectMusicDBExist(id: obj.id ?? "") {
                            DBManager.sharedInstance.saveObject(obj: MusicFileDB.addMusicObj(model: obj))
                        }
                    }
                }
                
                
                DispatchQueue.main.async {
                    if !DBManager.sharedInstance.objectFeedDBExist(id: value.id ?? "") {
                        DBManager.sharedInstance.saveObject(obj: FeedDB.addFeedObj(model: value))
                    }
                }
                
            }
            self.reloadCollectionView()
        }
    }
    
    private func getMusicDataFromDB() {
        
        DispatchQueue.main.async {
            
            let values = DBManager.sharedInstance.getObjects(type: MusicFileDB.self)
            
            if let arrTemp = values as? [MusicFileDB] {
                self.arrAlbum = arrTemp
            }
        }
    }
    
    private func reloadCollectionView() {
        self.getMusicDataFromDB()
        
        DispatchQueue.main.async {

            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupUI(){
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        collectionView.register(MusicAlbumListCollectionViewCell.self, forCellWithReuseIdentifier: "MusicAlbumListCollectionViewCell")
        
        self.reloadCollectionView()
    }
}

extension MusicAlbumListViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrAlbum?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicAlbumListCollectionViewCell", for: indexPath) as? MusicAlbumListCollectionViewCell, let arrValues = self.arrAlbum else {
            return UICollectionViewCell()
        }
        cell.setCellData(model: arrValues[indexPath.row])
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let albumModel = self.arrAlbum?[indexPath.row] else {
            return
        }

        DispatchQueue.main.async {
            let values = DBManager.sharedInstance.getObjects(type: FeedDB.self)
            if let arrTemp = values as? [FeedDB], let objFeed = arrTemp.first {
                    
                let detailVC = AlbumDetailVC()
                detailVC.detailAlbum = albumModel
                detailVC.copyRight = objFeed.copyright
                self.navigationController?.pushViewController(detailVC, animated: false)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionMargin
    }
}

extension MusicAlbumListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size : CGFloat = (collectionView.frame.width / 2) - (collectionMargin * 2)
        return CGSize(width: size, height: size)
    }
}
