//
//  CategoriesCC.swift
//  MusicAlbum
//
//  Created by Apple on 25/07/22.
//

import UIKit

class CategoriesCC: BaseCollectionViewCell {
    
    private(set) lazy var titleLabel = makeTitleLabel()
    private(set) lazy var viewBorder = makeViewBorder()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.setupViewHierarchy(
            subviews: [viewBorder], constraints: makeViewBorderConstraints())
        
        viewBorder.setupViewHierarchy(
            subviews: [titleLabel], constraints: makeTitleConstraints())
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    func makeTitleLabel() -> UILabel {
        let lbl_title = UILabel()
        lbl_title.adjustsFontForContentSizeCategory = true
        lbl_title.textColor = Constants.TextColors.blueColor
        lbl_title.textAlignment = .center
        lbl_title.text = ""
        lbl_title.font = UIFont.getRegularFont(size: Constants.FontSize.with12)
        lbl_title.numberOfLines = 1
        return lbl_title
    }
    
    func makeViewBorder() -> UIView {
        let view = UIView()
        view.layer.cornerRadius =  Constants.CornerSize.with10
        view.layer.masksToBounds = true
        view.layer.borderColor = Constants.TextColors.blueColor.cgColor
        view.layer.borderWidth = 1
        
        return view
    }
    
    func makeTitleConstraints() -> [NSLayoutConstraint] {
        [
            titleLabel.leadingAnchor.constraint(equalTo: viewBorder.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: viewBorder.trailingAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: viewBorder.topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: viewBorder.bottomAnchor, constant: -5),
        ]
    }
    
    func makeViewBorderConstraints() -> [NSLayoutConstraint] {
        [
            viewBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            viewBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            viewBorder.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            viewBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ]
    }
}
