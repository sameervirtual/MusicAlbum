//
//  Alert.swift
//  MusicAlbum
//
//  Created by Sameer on 7/22/22.
//

import UIKit
import SystemConfiguration
 


class Alert: NSObject  {
    
    //MARK: - Alerts Methods
    //MARK: -
   
    // function to set show alert
    static func showAlert(strMessage: String) {
        
        if let topController = UIApplication.shared.windows.first?.rootViewController {

                if !topController.isKind(of: UIAlertController.self) {
                
                DispatchQueue.main.async {
                    
                    let alertController = UIAlertController(title: strProjectName , message: strMessage, preferredStyle: UIAlertController.Style.alert)
                    
                    alertController.addAction(UIAlertAction(title: EnumStaticText.getText(value: .ok), style: UIAlertAction.Style.default,handler: nil))
                    
                    topController.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
    }
}


