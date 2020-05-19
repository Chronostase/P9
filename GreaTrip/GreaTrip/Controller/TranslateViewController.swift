//
//  TranslateViewController.swift
//  GreaTrip
//
//  Created by Thomas on 19/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import UIKit

class TranslateViewController: UIViewController {
    
    //MARK- Properties
    @IBAction func translateButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var editableTextField: UITextView!
    @IBOutlet weak var translatedTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTextFields()
    }
    
    //MARK- Setup
    
//    private func setupTextFields() {
//        editableTextField.delegate = self
//        translatedTextField.delegate = self
//    }
}

//extension TranslateViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        guard let text = textField.text else {
//            return true
//        }
//    }
//}
