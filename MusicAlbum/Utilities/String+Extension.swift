//
//  String+Extension.swift
//  MusicAlbum
//
//  Created by Sameer on 25/07/22.
//
import Foundation

extension String {
    
    static var deviceCountry: String {
       return  Locale.current.regionCode ?? "US"
    }
    
}
