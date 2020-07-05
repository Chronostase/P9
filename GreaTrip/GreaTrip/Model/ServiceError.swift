//
//  ErrorEnum.swift
//  GreaTrip
//
//  Created by Thomas on 05/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case error
    case invalidStatusCode(statusCode: Int)
    case badResponse
    case dataError
    case decodingError
    case requestError
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .error:
            return Constants.Error.simpleError
        case .invalidStatusCode(let statusCode):
            return "\(Constants.Error.statusCodeError) status code: \(statusCode)"
        case .badResponse:
            return Constants.Error.responseError
        case .dataError:
            return Constants.Error.dataError
        case .decodingError:
            return Constants.Error.decodingError
        case .requestError:
           return Constants.Error.requestError
        }
    }
}
