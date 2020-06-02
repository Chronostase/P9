//
//  CitiesListViewController.swift
//  GreaTrip
//
//  Created by Thomas on 29/04/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import UIKit

protocol CitiesTableViewDelegate: class {
    func sendData(city: Weathers?)
    
    //retirer
    func getCityFailed(city: Weathers?)
}

class CitiesTableViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var citiesTextField: UITextField!
    
    
//    var city: City?
    var weather: Weathers?
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    weak var delegate: CitiesTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCitiesTextFieldDelegate()
        setupTapGesture()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - Methods
    
    private func getWeatherImage() {
        guard let iconName = weather?.weather.first?.icon else {
            return
        }
        WeatherService().getImage(named: iconName) { (success, data) in
            if success, let image = data {
                // Append or do somethinf with image received
                self.weather?.imageData = image
                DispatchQueue.main.async {
                    return  self.tableView.reloadData()
                }
            }
        }
    }
    
   private func getWeather(name: String) {
        WeatherService().getWeatherWithUserInteract(cityName: name) { result in
            switch result {
            case .success(let weather):

                guard let city = weather else {
                    return
                }
                self.weather = city

                self.getWeatherImage()
                DispatchQueue.main.async {
                    self.tableView.separatorStyle = .singleLine
                    self.resultLabel.isHidden = true
                    return self.tableView.reloadData()
                }
                
            case .failure(let error) :
                self.weather = nil
                
                DispatchQueue.main.async {
                    self.tableView.separatorStyle = .none
                    self.resultLabel.isHidden = false
                    self.tableView.reloadData()
                }
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Setup
    
    
    private func setupTableView() {
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    private func setupCitiesTextFieldDelegate() {
        citiesTextField.delegate = self
    }
    
    private func setupTapGesture() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
//        tapGesture.cancelsTouchesInView = false
        guard let tapGesture = tapGestureRecognizer else {
            return
        }
        
        tableView.addGestureRecognizer(tapGesture)
    }
    
    /** Dismiss Keyboard. */
    @objc private func handleTapGesture() {
        if citiesTextField.isFirstResponder {
            citiesTextField.resignFirstResponder()
            tapGestureRecognizer?.isEnabled = false
        }
    }
    
}

extension CitiesTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if weather == nil {
            return 0
        } else {
            return [weather].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell,

            let weathers = weather else {
        return UITableViewCell()
}
        print(weathers.name)
        
        // Find best way to don"t show TempLablel and UIImageView
        cell.temperatureLabel.isHidden = true
        cell.configureJustTitle(name: weathers.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.sendData(city: weather)
        navigationController?.popViewController(animated: true)
        print("Enter in didSelect")
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
        let adjutedText = text.replacingOccurrences(of: " ", with: "%20")
        getWeather(name: adjutedText)
        
        print(text)
        textField.resignFirstResponder()
        tapGestureRecognizer?.isEnabled = false
        
        return true
    }
}
