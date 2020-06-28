//
//  TranslateService.swift
//  GreaTrip
//
//  Created by Thomas on 19/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

class TranslateService {
    
    //MARK: - Properties
    private let session: URLSession
    private let defaultService: DefaultService?
    private let baseUrl: URL?
    
    init(session: URLSession = URLSession(configuration: .default), baseUrl: URL? = nil) {
        self.session = session
        defaultService = DefaultService(session: session)
        self.baseUrl = baseUrl
    }
    
    
    //MARK: - Methods
    
    func getTranslation(text: String, callback: @escaping (Result <Translation?, ServiceError>) -> Void ) {
        guard let request = createTranslateRequest(with: text) else {
            callback(.failure(.error))
            return
        }
        defaultService?.getDecodedData(request: request, text: text, callback: callback)
    }
    
    //MARK: - Request
    
    private func createTranslateRequest(with parameter: String) -> URLRequest? {
        let translateConstants = Constants.Network.Translate.self
        
        guard let url = baseUrl else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = translateConstants.requestType
        
        guard let key = ApiKeys.value(for: translateConstants.cloudTranslater) else {
            return nil
        }
        
        let body = translateConstants.key + "\(key)" + translateConstants.firstParameter + "\(parameter)" + translateConstants.parameter
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
}
