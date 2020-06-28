//
//  WeatherViewController+UITableView.swift
//  GreaTrip
//
//  Created by Thomas on 10/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import UIKit

extension WeatherViewController: UITableViewDataSource {
    
    //Set number of row in Section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weather?.list?.count ?? 0
    }
    
    //Configure cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.identifier, for: indexPath) as? CustomTableViewCell,
            let weather = weather?.list?[indexPath.row],
            let data = weather.imageData else {
                return UITableViewCell()
        }
        cell.isUserInteractionEnabled = false
        cell.configureAllCell(name: weather.name, temperature: Int(weather.main.temp), image: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("enter in did select")
    }
}

extension WeatherViewController: UITableViewDelegate {
    
    //Set height for cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
