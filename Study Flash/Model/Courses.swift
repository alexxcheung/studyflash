//
//  Topics.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/11/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//
import Foundation

var courseList = [Course]()

enum CourseState {
    case notStart
    case todayNotCompleted
    case todayCompleted
    case allCompleted
}

struct Course {
    var courseId: Int
    var courseTitle: String
    var courseSubtitle: String?
    var courseChapter: [Chapter]
    var courseProgress: CourseProgress
}

struct CourseProgress {
    var state: CourseState
    var dateOfExam: Date!
    var confidenceLevel: Double
    var completion = CourseCompletion()
    
    init() {
        state = .notStart
        confidenceLevel = 0.0
    }
}

struct CourseCompletion {
    
    var totalQuestion: Int
    var totalCompletedQuestion: Int
    var totalIncompletedQuestion: Int
    var completionRate: Double?
    //    var todayCompletedQuestion: Int
    
    init() {
        self.totalQuestion = 1
        self.totalCompletedQuestion = 0
        self.totalIncompletedQuestion = totalQuestion - totalCompletedQuestion
        self.completionRate = 0.0
    }
    
    func questionLeft() -> Int {
        return totalQuestion - totalCompletedQuestion
    }
    
    func calculateCompletionRate() -> Double {
        guard totalQuestion >= 1 else {return 0.0}
        return Double(totalCompletedQuestion * 100 / totalQuestion)
    }
}


