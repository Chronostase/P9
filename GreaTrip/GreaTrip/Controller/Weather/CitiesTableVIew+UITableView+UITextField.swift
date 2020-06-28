//
//  CitiesTableVIew+UITableView+UITextField.swift
//  GreaTrip
//
//  Created by Thomas on 10/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import UIKit

extension CitiesTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    //Set height for cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //Set the number of rows in section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if weather == nil {
            return 0
        } else {
            return [weather].count
        }
    }
    
    //Configure cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.identifier, for: indexPath) as? CustomTableViewCell,
            let weathers = weather else {
                return UITableViewCell()
        }
        print(weathers.name)
        
        cell.configureJustTitle(name: weathers.name)
        
        return cell
    }
    
    //Configure action when user select a cell
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.sendData(city: weather)
        navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension CitiesTableViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tapGestureRecognizer?.isEnabled = true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        
        textField.text = text.formattedToRequest
        getWeatherByName(name: text.formattedToRequest)
        
        textField.resignFirstResponder()
        tapGestureRecognizer?.isEnabled = false
        
        return true
    }
}
