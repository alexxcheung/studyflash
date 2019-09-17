//
//  QuestionsTableViewController.swift
//  Study Flash
//
//  Created by Zarioiu Bogdan on 5/15/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var quizManager: QuizManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.bounces = false
        
        tableView.register(UINib(nibName: "QuestionHeaderTableViewCell", bundle: nil).self, forCellReuseIdentifier: "QuestionCell")
 
        constraintsForQuestionsView()
        
    }
    
    func reloadData(withQuizManager manager: QuizManager) {
        self.quizManager = manager
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // guard the last question
        guard let currentQuestion = quizManager?.getCurrentQuestion() else {
            return 0
        }
        // TODO: remove forceunrapping
        return currentQuestion.answers.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionHeaderTableViewCell
        
        if let currentQuestion = quizManager?.getCurrentQuestion() {
            headerCell?.questionLabel.text = currentQuestion.question
        }
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // TODO: remove forceunrapping
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuestionTableViewCell
        
        if let currentQuestion = quizManager?.getCurrentQuestion() {
            let answerIndex = indexPath.row
            if answerIndex >= 0 {
                cell.questionLabel.text = currentQuestion.answers[answerIndex].body
                cell.updateView()
            }
        }
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // We need the quiz manager for this to work properly
        guard let quizManager = quizManager else {
            tableView.deselectRow(at: indexPath, animated: false)
            return
        }
        
        // Check if the answer was already selected
        if quizManager.isAnswerAtIndexSelected(answerIndex: indexPath.row) {
            // case: it was already selected
            
            // Remove the answer index and deselect the row
            quizManager.setAnswerSelection(forAnswerIndex: indexPath.row, select: false)
            tableView.deselectRow(at: indexPath, animated: false)
            
            if let cell = self.tableView.cellForRow(at: indexPath) as? QuestionTableViewCell {
                cell.answerState = .NotSelected
            }
            
        } else {
            // Select the answer
            quizManager.setAnswerSelection(forAnswerIndex: indexPath.row, select: true)
            
            if let cell = self.tableView.cellForRow(at: indexPath) as? QuestionTableViewCell {
                cell.answerState = .Selected
            }
        }
    }
    
    func constraintsForQuestionsView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}

// MARK: - Quiz
extension QuestionsTableViewController {
    
    func showAnswerResult() {
        
        guard let currentQuestion = quizManager?.getCurrentQuestion(), let quizManager = quizManager  else {
            return
        }
        // TODO: remove forceunrapping
        // Iterate through all answers and change the state
        var allAnswersCorrect = true
        for i in 0..<currentQuestion.answers.count {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? QuestionTableViewCell {
                let answerState = quizManager.getAnswerState(forAnswerAtIndex: i)
                
                // Only if all states returned are either correctly answered OR notselected:
                // User has 100% answered the given question correctly
                
                if answerState == .CorrectlyAnswered || answerState == .NotSelected {
                    // All fine!
                } else {
                    // Incorrect answer
                    allAnswersCorrect = false
                }
                
                cell.answerState = answerState
            }
        }
        
        if allAnswersCorrect {
            quizManager.increaseScore(byAmount: 1)
        }
    }
}




