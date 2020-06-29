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
    private let defaultService: DefaultService?
    private let baseUrl: String?
    
    init(session: URLSession = URLSession(configuration: .default), baseUrl: String? = nil) {
        self.session = session
        defaultService = DefaultService(session: session)
        self.baseUrl = baseUrl
    }
    
     //MARK: - Methods
    
    //Allow to get exchange rates
    
    func getExchangeRates(callback: @escaping (Result <Exchange?, ServiceError>) -> Void ) {
        guard let request = createExchangeRequest() else {
            callback(.failure(.error))
            return
        }
        defaultService?.getDecodedData(request: request, callback: callback)
    }
    
    //Calculate amount of currency with currency rates
    
    func calculateTargetCurrency(_ rate: Double,_ userAmount: Double ) -> String {
        let translatedValue = userAmount * rate
        
        return String(translatedValue)
    }
    
     //MARK: - Request

    private func createExchangeRequest() -> URLRequest? {
        let exchangeConstants = Constants.Network.Exchange.self
        
        guard let key = ApiKeys.value(for: exchangeConstants.fixerIo), let baseUrl = baseUrl, let url = URL(string: baseUrl +  key) else {
            // ne peut pas construire l'url
            return nil
        }
        
        return URLRequest(url: url)
    }
}
