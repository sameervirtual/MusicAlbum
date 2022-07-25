//
//  MusicAlbumListCollectionViewCell.swift
//  MusicAlbum
//
//  Created by Sameer on 7/22/22.
//

import UIKit

class MusicAlbumListCollectionViewCell: BaseCollectionViewCell {
    
    private(set) lazy var imagView = makeImageView()
    private(set) lazy var titleLabel = makeTitleLabel()
    private(set) lazy var subTitleLabel = makeSubTitleLabel()
    private(set) lazy var stackView = makeStackView()

    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = Constants.CornerSize.with20
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.setupViewHierarchy(
            subviews: [imagView,stackView], constraints: makeImageViewConstraints() + makeStackViewConstraints())
    }
    
    // MARK: - UICollectionReusableView
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.AppImages.dummy
        return imageView
    }
    
    func makeTitleLabel() -> UILabel {
        let lbl_title = UILabel()
        lbl_title.adjustsFontForContentSizeCategory = true
        lbl_title.textColor = .white
        lbl_title.font = UIFont.getSemiBoldFont()
        lbl_title.numberOfLines = 3
        return lbl_title
    }
    
    func makeSubTitleLabel() -> UILabel {
        let lbl_subtitle = UILabel()
        lbl_subtitle.textColor = Constants.TextColors.grayColor
        lbl_subtitle.font = UIFont.getMediumFontFont(size: Constants.FontSize.with12)
        lbl_subtitle.numberOfLines = 2
        return lbl_subtitle
    }
    
    func makeStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [titleLabel,subTitleLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 0
        return stack
    }
    
    func makeImageViewConstraints() -> [NSLayoutConstraint] {
        [
            imagView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor
                .constraint(equalTo: imagView.trailingAnchor),
            
            imagView.topAnchor
                .constraint(equalTo: contentView.topAnchor),
            contentView.bottomAnchor
                .constraint(equalTo: imagView.bottomAnchor),
            
        ]
    }
    
    func makeStackViewConstraints() -> [NSLayoutConstraint] {
        [
            stackView.leftAnchor
                .constraint(equalTo: contentView.leftAnchor, constant: 10),
            contentView.rightAnchor
                .constraint(equalTo: stackView.rightAnchor, constant: 10),
            
            contentView.bottomAnchor
                .constraint(equalTo: stackView.bottomAnchor, constant: 10)
        ]
    }
    
    
    // MARK: - Cell Data Methods
    internal func setCellData(model: MusicFileDB) {
        
        self.titleLabel.text = model.name
        self.subTitleLabel.text = model.artistName
        self.imagView.loadThumbnail(urlSting: model.artworkUrl100, placeHolder: Constants.AppImages.dummy)
    }
}
