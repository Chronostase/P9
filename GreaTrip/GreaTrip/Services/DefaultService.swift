//
//  DefaultService.swift
//  GreaTrip
//
//  Created by Thomas on 16/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

class DefaultService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    //Allow to have generics call method
    
    func getDecodedData<T: Decodable>(request: URLRequest, text: String? = nil, callback: @escaping (Result <T?, ServiceError>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                callback(.failure(.error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                callback(.failure(.badResponse))
                return
            }
            
            guard 200..<300 ~= response.statusCode else {
                callback(.failure(.invalidStatusCode(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                callback(.failure(.dataError))
                return
            }
            
            guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                callback(.failure(.decodingError))
                return
            }
            callback(.success(object))
        }
        task.resume()
    }
    
    //Call to get image 
    
    func getImage(request: URL, callback: @escaping (Result <Data?, ServiceError>) -> Void) {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                callback(.failure(.error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                callback(.failure(.badResponse))
                return
            }
            
            guard 200..<300 ~= response.statusCode else {
                callback(.failure(.invalidStatusCode(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                callback(.failure(.dataError))
                return
            }
            callback(.success(data))
        }
        task.resume()
    }
}
