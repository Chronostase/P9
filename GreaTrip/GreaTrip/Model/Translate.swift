//
//  Translate.swift
//  GreaTrip
//
//  Created by Thomas on 19/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

struct Translation: Decodable {
    var data: TranslationArray
}

struct TranslationArray: Decodable {
    var translations: [TranslatedText]
}

struct TranslatedText: Decodable {
    var translatedText: String
}
