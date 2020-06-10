//
//  ExchangeViewController+UITextField.swift
//  GreaTrip
//
//  Created by Thomas on 10/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import UIKit

extension ExchangeViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        getExchangeRate(amount: text)
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = baseCurrencyTextField.text {
            let countDots = text.components(separatedBy: ",").count - 1
            if countDots > 0 && string == "," {
                return false
            }
        }
        return true
    }
}
