//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Anthony Ronca on 2/20/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // content of the tweet cell
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    
    @IBOutlet weak var TweetContent: UILabel!
    
    

}
