//
//  Webservices.swift
//  MusicAlbum
//
//  Created by Sameer on 25/07/22.
//

import Foundation
import UIKit

let screenSize: CGRect = UIScreen.main.bounds
let appDelegate = UIApplication.shared.delegate as! AppDelegate

let baseURL = StaticEndpoints.developmentURL.strEndPoint
var strProjectName = "Music Album"



// type alies
typealias CallBack = (() -> Void)
typealias Parameters = [String: Any]


func getColor(red : Double , green : Double , blue : Double) -> UIColor {
    
    let color = UIColor.init(red: CGFloat(red/255.0), green:CGFloat( green/255.0), blue: CGFloat(blue/255.0), alpha: 1.0)
    return color
}

func logConsole(object: Any, tit: String = "") {
    #if DEBUG
    Swift.print("\(tit): ==>", object)
    #endif
}


struct Storyboards {
    static let OnBoarding = "OnBoarding"
}

struct VCID {
    static let IntroVC = "IntroVC"
   
}


struct Constants {
    
    struct TextColors {
        static let black23 = getColor(red : 23.0 , green : 23.0 , blue : 23.0)
        static let grayColor = getColor(red : 181.0 , green : 181.0 , blue : 181.0)
        static let blueColor = getColor(red : 0 , green : 122.0 , blue : 255.0)

    }
    
    struct Fonts {
        
        static let semiboldFont = "SFProText-Semibold"
        static let mediumFont = "SFProText-Medium"

    }
    
    struct FontSize {
        static let with18 = CGFloat(18)
        static let with16 = CGFloat(16)
        static let with10 = CGFloat(10)
        static let with12 = CGFloat(12)
        static let with34 = CGFloat(34)

    }
    
    struct CornerSize {
        static let with30 = CGFloat(30)
        static let with20 = CGFloat(20)
        static let with10 = CGFloat(10)
        static let with12 = CGFloat(12)
        static let with06 = CGFloat(06)

    }
    
    
    struct AppImages {
        static let dummy = UIImage(named: "dummy")
        static let arwLeft = UIImage(named: "arwLeft")

    }
}
