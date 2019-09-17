//
//  Algorithm.swift
//  Study Flash
//
//  Created by 李宇恒 on 13/6/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

enum Stages {
    case revision(daysRevision: Int)
    case simulation(daysSimulation: Double)
}

class Algorithm {
        
    public func getSchedule(forQuestions allQuestions: [Int], totalDays: Double) -> [[Int]] {
        
        let questionsCount = allQuestions.count    //how many questions in question bank
        let daysLeft = totalDays    //must be larger than 1
        
        //Return how many days for simulation
        let daysSimulation = defineDaysSimulation(daysLeft).rounded()
        
        //Return how many days for revision
        let daysRevision = Int(daysLeft - daysSimulation)
        
        //        print("days for revision:",daysRevision)
        
        
        var recallTime = 0    //how many times that the same question appear
        
        //Calculate the repetition frequency
        switch daysRevision {
        case 0..<3:
            recallTime = 1
        case 3..<7:
            recallTime = 2
        case 7..<14:
            recallTime = 3
        case 14..<26:
            recallTime = 4
        default:
            recallTime = 5
        }
        
        //        print("recall time:",recallTime)
        
        
        
        //Return number of group
        let groupOfQuestion = grouppingQuestions(daysRevision)
        
        //        print("number of groups:",groupOfQuestion)
        
        
        //The range of group
        let groupRange = 0 ..< groupOfQuestion
        
        
        var questionId = 0
        var groupInQuestions = [Int]()
        
        //Create items based on quantity of questions
        groupInQuestions = Array(repeating: 0, count: questionsCount)
        
        
        //Assign group for all the questions
        while questionId < questionsCount {
            for g in groupRange {
                if questionId >= questionsCount {
                    continue
                }
                groupInQuestions[questionId] += g
                questionId += 1
                
            }
        }
        
        
        var groupInDay = [[Int]]()
        let dayRange = 0..<daysRevision
        
        //Create arrays based on number of revision days
        for _ in dayRange {
            groupInDay.append([])
        }
        
        
        var repetition = 0    //x-th time that the question displayed
        
        var r = repetitionMode(repetition: repetition)
        
        //Assign group in each day
        while repetition < recallTime {
            
            for g in groupRange {
                groupInDay[g+r] += [g]
            }
            repetition += 1
            r = repetitionMode(repetition: repetition)
            
        }
        
        //Put questionId in each group
        var questionsInGroup = [[Int]]()
        for _ in groupRange {
            questionsInGroup.append([])
        }
        
        var value = 0
        while value < groupOfQuestion {
            for (i, group) in groupInQuestions.enumerated() {
                if group == value {
                    questionsInGroup[value].append(i)
                }
            }
            value += 1
        }
        
        //Put questionId in everyday
        var questionIdInDay = [[Int]]()
        for _ in dayRange {
            questionIdInDay.append([])
        }
        
        var initialValue = 0
        while initialValue < groupOfQuestion {
            for (i, day) in groupInDay.enumerated() {
                if day.contains(initialValue) {
                    questionIdInDay[i] += questionsInGroup[initialValue]
                }
            }
            initialValue += 1
        }
        
        return questionIdInDay
    }
    
    //Return which day to revise based on spaced repetition
    private func repetitionMode(repetition: Int) -> Int {
        if repetition == 0 {
            return 0
        } else if repetition == 1 {
            return 1
        } else if repetition == 2 {
            return 4
        } else if repetition == 3 {
            return 10
        } else {
            return 18
        }
    }
    
    //Calculate how many groups for questions
    private func grouppingQuestions(_ daysRevision: Int) -> Int {
        if daysRevision < 3 {
            return daysRevision
        } else if daysRevision < 7 {
            return daysRevision - 1
        } else if daysRevision < 14 {
            return daysRevision - 4
        } else if daysRevision < 26 {
            return daysRevision - 10
        } else {
            return daysRevision - 18
        }
    }
    
    //Calculate how many days for simulation
    private func defineDaysSimulation(_ daysLeft: Double) -> Double {
        if daysLeft > 7.0 {
            return (daysLeft/7.0)
            
        } else {
            return 1.0
            
        }
    }
    
}

