//
//  Constants.swift
//  GreaTrip
//
//  Created by Thomas on 09/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

enum Constants {
    enum Network {
        enum Weather {
            static let baseUrl = "http://api.openweathermap.org/data/2.5/"
            static let imageUrl = "http://openweathermap.org/img/wn/"
            static let imageSize = "@2x.png"
            static let openWeatherMapId = "openWeatherMapAppId"
            static let metricParameters = "&units=metric&APPID="
            static let groupParameter = "group?id=2984114,5128581&units=metric&APPID="
            static let cityNameParameter = "weather?q="
        }
        enum Translate {
            static let baseUrl = URL(string: "https://translation.googleapis.com/language/translate/v2?")
            static let requestType = "POST"
            static let cloudTranslater = "cloudTranslater"
            static let key = "key="
            static let firstParameter = "&q="
            static let parameter = "&source=fr&target=en&format=text"
        }
        enum Exchange {
            static let baseUrl = "http://data.fixer.io/api/latest?access_key="
            static let fixerIo = "fixerIo"
        }
    }
    
    enum Error {
        static let wifiError = "Can't get weather, please check your connection and retry"
        static let errorTitle = "Error !"
        static let actionTitle = "OK"
    }
    enum Cell {
        static let identifier = "Cell"
        static let nibName = "CustomTableViewCell"
    }
    enum Storyboard {
        static let name = "CitiesTableView"
    }
    enum Exchange {
        static let dollar = "USD"
        static let dollarSymbol = "＄"
        static let euroSymbol = " €"
        static let rateMessage = "The actual currency rate from EUR to USD is "
    }
    enum Button {
        static let name = "Group"
    }
    
}
