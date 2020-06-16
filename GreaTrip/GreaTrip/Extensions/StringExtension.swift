//
//  StringExtension.swift
//  GreaTrip
//
//  Created by Thomas on 15/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

extension String {
    
    // Extension to check if String is convertible to Int or Double
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    var isDouble: Bool {
        return Double(self) != nil
    }
    
}
