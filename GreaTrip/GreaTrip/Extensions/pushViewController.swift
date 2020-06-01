//
//  pushViewController.swift
//  GreaTrip
//
//  Created by Thomas on 30/04/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
}
