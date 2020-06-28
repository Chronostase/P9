//
//  TranslateViewController+UITextView.swift
//  GreaTrip
//
//  Created by Thomas on 10/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation
import UIKit

extension TranslateViewController: UITextViewDelegate {
    
    //Allow to clean editableTextView when user begin editing 
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        editableTextView.text = nil
    }
}
