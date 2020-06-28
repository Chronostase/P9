//
//  ExchangeServiceTest.swift
//  GreaTripTests
//
//  Created by Thomas on 24/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import XCTest
@testable import GreaTrip

class ExchangeServiceTest: XCTestCase {
    private let exchangeFakeResponseData = ExchangeFakeResponseData()
    private let expectation = XCTestExpectation(description: "Wait for queue change.")
    
    func testGetTranslateShouldGetFailedCallbackIfError() {
        // Given
        let exchangeService = ExchangeService(session: UrlSessionFake(data: nil, response: nil, error: exchangeFakeResponseData.error), baseUrl: Constants.Network.Exchange.baseUrl)
        
        //When
        exchangeService.getExchangeRates { result in
            switch result {
            case .success(let exchangeRates):
                XCTAssertNil(exchangeRates)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldGetFailedCallbackIfNoErrorNoData() {
        // Given
        let exchangeService = ExchangeService(session: UrlSessionFake(data: nil, response: nil, error: nil), baseUrl: Constants.Network.Exchange.baseUrl)
        
        //When
        exchangeService.getExchangeRates { result in
            switch result {
            case .success(let exchangeRates):
                XCTAssertNil(exchangeRates)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldGetFailedCallbackIfNotHTTPResponse() {
        // Given
        let exchangeService = ExchangeService(session: UrlSessionFake(data: exchangeFakeResponseData.ExchangeCorrectData, response: exchangeFakeResponseData.responseNotHTTP, error: nil), baseUrl: Constants.Network.Exchange.baseUrl)
        
        //When
        exchangeService.getExchangeRates { result in
            switch result {
            case .success(let exchangeRates):
                XCTAssertNil(exchangeRates)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldGetFailedCallbackIfBadResponse() {
        // Given
        let exchangeService = ExchangeService(session: UrlSessionFake(data: exchangeFakeResponseData.ExchangeCorrectData, response: exchangeFakeResponseData.responseKo, error: nil), baseUrl: Constants.Network.Exchange.baseUrl)
        
        //When
        exchangeService.getExchangeRates { result in
            switch result {
            case .success(let exchangeRates):
                XCTAssertNil(exchangeRates)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let exchangeService = ExchangeService(session: UrlSessionFake(data: exchangeFakeResponseData.exchangeIncorrectData, response: exchangeFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Exchange.baseUrl)
        
        //When
        exchangeService.getExchangeRates { result in
            switch result {
            case .success(let exchangeRates):
                XCTAssertNil(exchangeRates)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldGetSuccedCallbackIfNoErrorCorrectData() {
        // Given
        let exchangeService = ExchangeService(session: UrlSessionFake(data: exchangeFakeResponseData.ExchangeCorrectData, response: exchangeFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Exchange.baseUrl)
        
        //When
        exchangeService.getExchangeRates { result in
            switch result {
            case .success(let exchangeRates):
                XCTAssertNotNil(exchangeRates)
                let usdRates = 1.13508
                guard let exchangeRates = exchangeRates else {
                    return
                }
                let filterdData = exchangeRates.rates.filter { $0.key == Constants.Exchange.dollar }
                guard let rate = filterdData.values.first else {
                    return
                }
                XCTAssertEqual(usdRates, rate)
            case .failure(let error) :
                XCTAssertNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldGetSuccedCallbackAndCorrectResultIfNoErrorCorrectData() {
        // Given
        let exchangeService = ExchangeService(session: UrlSessionFake(data: exchangeFakeResponseData.ExchangeCorrectData, response: exchangeFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Exchange.baseUrl)
        
        //When
        exchangeService.getExchangeRates { result in
            switch result {
            case .success(let exchangeRates):
                XCTAssertNotNil(exchangeRates)
                guard let exchangeRates = exchangeRates else {
                    return
                }
                let filterdData = exchangeRates.rates.filter { $0.key == Constants.Exchange.dollar }
                guard let rate = filterdData.values.first else {
                    return
                }
                
                let result = exchangeService.calculateTargetCurrency(rate, 3.5)
                XCTAssertEqual(result, "3.97278")
            case .failure(let error) :
                XCTAssertNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldGetFailedCallbackIfBadRequest() {
        // Given
        let exchangeService = ExchangeService(session: UrlSessionFake(data: nil, response: exchangeFakeResponseData.responseKo, error: nil))
        
        //When
        exchangeService.getExchangeRates { result in
            switch result {
            case .success(let exchangeRates):
                XCTAssertNil(exchangeRates)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
}
