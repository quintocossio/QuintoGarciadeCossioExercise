//
//  AlertManager.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 11/01/2022.
//

import UIKit

class AlertManager{
    
    static func showAlert(title: String, message:String, vc: UIViewController, tryAgain: @escaping () -> ()){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { _ in
            
            tryAgain()
            
        }))
        
        vc.present(alertController, animated: true)
        
    }
    
}


