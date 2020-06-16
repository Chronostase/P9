//
//  ExchangeViewController.swift
//  GreaTrip
//
//  Created by Thomas on 24/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import UIKit

class ExchangeViewController: UIViewController {
    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyTextField: UITextField!
    @IBOutlet weak var rateLabel: UILabel!
    
    //MARK: - Methods
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        self.baseCurrencyTextField.text = ""
        getExchangeRate()
        self.targetCurrencyTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateLabel.isHidden = true
        setupController()
        getExchangeRate()
    }
    
    private func setupController() {
        setupTextField()
        setupDoneButton()
    }
    
    private func setupTextField() {
        baseCurrencyTextField.delegate = self
        targetCurrencyTextField.delegate = self
    }
    
    private func setupDoneButton() {
        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(tapDoneButton))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        baseCurrencyTextField.inputAccessoryView = toolBar
    }

    @objc private func tapDoneButton() {
        if baseCurrencyTextField.text == "" {
            DispatchQueue.main.async {
                self.targetCurrencyTextField.text = ""
            }
            view.endEditing(true)
            return
        } else {
            guard let text = baseCurrencyTextField.text else {
                return
            }
            let adjustedText = text.replacingOccurrences(of: ",", with: ".")
            if textIsConvertiBleToIntOrDouble(adjustedText) {
                getExchangeRate(amount: adjustedText)
                addCurrencySymbolFor(adjustedText)
            } else {
                view.endEditing(true)
                self.displayAlert(message: "Your data are not numbers")
            }
        }
    }
    
    private func textIsConvertiBleToIntOrDouble(_ text: String) -> Bool {
        if text.isDouble || text.isInt {
            return true
        } else {
            return false
        }
    }
    
    private func addCurrencySymbolFor(_ adjustedText: String) {
        if adjustedText.contains(Constants.Exchange.euroSymbol) {
            print(adjustedText)
            view.endEditing(true)
        } else {
            DispatchQueue.main.async {
                self.baseCurrencyTextField.text = adjustedText + Constants.Exchange.euroSymbol
            }
        }
        view.endEditing(true)
        
    }
    
    func getExchangeRate(amount: String = "1") {
        ExchangeService().getExchangeRates() { result in
            switch result {
            case .success(let exchange):
                guard let exchangeRate = exchange else {
                    return
                }
                let filterdData = exchangeRate.rates.filter { $0.key == Constants.Exchange.dollar }
                guard let rate = filterdData.values.first, let userCurrency = Double(amount) else {
                    return
                }
                
                DispatchQueue.main.async {
                    if self.baseCurrencyTextField.text != "" {
                        self.refreshTargetTextField(rate, userCurrency)
                    }
                }
                self.showRateLabel(rate)
                print(amount)
                
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.displayAlert(message: Constants.Error.wifiError)
                }
            }
        }
    }
    
    private func showRateLabel(_ rate: Double) {
        DispatchQueue.main.async {
            self.rateLabel.text = Constants.Exchange.rateMessage + "\(String(rate))"
            self.rateLabel.isHidden = false
        }
    }
    
    private func refreshTargetTextField(_ rate: Double,_ userAmount: Double) {
        self.targetCurrencyTextField.text = ExchangeService().calculateTargetCurrency(rate, userAmount) + Constants.Exchange.dollarSymbol
    }
}
