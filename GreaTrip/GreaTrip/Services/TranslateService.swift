//
//  TranslateService.swift
//  GreaTrip
//
//  Created by Thomas on 19/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

class TranslateService {
    
    //MARK- Properties
    
    private let baseUrl = "https://translation.googleapis.com/language/translate/v2?"
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    //MARK- Methods
    
    func getTranslation(text: String, callback: @escaping (Result <Translation?, ServiceError>) -> Void ) {
        guard let request = createTranslateRequest(with: text) else {
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
            guard let translatedText = try? JSONDecoder().decode(Translation.self, from: data) else {
                callback(.failure(.error))
                print("something wrong happend or here")
                // Ne réussit pas à récupérer l'objet
                return
            }
            
            callback(.success(translatedText))
        }
        task.resume()
    }
    
    func createTranslateRequest(with parameter: String) -> URLRequest? {
        
        guard let key = ApiKeys.value(for: "cloudTranslater"), let url = URL(string: baseUrl + parameter + key) else {
            // ne peut pas construire l'url
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = "&source=fr&target=en&format=text&key="
        request.httpBody = body.data(using: .utf8)
        return request
    }
}
