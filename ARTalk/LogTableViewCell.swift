//
//  LogTableViewCell.swift
//  ARTalk
//
//  Created by Hing Chung on 28/1/2024.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    @IBOutlet var timestamp: UILabel!
    @IBOutlet var log: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
