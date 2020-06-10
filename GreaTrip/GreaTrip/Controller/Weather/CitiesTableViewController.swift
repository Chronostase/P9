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
}

class CitiesTableViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var citiesTextField: UITextField!
    
    var weather: Weathers?
    var tapGestureRecognizer: UITapGestureRecognizer?
    weak var delegate: CitiesTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupTableView()
        setupTapGesture()
        setupCitiesTextFieldDelegate()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: Constants.Cell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.Cell.identifier)
    }
    
    private func setupCitiesTextFieldDelegate() {
        citiesTextField.delegate = self
    }
    
    private func setupTapGesture() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        guard let tapGesture = tapGestureRecognizer else {
            return
        }
        tableView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Methods
    
    private func getWeatherImage() {
        guard let iconName = weather?.weather.first?.icon else {
            return
        }
        WeatherService().getImage(named: iconName) { [weak self] result in
            switch result {
            case .success(let image):
                self?.weather?.imageData = image
                DispatchQueue.main.async {
                    return self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getWeather(name: String) {
        WeatherService().getWeatherWithUserInteract(cityName: name) { [weak self] result in
            switch result {
            case .success(let weather):
                
                guard let city = weather else {
                    return
                }
                self?.weather = city
                
                self?.getWeatherImage()
                DispatchQueue.main.async {
                    self?.tableView.separatorStyle = .singleLine
                    self?.resultLabel.isHidden = true
                    self?.tableView.reloadData()
                }
                
            case .failure(let error) :
                self?.weather = nil
                
                DispatchQueue.main.async {
                    self?.tableView.separatorStyle = .none
                    self?.resultLabel.isHidden = false
                    self?.tableView.reloadData()
                }
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func handleTapGesture() {
        if citiesTextField.isFirstResponder {
            citiesTextField.resignFirstResponder()
            tapGestureRecognizer?.isEnabled = false
        }
    }
    
}
