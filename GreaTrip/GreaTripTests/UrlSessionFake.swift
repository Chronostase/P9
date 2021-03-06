//
//  UrlSessionFake.swift
//  GreaTripTests
//
//  Created by Thomas on 10/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

class UrlSessionFake: URLSession {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake(completionHandler: completionHandler, data: data, urlResponse: response, responseError: error)
        
        return task
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake(completionHandler: completionHandler, data: data, urlResponse: response, responseError: error)
        return task
    }
}

class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    init(completionHandler: ((Data?, URLResponse?, Error?) -> Void)?, data: Data?, urlResponse: URLResponse?, responseError: Error?) {
        self.completionHandler = completionHandler
        self.data = data
        self.urlResponse = urlResponse
        self.responseError = responseError
    }
    
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
    
    override func cancel() {}
}
