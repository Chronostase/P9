//
//  TranslateServiceTest.swift
//  GreaTripTests
//
//  Created by Thomas on 24/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import XCTest
@testable import GreaTrip

class TranslateServiceTest: XCTestCase {
    private let translateFakeResponseData = TranslateFakeResponseData()
    private let expectation = XCTestExpectation(description: "Wait for queue change.")
    
    func testGetTranslateShouldGetFailedCallbackIfError() {
        // Given
        let translateService = TranslateService(session: UrlSessionFake(data: nil, response: nil, error: translateFakeResponseData.error ), baseUrl: Constants.Network.Translate.baseUrl)
        
        //When
        translateService.getTranslation(text: "Bonjour") { result in
            switch result {
            case .success(let translate):
                XCTAssertNil(translate)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldGetFailedCallbackIfResponseIsNotHTTP() {
        // Given
        let translateService = TranslateService(session: UrlSessionFake(data: translateFakeResponseData.translateCorrectData, response: translateFakeResponseData.responseNotHTTP, error: nil), baseUrl: Constants.Network.Translate.baseUrl)
        
        //When
        translateService.getTranslation(text: "Bonjour") { result in
            switch result {
            case .success(let translate):
                XCTAssertNil(translate)
                
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
        let translateService = TranslateService(session: UrlSessionFake(data: translateFakeResponseData.translateCorrectData, response: translateFakeResponseData.responseKo, error: nil), baseUrl: Constants.Network.Translate.baseUrl)
        
        //When
        translateService.getTranslation(text: "Bonjour") { result in
            switch result {
            case .success(let translate):
                XCTAssertNil(translate)
                
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
        let translateService = TranslateService(session: UrlSessionFake(data: translateFakeResponseData.translateIncorrectData, response: translateFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Translate.baseUrl)
        
        //When
        translateService.getTranslation(text: "Bonjour") { result in
            switch result {
            case .success(let translate):
                XCTAssertNil(translate)
                
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
        let translateService = TranslateService(session: UrlSessionFake(data: nil, response: nil, error: nil), baseUrl: Constants.Network.Translate.baseUrl)
        
        //When
        translateService.getTranslation(text: "Bonjour") { result in
            switch result {
            case .success(let translate):
                XCTAssertNil(translate)
                
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
        let translateService = TranslateService(session: UrlSessionFake(data: translateFakeResponseData.translateCorrectData, response: translateFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Translate.baseUrl)
        
        //When
        translateService.getTranslation(text: "Bonjour") { result in
            switch result {
            case .success(let translate):
                XCTAssertNotNil(translate)
                let response = "Hello"
                XCTAssertEqual(translate?.data.translations.first?.translatedText, response)
                
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
        let translateService = TranslateService(session: UrlSessionFake(data: nil, response: nil, error: nil))
        
        //When
        translateService.getTranslation(text: "Bonjour") { result in
            switch result {
            case .success(let translate):
                XCTAssertNil(translate)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
}
