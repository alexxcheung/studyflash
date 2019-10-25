//
//  courseViewModel.swift
//  Study Flash
//
//  Created by Alex Cheung on 15/8/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import Foundation
import UIKit

struct CourseViewModel {
    let courseTitle: String
    let courseSubtitle: String?
    let courseState: String
    let courseStateTextColor: UIColor
    let courseCompletion: Double
    
    // Dependency Injection
    init(course: Course) {
        self.courseTitle = course.courseTitle
        
        self.courseSubtitle = course.courseSubtitle
        self.courseCompletion = course.courseProgress.completion.calculateCompletionRate()
        
        if course.courseProgress.state == .notStart {
            self.courseState = "New Course!"
            self.courseStateTextColor = .primaryThemeColor
        } else {
            self.courseState = String(courseCompletion) + "% Completed"
            self.courseStateTextColor = .darkGray
        }
    }
    

}
