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
    
    @IBOutlet weak var editableTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var button: UIButton!
    
    var translation: Translation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupDoneButton()
//        setupButton()
    }
    
//    func setupButton() {
//        button.layer.shadowColor = UIColor.green.cgColor
//        button.layer.shadowOffset = CGSize(width: 0, height: 2)
//        button.layer.shadowOpacity = 0.5
//        button.layer.shadowRadius = 2
//        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
//    }
    
    private func getTranslation() {
        TranslateService().getTranslation(text: editableTextView.text) { result in
            switch result {
            case .success(let text):
                guard let translatedText = text else {
                    return
                }
                self.translation = translatedText
                self.updateTranslatedTextView()
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
        editableTextView.inputAccessoryView = toolBar
    }
    
    @objc private func tapDoneButton() {
        view.endEditing(true)
    }
    
    private func updateTranslatedTextView() {
        guard let text = translation?.data.translations.first?.translatedText else {
            return
        }
        DispatchQueue.main.async {
            self.translatedTextView.text = text
        }
    }
    
    private func setupTextView() {
        editableTextView.delegate = self
        translatedTextView.delegate = self
    }
}

extension TranslateViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        editableTextView.text = nil
        editableTextView.textColor = .white
    }
}
