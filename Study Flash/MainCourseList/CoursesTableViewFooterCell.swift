//
//  CoursesTableViewHeaderCell.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/28/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class CoursesTableViewFooterCell: UITableViewCell {

    @IBOutlet weak var grayLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = nil
        grayLine.backgroundColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
