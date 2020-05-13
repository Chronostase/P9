//
//  Weather.swift
//  GreaTrip
//
//  Created by Thomas on 29/04/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

struct WeatherArray: Decodable {
    var list: [Weathers]?
}

struct Weathers: Decodable {
    var weather: [WeatherDetails]
    var main: Main
    var name: String
    var imageData: Data?
}

struct WeatherDetails: Decodable {
    var icon: String
}

struct Main: Decodable {
    var temp: Double
}
