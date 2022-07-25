//
//  AppearianceManager.swift
//  MusicAlbums
//
//  Created by Sameer on 7/22/22.
//

import UIKit

class AppearanceManager {
    static let shared = AppearanceManager()
    
    var barBackgroundEffect: UIBlurEffect {
        UIBlurEffect(style: .systemMaterial)
    }
    
    private var navigationBarAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        return appearance
    }
    
    private var toolbarAppearance: UIToolbarAppearance {
        let appearance = UIToolbarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundEffect = barBackgroundEffect
        return appearance
    }
    
    private init() {}
    
    func configure() {
        configureNavigationBarAppearance()
        configureToolbarAppearance()
    }
    
    private func configureNavigationBarAppearance() {
        let appearance = navigationBarAppearance
        let appearanceProxy = UINavigationBar.appearance()
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 34)]
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]

        if #available(iOS 15, *) {
            appearanceProxy.scrollEdgeAppearance = appearance
            appearanceProxy.compactAppearance = appearance
            appearanceProxy.standardAppearance = appearance
        }
    }
        
    private func configureToolbarAppearance() {
        let appearance = toolbarAppearance
        let appearanceProxy = UIToolbar.appearance()
        
        if #available(iOS 15, *) {
            appearanceProxy.scrollEdgeAppearance = appearance
            appearanceProxy.standardAppearance = appearance
        }
    }
}
