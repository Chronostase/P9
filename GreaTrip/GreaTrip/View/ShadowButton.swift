//
//  ShadowButton.swift
//  GreaTrip
//
//  Created by Thomas on 02/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import UIKit

class ShadowButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Look info
        
        setNeedsLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 1
        layer.shadowOffset = .zero
        
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderWidth = 1
    }
}
