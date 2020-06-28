//
//  FakeResponseData.swift
//  GreaTripTests
//
//  Created by Thomas on 10/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import UIKit

class WeatherFakeResponseData {
    
    var weatherCorrectData: Data {
        let bundle = Bundle(for: WeatherFakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    var weatherByNameCorrectData: Data {
        let bundle = Bundle(for: WeatherFakeResponseData.self)
        let url = bundle.url(forResource: "WeatherByName", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    let weatherIncorrectData = "Error".data(using: .utf8)
    let imageCorrectData = UIImage(named: "France")?.pngData()
    
    let responseOk = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responseKo = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    let responseNotHTTP = URLResponse(url: URL(string: "https://openclassrooms.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    
    class WeatherError: Error {}
    let error = WeatherError()
    
}
