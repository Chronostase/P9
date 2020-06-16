//
//  GenericsCall.swift
//  GreaTrip
//
//  Created by Thomas on 16/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

class GenericsCall {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    public func getData<T: Decodable>(request: URLRequest, text: String? = nil, callback: @escaping (Result <T?, ServiceError>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                print(error?.localizedDescription ?? Constants.Error.dataError)
                callback(.failure(.error))
                return
            }
            guard error == nil else {
                print(error?.localizedDescription ?? Constants.Error.simpleError)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print(error?.localizedDescription ?? Constants.Error.responseError)
                return
            }
            guard 200..<300 ~= response.statusCode else {
                print(error?.localizedDescription ?? Constants.Error.statusCodeError)
                return
            }
            
            guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                callback(.failure(.error))
                print(error?.localizedDescription ?? Constants.Error.decodingError)
                // Ne réussit pas à récupérer l'objet
                return
            }
            
            callback(.success(object))
            //            do {
            //                let object = try JSONDecoder().decode(T.self, from: data)
            //                callback(.success(object))
            //            } catch let error as DecodingError {
            //                print(error.localizedDescription)
            //            }
        }
        task.resume()
    }
}
