//
//  ExchangeService.swift
//  GreaTrip
//
//  Created by Thomas on 24/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

class ExchangeService {
    
     //MARK: - Properties
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
     //MARK: - Methods
    
    func getExchangeRates(callback: @escaping (Result <Exchange?, ServiceError>) -> Void ) {
        guard let request = createExchangeRequest() else {
            callback(.failure(.error))
            return
        }
        GenericsCall().getData(request: request, callback: callback)
    }
    
    func calculateTargetCurrency(_ rate: Double,_ userAmount: Double ) -> String {
        let translatedValue = userAmount * rate
        
        return String(translatedValue)
    }
    
     //MARK: - Request

    private func createExchangeRequest() -> URLRequest? {
        let exchangeConstants = Constants.Network.Exchange.self
        
        guard let key = ApiKeys.value(for: exchangeConstants.fixerIo), let url = URL(string: exchangeConstants.baseUrl +  key) else {
            // ne peut pas construire l'url
            return nil
        }
        
        return URLRequest(url: url)
    }
}
