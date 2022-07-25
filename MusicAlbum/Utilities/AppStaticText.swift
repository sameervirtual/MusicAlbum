//
//  AppStaticText.swift
//  MusicAlbum
//
//  Created by Sameer on 7/22/22.
//

import Foundation

enum EnumErrorMsg:String {
    
    //project text//
    case noInternet = "Internet connection not available, please check internet connection!!!"
   
    static func getText(value: EnumErrorMsg) -> String {
       return value.rawValue
    }
}

enum EnumStaticText:String {
    
    case top100Alnums = "Top 100 Albums"
    case ok = "OK"
    case released = "Released"
    case visitTheAlbum = "Visit The Album"
    
    static func getText(value: EnumStaticText) -> String {
       return value.rawValue
    }
}




