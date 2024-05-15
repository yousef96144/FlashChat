//
//  cellformessage.swift
//  Flash Chat iOS13
//
//  Created by yousef Elaidy on 03/12/2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class cellformessage: UITableViewCell {
    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var lefimageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
