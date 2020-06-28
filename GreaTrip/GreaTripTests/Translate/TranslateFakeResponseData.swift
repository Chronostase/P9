//
//  TranslateFakeResponseData.swift
//  GreaTripTests
//
//  Created by Thomas on 10/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

class TranslateFakeResponseData {
    var translateCorrectData: Data {
        let bundle = Bundle(for: TranslateFakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    let translateIncorrectData = "Error".data(using: .utf8)
    
    let responseOk = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responseKo = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    let responseNotHTTP = URLResponse(url: URL(string: "https://openclassrooms.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    
    class TranslateError: Error {}
    let error = TranslateError()
}
