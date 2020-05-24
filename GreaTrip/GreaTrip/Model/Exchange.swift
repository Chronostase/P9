//
//  Exchange.swift
//  GreaTrip
//
//  Created by Thomas on 24/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

struct Exchange: Decodable {
    let base: String
    let date: String
    let rates: [String: Double]
}
