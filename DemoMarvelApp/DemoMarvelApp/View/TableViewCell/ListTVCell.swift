//
//  ListTVCell.swift
//  DemoMarvelApp
//
//  Created by Rahul Ranjan Kashyap on 02/12/20.
//  Copyright © 2020 Rahul Ranjan Kashyap. All rights reserved.
//

import UIKit

class ListTVCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonAddDelete: UIButton!
    @IBOutlet weak var imageViewMarvel: UIImageView!
    
    @IBOutlet weak var labelDesc: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
