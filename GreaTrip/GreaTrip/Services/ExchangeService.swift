//
//  ExchangeService.swift
//  GreaTrip
//
//  Created by Thomas on 24/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

class ExchangeService {
    
    let baseUrl =  "http://data.fixer.io/api/latest?access_key="
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func getExchangeRates(callback: @escaping (Result <Exchange?, ServiceError>) -> Void ) {
        guard let request = createExchangeRequest() else {
            callback(.failure(.error))
            return
        }
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    
                    callback(.failure(.error))
                    return
                    // Ne reçoit pas de réponse ou les datas / error
            }
            guard let exchangeRate = try? JSONDecoder().decode(Exchange.self, from: data) else {
                callback(.failure(.error))
                print("something wrong happend or here")
                // Ne réussit pas à récupérer l'objet
                return
            }
            
            callback(.success(exchangeRate))
        }
        task.resume()
    }
    
    func calculateTargetCurrency(_ rate: Double,_ userAmount: Double ) -> String {
        let translatedValue = userAmount * rate
        
        return String(translatedValue)
    }

    func createExchangeRequest() -> URLRequest? {
        
        guard let key = ApiKeys.value(for: "fixerIo"), let url = URL(string: baseUrl +  key) else {
            // ne peut pas construire l'url
            return nil
        }
        
        return URLRequest(url: url)
    }
}
