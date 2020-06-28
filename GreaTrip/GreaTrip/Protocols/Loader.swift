//
//  Loader.swift
//  GreaTrip
//
//  Created by Thomas on 28/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import UIKit

protocol UILoader {}

extension UILoader where Self: UIViewController {
    
    func showLoader(withStryle style: UIActivityIndicatorView.Style) {
        DispatchQueue.main.async {
            let loader = UIActivityIndicatorView(style: style)
            loader.center = self.view.center
            self.view.isUserInteractionEnabled = false
            loader.startAnimating()
            self.view.addSubview(loader)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.view.subviews.forEach {
                guard let activityIndicator = $0 as? UIActivityIndicatorView else {
                    return
                }
                self.view.isUserInteractionEnabled = true
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}

extension UIViewController: UILoader {
    func showIndicator(withStryle style: UIActivityIndicatorView.Style = .gray) {
        showLoader(withStryle: style)
    }
    
    func hideIndicator() {
        hideLoader()
    }
}
