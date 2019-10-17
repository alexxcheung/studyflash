//
//  TopicsTableViewCell.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/11/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//
import UIKit

class CoursesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseTopic: UILabel!
    @IBOutlet weak var courseState: UILabel!
    @IBOutlet weak var grayLine: UIView!
    
    var courseCompletion: Double?
    
    var courseViewModel: CourseViewModel! {
        didSet {
            courseTitle?.text = courseViewModel.courseTitle
            courseTopic?.text = courseViewModel.courseSubtitle
            courseState?.text = courseViewModel.courseState
            courseState?.textColor = courseViewModel.courseStateTextColor
        }
    }
    
    override func awakeFromNib() {
        //orginal formatting
        courseTitle.textColor = .primaryThemeColor
        
        grayLine.backgroundColor = .gray

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
   
}



