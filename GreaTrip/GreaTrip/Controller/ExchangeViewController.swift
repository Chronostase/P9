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
    @IBOutlet weak var baseCurrencyImage: UIImageView!
    @IBOutlet weak var targetCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateLabel.isHidden = true
        setupTextField()
        setupImageView()
    }
    
    func getExchangeRate(amount: String) {
        ExchangeService().getExchangeRates() { result in
            switch result {
            case .success(let exchange):
                guard let exchangeRate = exchange else {
                    return
                }
                let filterdData = exchangeRate.rates.filter { $0.key == "USD" }
                guard let rate = filterdData.values.first else {
                    return
                }
                guard let userCurrency = Double(amount) else {
                    return
                }
                self.refreshTargetTextField(rate, userCurrency)
                self.showRateLabel(rate)
                print(amount)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func showRateLabel(_ rate: Double) {
        DispatchQueue.main.async {
            self.rateLabel.text = "The actual currency rate from EUR to USD is \(String(rate))"
            self.rateLabel.isHidden = false
        }
    }
    
    private func refreshTargetTextField(_ rate: Double,_ userAmount: Double) {
        DispatchQueue.main.async {
            self.targetCurrencyTextField.text = ExchangeService().calculateTargetCurrency(rate, userAmount)
        }
    }
    
    private func setupImageView() {
        baseCurrencyImage.image = UIImage(named: "EUR Flag")
        targetCurrencyImage.image = UIImage(named: "USA Flag")
    }
    
    private func setupTextField() {
        baseCurrencyTextField.delegate = self
        targetCurrencyTextField.delegate = self
    }
}

extension ExchangeViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        guard let text = textField.text else {
            return true
        }
        getExchangeRate(amount: text)
        print(text)
        textField.resignFirstResponder()
        
        return true
    }
}
