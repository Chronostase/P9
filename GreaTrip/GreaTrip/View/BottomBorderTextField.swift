//
//  BottomBorderTextFields.swift
//  GreaTrip
//
//  Created by Thomas on 02/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import UIKit

class BottomBorderTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Look info
//        layoutSubviews()
        setNeedsLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 0
    }

}
