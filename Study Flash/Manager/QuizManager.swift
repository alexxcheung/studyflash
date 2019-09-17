//
//  QuizManager.swift
//  Study Flash
//
//  Created by Lukas Gauster on 31/05/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class QuizManager {
    
    // Save all questions here
    private var allQuestions = [Question]()
    
    // Save the game state here
    private var gameScore: GameScore?
    
    // Save information related to the current status of the quiz here
    private var currentQuestionIndex = -1
    private lazy var currentlySelectedAnswerIndices: [Int] = {
        return [Int]()
    }()
    
    func importQuestionFromCourseManager() {
        //TODO: chapter should be changed
        if let questions = courseManager.courseListFromJSON[courseManager.selectedCourseIndex!].chapters[0].questions {
            allQuestions = questions
        }
        
    }
    
    // MARK: - Set up quiz data
    func prepareQuestions() {
        // TODO: What if this fails? Catch error
        importQuestionFromCourseManager()
        
        gameScore = GameScore(time: 0, totalQuestions: allQuestions.count, correctQuestions: 0)
    }
    
    // MARK: - Current quiz state
    func getTotalAmountOfQuestionsToDisplay() -> Int {
        return allQuestions.count
    }
    
    func getCurrentQuestionNumberToDisplay() -> Int {
        return currentQuestionIndex + 1
    }
    
    func lastQuestionWasReached() -> Bool {
        return currentQuestionIndex == allQuestions.count - 1
    }
    
    func getGameScore() -> GameScore? {
        return gameScore
    }
    
    func anyAnswerSelected() -> Bool {
        return currentlySelectedAnswerIndices.count > 0
    }
    
    // MARK: Questions
    func getCurrentQuestion() -> Question? {
        
        guard currentQuestionIndex >= 0, currentQuestionIndex < allQuestions.count else {
            return nil
        }
        
        return allQuestions[currentQuestionIndex]
    }
    
    func advanceToNextQuestion() {
        
        // Increase counter to advance to the next question
        currentQuestionIndex += 1
        
        // Reset selected answers
        currentlySelectedAnswerIndices.removeAll()
    }
    
    func increaseScore(byAmount amount: Int) {
        gameScore?.correctQuestions += amount
    }
    
    func increaseTime(byAmount amount: Int) {
        gameScore?.time += amount
    }
    
    // MARK: - Answers
    func isAnswerAtIndexSelected(answerIndex: Int) -> Bool {
        return currentlySelectedAnswerIndices.contains(answerIndex)
    }
    
    func setAnswerSelection(forAnswerIndex index: Int, select: Bool) {
        if select {
            // If not already selected, select the answer now
            // That means, we add the answer index to the selected answers array
            if !isAnswerAtIndexSelected(answerIndex: index) {
                currentlySelectedAnswerIndices.append(index)
            }
        } else {
            // Deselect the answer
            // Just filter by answerIndex and remove the answer with the given index
            currentlySelectedAnswerIndices.removeAll { (answerIndex) -> Bool in
                return answerIndex == index
            }
        }
    }
    
    func getAnswerState(forAnswerAtIndex index: Int) -> QuestionAnswerState {
        
        // Check which status the answer should be in
        
        // First, check if answer was correct or incorrect
        if let currentQuestion = getCurrentQuestion() {
            
            if currentQuestion.answers[index].isCorrect {
                // Did the user select it?
                if currentlySelectedAnswerIndices.contains(index) {
                    // Answer correct AND user selected it!
                    return .CorrectlyAnswered
                } else {
                    // Answer correct, but user did not select it
                    return .CorrectButNotSelected
                }
            } else {
                // Did the user select it?
                if currentlySelectedAnswerIndices.contains(index) {
                    // Answer incorrecct AND user selected it!
                    return .IncorrectlyAnswered
                } else {
                    // Answer incorrect, but user did not select it
                    return .NotSelected
                }
            }
            
        } else {
            return .NotSelected
        }
    }
    
    // MARK: Save / load progress
    private func saveProgress(forQuestion: Question, answeredCorrectly correct: Bool) {
        // Save the question answer
    }
}

// MARK: Loading questions
extension QuizManager {
//    private func loadJson(filename fileName: String) -> [Question]? {
//        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(Questions.self, from: data)
//                return jsonData.questions
//
//            } catch {
//                print("error:\(error)")
//            }
//        }
//        return nil
//    }
}

struct GameScore {
    var time: Int
    var totalQuestions: Int
    var correctQuestions: Int = 0
}

enum QuestionAnswerState {
    case NotSelected
    case Selected
    case CorrectlyAnswered
    case IncorrectlyAnswered
    case CorrectButNotSelected
}
