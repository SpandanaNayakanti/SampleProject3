//
//  TableViewCell.swift
//  InfyProject
//
//  Created by Spandana Nayakanti on 12/11/18.
//  Copyright © 2018 Spandana. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var doors: UILabel!
    @IBOutlet var colour: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var milage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
