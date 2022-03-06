//
//  AppTableViewCell.swift
//  iOS-Pratice-App
//
//  Created by Fernando on 06/03/22.
//

import UIKit

class AppTableViewCell: UITableViewCell {

    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var nameApp: UILabel!
    @IBOutlet weak var priceApp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected) {
            self.imageApp.alpha = 0.3
        } else {
            self.imageApp.alpha = 1
        }
    }

}
