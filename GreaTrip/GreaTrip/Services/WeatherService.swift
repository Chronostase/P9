//
//  WeatherService.swift
//  GreaTrip
//
//  Created by Thomas on 29/04/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

class WeatherService {
    
    //MARK: - Properties
    
    private let session: URLSession
    private let defaultService: DefaultService?
    private let baseUrl: String?
    
    
    init(session: URLSession = URLSession(configuration: .default), baseUrl: String? = nil) {
        self.session = session
        defaultService = DefaultService(session: session)
        self.baseUrl = baseUrl
    }
    
    //MARK: - Methods
    
    //Allow to get weather
    
    func getWeather(callback: @escaping (Result <WeatherArray?, ServiceError>) -> Void) {
        guard let request = createWeatherRequest() else {
            callback(.failure(.requestError))
            return 
        }
        defaultService?.getDecodedData(request: request, callback: callback)
    }
    
    //Allow to get weather when user type cityName
    
    func getWeatherByName(cityName: String, callback: @escaping (Result <Weathers?, ServiceError>)  -> Void) {
        guard let request = createWeatherRequestByName(parameter: cityName) else {
            callback(.failure(.requestError))
            return
        }
        defaultService?.getDecodedData(request: request, text: cityName, callback: callback)
    }
    
    //Allow to get image
    
    func getImage(named imageName: String, callback: @escaping (Result <Data?, ServiceError>) -> Void) {
        guard let request = createImageRequest(iconName: imageName) else {
            callback(.failure(.requestError))
            return
        }
        defaultService?.getImage(request: request, callback: callback)
    }
    
    
    //MARK: - Requests
    
    private func createImageRequest(iconName: String) -> URL? {
        let weatherConstants = Constants.Network.Weather.self
        let imageUrl = URL(string: weatherConstants.imageUrl + "\(iconName)" + weatherConstants.imageSize)
        return imageUrl
    }
    
    private func createWeatherRequestByName(parameter: String) -> URLRequest? {
        let weatherConstants = Constants.Network.Weather.self
        
        guard let key = ApiKeys.value(for: weatherConstants.openWeatherMapId), let baseUrl = baseUrl, let url = URL(string: baseUrl + weatherConstants.cityNameParameter + parameter + weatherConstants.metricParameters + key) else {
            
            return nil
        }
        return URLRequest(url: url)
    }
    
    private func createWeatherRequest() -> URLRequest? {
        let weatherConstants = Constants.Network.Weather.self
        
        guard let key = ApiKeys.value(for: weatherConstants.openWeatherMapId),let baseUrl = baseUrl, let url = URL(string: baseUrl + weatherConstants.groupParameter + key) else {
            
            return nil
        }
        print(url)
        
        return URLRequest(url: url)
    }
}
