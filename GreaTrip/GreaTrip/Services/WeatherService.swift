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
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    //MARK: - Methods
    
    func getWeather(callback: @escaping (Result <WeatherArray?, ServiceError>)  -> Void) {
        guard let request = createWeatherRequest() else {
            callback(.failure(.error))
            return 
            // Impossible de faire le call, cause ne peut pas récupérer l'url
        }
        GenericsCall().getData(request: request, callback: callback)
    }
    
    func getWeatherByName(cityName: String, callback: @escaping (Result <Weathers?, ServiceError>)  -> Void) {
        guard let request = createWeatherRequestByName(parameter: cityName) else {
            print("something wrong happend")
            callback(.failure(.error))
            return
            // Pas d'url
        }
        GenericsCall().getData(request: request, text: cityName, callback: callback)
    }
    
    func getImage(named imageName: String, callback: @escaping (Result <Data?, ServiceError>) -> Void) {
        guard let request = createImageRequest(iconName: imageName) else {
            
            return
            // Pas d'URL
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200  else {
                    
                    callback(.failure(.error))
                    // Ne reçoit pas de réponse ou les datas / error
                    return
            }
            let image = data
            print(image)
            callback(.success(image))
        }
        task.resume()
    }
    
    
    //MARK: - Requests
    
    private func createImageRequest(iconName: String) -> URL? {
        let weatherConstants = Constants.Network.Weather.self
        let imageUrl = URL(string: weatherConstants.imageUrl + "\(iconName)" + weatherConstants.imageSize)
        
        return imageUrl
    }
    
    private func createWeatherRequestByName(parameter: String) -> URLRequest? {
        let weatherConstants = Constants.Network.Weather.self
        
        guard let key = ApiKeys.value(for: weatherConstants.openWeatherMapId), let url = URL(string: weatherConstants.baseUrl + weatherConstants.cityNameParameter + parameter + weatherConstants.metricParameters + key) else {
            
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    private func createWeatherRequest() -> URLRequest? {
        let weatherConstants = Constants.Network.Weather.self
        
        guard let key = ApiKeys.value(for: weatherConstants.openWeatherMapId), let url = URL(string: weatherConstants.baseUrl + weatherConstants.groupParameter + key) else {
            
            return nil
        }
        print(url)
        
        return URLRequest(url: url)
    }
}
