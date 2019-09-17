//
//  CoursesDetailHeaderCell.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/14/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class CoursesDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var courseCompletionRateLabel: UILabel!
    @IBOutlet weak var courseCompletionLabel: UILabel!
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    let numberOfQuestion = courseManager.allCourses[courseManager.selectedCourseIndex].courseProgress.completion.totalQuestion
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
        courseCompletionRateLabel.textColor = .purpleThemeColor

        setupDetailDescription(numberOfQuestion: numberOfQuestion)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupDetailDescription(numberOfQuestion: Int) {
        
        let normalText  = "Your study plan of today includes "
        let normalString = NSMutableAttributedString(string:normalText)
        
        let boldQuestionNo = "\(numberOfQuestion) questions " // need to be changed
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:boldQuestionNo, attributes:attrs)
        normalString.append(attributedString)
        
        let normalText2 = "about the following topics:"
        let normalString2 = NSMutableAttributedString(string: normalText2)
        normalString.append(normalString2)
        
        detailDescription.attributedText = normalString
    }
    
}
