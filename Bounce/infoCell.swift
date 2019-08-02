//
//  infoCell.swift
//  Bounce
//
//  Created by Prithviraj Murthy on 20/07/19.
//  Copyright © 2019 Prithviraj Murthy. All rights reserved.
//

import UIKit

class infoCell: UITableViewCell {
    @IBOutlet weak var bookTime: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var travelTime: UILabel!
    @IBOutlet weak var estimatedPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
