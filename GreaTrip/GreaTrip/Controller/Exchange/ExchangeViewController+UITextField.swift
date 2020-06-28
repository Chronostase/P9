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
    
    //Allow to have only one dote or commas in textfield
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isContainingDots = baseCurrencyTextField.text?.contains(".")
        let isContainingCommas = baseCurrencyTextField.text?.contains(",")
        

        if isContainingDots == true && isContainingCommas == true {
            baseCurrencyTextField.text?.removeLast()
            return true
        }
        
        if isContainingDots == true || isContainingCommas == true {
            guard let text = baseCurrencyTextField.text else {
                return true
            }
            let containedCharacter = isContainingDots == true ? "." : ","
            let characterCount = text.components(separatedBy: containedCharacter).count - 1
            if characterCount > 0 && string == containedCharacter {
                return false
            }
        }
        
        return true
    }
}
