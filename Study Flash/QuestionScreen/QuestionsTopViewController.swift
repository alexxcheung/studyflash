//
//  QuestionsTopViewController.swift
//  Study Flash
//
//  Created by Zarioiu Bogdan on 5/7/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

enum QuestionState {
    case Unchecked
    case Checked
}

class QuestionsTopViewController: UIViewController {
    
    var timerLabel: UILabel!
    var timeLabel: UILabel!
    var numberOfCards: UILabel!
    var cardsLeft: UILabel!
    
    var bottomButton: UIButton!
    
    // Questions
    private var questionsViewController: QuestionsTableViewController?
    
    // Question State
    private var questionState = QuestionState.Unchecked
    
    // Creating top container where all the labels will be placed
    var topContainerView: UIView!
    
    var quizManager = QuizManager()
    var timerCounter: Int =  0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        createTopView()
        createBottomView()
        constraintsForBottomView()
        
        setupQuizManager()
        setupNavigationBar()
        
        // Start quiz timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
        
    }
    
    //MARK: - Navigation
    @objc func handleContinueButtonPressed() {
 
        // Depends on status "check or not check"
        if questionState == .Checked {
            
            showNextQuestion()
            
            questionsViewController?.tableView.allowsMultipleSelection = true
            bottomButton.setTitle("Check", for: .normal)
            bottomButton.backgroundColor = .lightGray
            questionState = .Unchecked
            
        } else {
            
            // Did the user select any answer?
            if !quizManager.anyAnswerSelected() {
                // No answer selected, do nothing
                return
            }
            
            // Highlight the correct answers
            questionsViewController?.showAnswerResult()
            
            questionsViewController?.tableView.allowsSelection = false
            bottomButton.setTitle("Continue", for: .normal)
            bottomButton.backgroundColor = .primaryThemeColor
            questionState = .Checked
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "middleViewController" {
            if let destinationViewController = segue.destination as? QuestionsTableViewController {
                self.questionsViewController = destinationViewController
            }
        } else if segue.identifier == "showCourseResult" {
            if let destinationViewController = segue.destination as? CourseResultViewController {
                destinationViewController.gameScore = quizManager.getGameScore()
            }
        }

    }
}

// MARK: - Quiz Stuff
extension QuestionsTopViewController {

    private func setupQuizManager() {
        
        quizManager = QuizManager()
        quizManager.prepareQuestions()
        
        showNextQuestion()
        
    }
    
    private func showNextQuestion() {
        if quizManager.lastQuestionWasReached() {
            showQuizResultScreen()
        } else {
            quizManager.advanceToNextQuestion()
            self.reloadQuestionData()
        }
    }
    
    private func reloadQuestionData() {
        
        // Get the current question and make the question table view controller reload
        questionsViewController?.reloadData(withQuizManager: quizManager)
        
        // Also reload the question counter
        self.reloadQuestionCounter()
    }
    
    private func reloadQuestionCounter() {
        numberOfCards.text = "\(quizManager.getCurrentQuestionNumberToDisplay())/\(quizManager.getTotalAmountOfQuestionsToDisplay())"
        
    }
    
    private func showQuizResultScreen() {
        timer?.invalidate()
        performSegue(withIdentifier: "showCourseResult", sender: self)
    }
}

// MARK: Build UI
extension QuestionsTopViewController {
    
    func createTopView () {
        topContainerView = UIView()
        
        view.addSubview(topContainerView)
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        topContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        timerLabel = UILabel()
        timerLabel.text = NSLocalizedString("00:00:00", comment: "The time left to study")
        timerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        timeLabel = UILabel()
        timeLabel.text = NSLocalizedString("TIME", comment: "Time label")
        timeLabel.textColor = .gray
        timeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        let myStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        myStackView.axis = .vertical
        myStackView.distribution = .equalSpacing
        myStackView.alignment = .leading
        myStackView.spacing = 3
        
        myStackView.addArrangedSubview(timerLabel)
        myStackView.addArrangedSubview(timeLabel)
        
        self.view.addSubview(myStackView)
        
        myStackView.translatesAutoresizingMaskIntoConstraints = false
        myStackView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 25).isActive = true
        myStackView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: -10).isActive = true
        
        numberOfCards = UILabel()
        numberOfCards.text = ""
        numberOfCards.font = UIFont.boldSystemFont(ofSize: 20)
        
        cardsLeft = UILabel()
        cardsLeft.text = NSLocalizedString("QUESTION", comment: "LEFT label")
        cardsLeft.textColor = .gray
        cardsLeft.font = UIFont.boldSystemFont(ofSize: 12)
        
        let myStackView2 = UIStackView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        myStackView2.axis = .vertical
        myStackView2.distribution = .equalSpacing
        myStackView2.alignment = .trailing
        myStackView2.spacing = 3
        
        myStackView2.addArrangedSubview(numberOfCards)
        myStackView2.addArrangedSubview(cardsLeft)
        
        self.view.addSubview(myStackView2)
        
        myStackView2.translatesAutoresizingMaskIntoConstraints = false
        myStackView2.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -25).isActive = true
        myStackView2.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    
    func createBottomView() {
        
        bottomButton = UIButton()
        bottomButton.backgroundColor = UIColor.lightGray
        bottomButton.tintColor = .white
        bottomButton.setTitle("Check", for: .normal)
        bottomButton.titleLabel?.lineBreakMode = .byWordWrapping
        bottomButton.titleLabel?.textAlignment = .center
        bottomButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        bottomButton.titleEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: bottomButton.titleEdgeInsetBottom, right: -10)
        bottomButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
        bottomButton.addTarget(self, action: #selector(handleContinueButtonPressed), for: .touchUpInside)
        
        view.addSubview(bottomButton)
        
    }
    
    func constraintsForBottomView() {
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomButton.heightAnchor.constraint(equalToConstant: bottomButton.height).isActive = true
        bottomButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setupNavigationBar() {
        
        let navigationItem = self.navigationItem
        
        navigationItem.title = "Let's Go Study"
        //        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        let exitButton = UIButton(type: .custom)
        exitButton.setImage(UIImage(named: "CloseButton.png"), for: .normal)
        exitButton.addTarget(self, action: #selector(handleExitButton), for: .touchUpInside)
        exitButton.frame = .zero
        exitButton.tintColor = .white
        exitButton.contentMode = .scaleAspectFill
        
        let rightExitButton = UIBarButtonItem(customView: exitButton)
        rightExitButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        rightExitButton.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rightExitButton.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        navigationItem.rightBarButtonItem = rightExitButton
        
        
    }
    
    @objc func handleExitButton (_ sender: UIBarButtonItem) {
        if let navController = self.navigationController {
            navController.presentingViewController?.dismiss(animated: true, completion: {
                
            })
        }
    }
    
}

// MARK: - Timer
extension QuestionsTopViewController {
    @objc func updateTimeLabel() {
        timerCounter += 1
        timerLabel.text = timeString(time: TimeInterval(timerCounter))
        quizManager.increaseTime(byAmount: 1)
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
