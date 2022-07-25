//
//  BaseCollectionViewController.swift
//  MusicAlbum
//
//  Created by Sameer on 7/22/22.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    // MARK: - Initialization
    init() {
        super.init(collectionViewLayout: Self.makeCollectionViewLayout())
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Type Functions
    class func makeCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layoutConfig = UICollectionViewFlowLayout()
        layoutConfig.scrollDirection = .vertical
        return layoutConfig
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
