//
//  UIView+Extension.swift
//  MusicAlbum
//
//  Created by Sameer on 7/22/22.
//

import UIKit

extension UIView {
    @objc func setupViewHierarchy(subviews: [UIView], constraints: [NSLayoutConstraint]) {
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
        
        addConstraints(constraints)
    }
}
