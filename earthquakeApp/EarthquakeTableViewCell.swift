//
//  EarthquakeTableViewCell.swift
//  earthquakeApp
//
//  Created by Tomasz Gola on 13.07.2018.
//  Copyright © 2018 Tomasz Gola. All rights reserved.
//

import UIKit

class EarthquakeTableViewCell: UITableViewCell {
 
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var magnitudeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
