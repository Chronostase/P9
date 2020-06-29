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
    
    //Allow to clean both textField and refresh ExchangeRate
    
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
    
    // Set delegate to both TextField
    
    private func setupTextField() {
        baseCurrencyTextField.delegate = self
        targetCurrencyTextField.delegate = self
    }
    
    //Set done button to right side of keyboard toolbar
    
    private func setupDoneButton() {
        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(tapDoneButton))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        baseCurrencyTextField.inputAccessoryView = toolBar
    }
    
    //Allow to check if user entry is correct and add currencySymbol, and get currency rate

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
            if adjustedText.isConvertiBleToIntOrDouble() {
                getExchangeRate(amount: adjustedText)
                addCurrencySymbolFor(adjustedText)
            } else {
                view.endEditing(true)
                self.displayAlert(message: Constants.Error.userEntryError)
            }
        }
    }
    
    private func addCurrencySymbolFor(_ adjustedText: String) {
        if adjustedText.contains(Constants.Exchange.euroSymbol) {
            view.endEditing(true)
        } else {
            DispatchQueue.main.async {
                self.baseCurrencyTextField.text = adjustedText + Constants.Exchange.euroSymbol
            }
        }
        view.endEditing(true)
        
    }
    
    //Allow to have exchange rate
    
    func getExchangeRate(amount: String = "1") {
        showIndicator()
        ExchangeService(baseUrl: Constants.Network.Exchange.baseUrl).getExchangeRates() { result in
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
                
            case .failure(let error):
                print("getExchangeRate: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.displayAlert(message: Constants.Error.networkError)
                }
            }
        }
        hideIndicator()
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
