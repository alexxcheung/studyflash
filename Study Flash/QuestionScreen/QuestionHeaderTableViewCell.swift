//
//  QuestionHeaderTableViewCell.swift
//  Study Flash
//
//  Created by Alex Cheung on 6/4/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class QuestionHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var grayLine: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .white
        
        grayLine.backgroundColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
