////
////  CourseData.swift
////  Study Flash
////
////  Created by Alex Cheung on 6/13/19.
////  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
////
//

//For importing

struct CourseData: Codable {
    var courses: [CourseInfo]
}

struct CourseInfo: Codable {
    var id: Int
    var title: String
    var subtitle: String
    var chapters: [Chapter]
}

struct Chapter: Codable {
    var id: Int
    var title: String
    var questions: [Question]?
}

struct Question: Codable {
    var id: Int
    var question: String
    var answers: [Answer]
    var explanation: String
}

struct Answer: Codable {
    var id: Int
    var body: String
    var isCorrect: Bool
}
