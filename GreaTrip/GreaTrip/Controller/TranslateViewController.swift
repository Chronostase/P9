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
        getTranslation()
    }
//    weak var delegate: TranslateViewController?
    
    @IBOutlet weak var editableTextField: UITextView!
    @IBOutlet weak var translatedTextField: UITextView!
    
    var translation: Translation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupDoneButton()
    }
    
    
    private func getTranslation() {
        TranslateService().getTranslation(text: editableTextField.text) { result in
            switch result {
            case .success(let text):
                guard let translatedText = text else {
                    return
                }
                self.translation = translatedText
                self.updateTranslatedTextField()
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    //MARK- Setup
    
    private func setupDoneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(tapDoneButton))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        editableTextField.inputAccessoryView = toolBar
    }
    
    @objc private func tapDoneButton() {
        view.endEditing(true)
    }
    
    private func updateTranslatedTextField() {
        guard let text = translation?.data.translations.first?.translatedText else {
            return
        }
        DispatchQueue.main.async {
            self.translatedTextField.text = text
        }
    }
    
    private func setupTextFields() {
        editableTextField.delegate = self
        translatedTextField.delegate = self
    }
}

extension TranslateViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        setupDoneButton()
        editableTextField.text = nil
        editableTextField.textColor = .white
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let adjutedText = text.replacingOccurrences(of: " ", with: "%20")
        textField.text = adjutedText
        textField.resignFirstResponder()
        print("ok")
        return true
    }
}
