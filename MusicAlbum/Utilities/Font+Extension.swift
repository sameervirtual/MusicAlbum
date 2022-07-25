//
//  Font+Extension.swift
//  MusicAlbum
//
//  Created by Sameer on 25/07/22.
//
import UIKit

extension UIFont {

    static func getSemiBoldFont(size: CGFloat = Constants.FontSize.with16) -> UIFont {
        return UIFont(name: Constants.Fonts.semiboldFont, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func getMediumFontFont(size: CGFloat = Constants.FontSize.with16) -> UIFont {
        return UIFont(name: Constants.Fonts.mediumFont, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func getRegularFont(size: CGFloat? = Constants.FontSize.with18) -> UIFont {
        return UIFont(name: Constants.Fonts.mediumFont, size: size ?? 18) ?? UIFont.systemFont(ofSize: size ?? 18)
    }
}
