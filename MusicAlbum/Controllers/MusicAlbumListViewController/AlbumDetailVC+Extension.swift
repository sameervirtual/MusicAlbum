//
//  AlbumDetailVC+Extension.swift
//  MusicAlbum
//
//  Created by Apple on 25/07/22.
//

import UIKit
import Foundation

extension AlbumDetailVC {
    

    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = Constants.AppImages.dummy
        return imageView
    }
    
     func makeTitleLabel(font: UIFont, alignment: NSTextAlignment) -> UILabel {
        let lbl_title = UILabel()
        lbl_title.textAlignment = alignment
        lbl_title.adjustsFontForContentSizeCategory = true
        lbl_title.textColor = Constants.TextColors.grayColor
        lbl_title.text = ""
        lbl_title.font = font
        lbl_title.numberOfLines = 0
        return lbl_title
    }
    
     func makeSubTitleLabel() -> UILabel {
        let lbl_subtitle = UILabel()
        lbl_subtitle.textColor = .black
        lbl_subtitle.text = ""
        lbl_subtitle.font = UIFont.getMediumFontFont(size: Constants.FontSize.with34)
        lbl_subtitle.numberOfLines = 0
        return lbl_subtitle
    }
    
    
     func makeCategoriesList() -> UICollectionView {
        let collList = UICollectionView(frame: self.view.frame, collectionViewLayout: makeCollectionViewLayout())
        collList.backgroundColor = .white
        collList.showsHorizontalScrollIndicator = false
        collList.isScrollEnabled = false
        collList.delegate = self
        collList.dataSource = self
        return collList
    }
    
     func makeCollectionViewLayout() -> TagCellLayout {
        let layoutConfig = TagCellLayout.init(alignment: .left, delegate: self)
       
        return layoutConfig
    }
    
     func makeBackButtonConstraints() -> [NSLayoutConstraint] {
        [
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 32),
            backButton.widthAnchor.constraint(equalToConstant: 32)
        ]
    }
    
     func makeImageViewConstraints() -> [NSLayoutConstraint] {
        [
            imagView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), self.view.trailingAnchor.constraint(equalTo: imagView.trailingAnchor),
            
            imagView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imagView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.462)
        ]
    }
    
     func makeTitleConstraints() -> [NSLayoutConstraint] {
        [
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: self.imagView.bottomAnchor, constant: 12),
        ]
    }
    
     func makeSubTitleConstraints() -> [NSLayoutConstraint] {
        [
            subTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 0),
        ]
    }
    
      func makeCollCatConstraints() -> [NSLayoutConstraint] {
        [
            collCategories.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), self.view.trailingAnchor.constraint(equalTo: collCategories.trailingAnchor),
            
            collCategories.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 0),

            //collCategories.heightAnchor.constraint(equalToConstant: 150)
        ]
    }
    
     func makecopyRightConstraints() -> [NSLayoutConstraint] {
        [
            copyRightLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            copyRightLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            copyRightLabel.topAnchor.constraint(equalTo: self.collCategories.bottomAnchor, constant: 5),
        ]
    }
    
     func makeVisitBtnConstraints() -> [NSLayoutConstraint] {
        [
            visitBtn.topAnchor.constraint(equalTo: self.copyRightLabel.bottomAnchor, constant: 24),
            visitBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            visitBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -47),
            visitBtn.heightAnchor.constraint(equalToConstant: 45),
            visitBtn.widthAnchor.constraint(equalToConstant: 155)
        ]
    }

}


