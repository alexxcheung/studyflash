//
//  QuestionTableViewCell.swift
//  Study Flash
//
//  Created by Zarioiu Bogdan on 5/15/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    var answerState: QuestionAnswerState = .NotSelected {
        didSet {
            self.updateView()
        }
    }

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var checkBox: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: true)
        
        checkBox.image = selected ? UIImage(named: "Selected.png") : UIImage(named: "NotSelectedGray.png")
        
        self.backgroundColor = selected ? .primaryThemeColor : .clear
        self.questionLabel.textColor = selected ? .white : .black
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        answerState = .NotSelected
    }
    
    func updateView() {
        
        // Change row appearance based on state
        switch answerState {
        case .NotSelected:
            self.backgroundColor = .clear
            self.questionLabel.textColor = .black
            checkBox.image = UIImage(named: "NotSelectedGray.png")
            
        case .Selected:
            self.backgroundColor = .primaryThemeColor
            self.questionLabel.textColor = .white
            checkBox.image = UIImage(named: "Selected.png")
            
        case .IncorrectlyAnswered:
            self.backgroundColor = .wrongAnswerRedColor
            self.questionLabel.textColor = .white
            checkBox.image = UIImage(named: "Incorrect.png")
            
        case .CorrectlyAnswered:
            self.backgroundColor = .rightAnswerGreenColor
            self.questionLabel.textColor = .white
            checkBox.image = UIImage(named: "Selected.png")
            
        case .CorrectButNotSelected:
            self.backgroundColor = .rightAnswerGreenColor
            self.questionLabel.textColor = .white
            checkBox.image = UIImage(named: "NotSelectedWhite.png")
        }
        
    }
}


