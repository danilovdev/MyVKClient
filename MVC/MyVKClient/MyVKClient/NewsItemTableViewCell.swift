//
//  NewsItemTableViewCell.swift
//  MyVKClient
//
//  Created by Alexey Danilov on 11.02.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import UIKit

class NewsItemTableViewCell: UITableViewCell {
    
    @IBOutlet var sourceNameTitleLabel: UILabel!
    
    
    @IBOutlet var newsItemImageView: CustomImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
