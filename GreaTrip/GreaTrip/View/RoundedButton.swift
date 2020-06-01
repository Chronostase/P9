//
//  RoundedButton.swift
//  GreaTrip
//
//  Created by Thomas on 01/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        layoutIfNeeded()
//        layer.cornerRadius = bounds.height / 2
//        layer.borderWidth = 3
//        layer.borderColor = UIColor.darkGray.cgColor
//        imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowRadius = 2
//        layer.shadowOpacity = 0.2
//        layer.shadowOffset = .zero
    }
}
