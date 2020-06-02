//
//  ShadowTextView.swift
//  GreaTrip
//
//  Created by Thomas on 02/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import UIKit

class ShadowTextView: UITextView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Look info
        layoutSubviews()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .zero
        
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderWidth = 1
        textContainerInset = UIEdgeInsets(top: 15, left: 60, bottom: 0, right: 0)
    }
}
