//
//  UIViewController+Push+DisplayAlert+UiActivity.swift
//  GreaTrip
//
//  Created by Thomas on 30/04/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//
import UIKit

extension UIViewController {

    //Allow to push a viewController
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    //Display any alert with personalized message
    
    func displayAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
