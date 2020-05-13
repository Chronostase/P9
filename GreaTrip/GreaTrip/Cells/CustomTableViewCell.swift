//
//  CustomTableViewCell.swift
//  GreaTrip
//
//  Created by Thomas on 08/05/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureAllCell(name: String, temperature: Int, image: Data) {
        temperatureLabel.text = "\(String(temperature))°"
        cityName.text = name
        weatherIcon.image = UIImage(data: image)
    }
    
    func configureJustTitle(name: String) {
        cityName.text = name 
    }
}
