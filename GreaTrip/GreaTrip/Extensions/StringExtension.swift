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
    
    //Format text to request convention
    
    var formattedToRequest: String {
        let charactersNeedModifications = [" ": "%20", ".": ""]
        var formattedText = self.trimmingCharacters(in: .whitespacesAndNewlines)
        charactersNeedModifications.forEach { formattedText = formattedText.replacingOccurrences(of: $0.key, with: $0.value) }
        return formattedText
    }
    
    //Check if a string is convertible to Int or Double
    
    func isConvertiBleToIntOrDouble() -> Bool {
        if self.isDouble || self.isInt {
            return true
        } else {
            return false
        }
    }
    
}
