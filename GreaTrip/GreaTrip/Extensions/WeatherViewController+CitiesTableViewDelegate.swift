//
//  WeatherViewController+CitiesTableViewDelegate.swift
//  GreaTrip
//
//  Created by Thomas on 09/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

extension WeatherViewController: CitiesTableViewDelegate {
    
    func sendData(city: Weathers?) {
        guard let city = city else {
            return 
        }
        self.weather?.list?.append(city)
        self.tableView.reloadData()
        
    }
    
    func getCityFailed(city: Weathers?) {
        print("yes")
    }
}
