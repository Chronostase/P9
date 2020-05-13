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
    
    private let baseUrl = "http://api.openweathermap.org/data/2.5/"
    private let commonParameters = "units=metric&APPID="
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    //MARK: - Call Api
    
    func getWeather(callback: @escaping (Result <WeatherArray?, ServiceError>)  -> Void) {
        guard let request = createWeatherRequest() else {
            callback(.failure(.error))
            return
        }
        print(request)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    
                    callback(.failure(.error))
                    return
            }
            
            guard let weather = try? JSONDecoder().decode(WeatherArray.self, from: data) else {
                callback(.failure(.error))
                return
            }
            
            callback(.success(weather))
        }
        task.resume()
    }
    
    func getWeatherWithUserInteract(cityName: String, callback: @escaping (Result <Weathers?, ServiceError>)  -> Void) {
        guard let request = createWeatherRequestWithUserInteract(parameter: cityName) else {
            print("something wrong happend")
            callback(.failure(.error))
            return
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    print("something wrong happend here")
                    callback(.failure(.error))
                    return
            }
            
            guard let weather = try? JSONDecoder().decode(Weathers.self, from: data) else {
                callback(.failure(.error))
                print("something wrong happend or here")
                return
            }
            
            callback(.success(weather))
        }
        task.resume()
    }
    
    func getImage(named imageName: String, callback: @escaping (Bool, Data?) -> Void) {
        guard let request = createImageRequest(iconName: imageName) else {
            return
        }
        //        let url = url
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200  else {
                    
                    callback(false, nil)
                    return
            }
            let image = data
            print(image)
            callback(true, image)
        }
        task.resume()
    }
    
    //MARK: - Setup
    
    func createImageRequest(iconName: String) -> URL? {
        let imageUrl = URL(string: "http://openweathermap.org/img/wn/\(iconName)@2x.png")
        
        return imageUrl
    }
    
    func createWeatherRequestWithUserInteract(parameter: String) -> URLRequest? {
        
        print(baseUrl + "weather?q=" + parameter + "&\(commonParameters)" + "myKey")
        guard let key = ApiKeys.value(for: "openWeatherMapAppId"), let url = URL(string: baseUrl + "weather?q=" + parameter + "&\(commonParameters)" + key) else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    func createWeatherRequest() -> URLRequest? {
        let parameters = "group?id=2984114,5128581&units=metric&APPID="
        
        guard let key = ApiKeys.value(for: "openWeatherMapAppId"), let url = URL(string: baseUrl + parameters + key) else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}
