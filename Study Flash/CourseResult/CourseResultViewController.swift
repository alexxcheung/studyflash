//
//  CourseResultViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/29/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class CourseResultViewController: UIViewController {

    var gameScore: GameScore?
    let myButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupNavigationBar()
        setupBottomButton()
        setupBottomView()
        setupUpperView()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//
//        let destination = segue.destination as! MainCourseListController
//        destination.isTodayCourseFinished = true
        
        UserDefaults.standard.set(false, forKey: "isCourseSelected")
        UserDefaults.standard.synchronize()
    }
    
}

extension CourseResultViewController {
    
    func setupBottomButton() {
        myButton.backgroundColor = UIColor.primaryThemeColor
        myButton.tintColor = .white
        myButton.setTitle("End Study Session", for: .normal)
        myButton.titleLabel?.lineBreakMode = .byWordWrapping
        myButton.titleLabel?.textAlignment = .center
        myButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        myButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: myButton.titleEdgeInsetBottom, right: -10)
        myButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        myButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(myButton)
        
        //constraint
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.heightAnchor.constraint(equalToConstant: myButton.height).isActive = true
        myButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    @objc private func buttonAction(sender: UIButton!) {
        sender.flash()
        
        if let navController = self.navigationController {
            
            updateProgress()
            
            navController.presentingViewController?.dismiss(animated: true, completion: {
                //
            })
        }
    }
    
    func updateProgress() {
        
        courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.state = .todayCompleted
        
        //TODO: - totalQuestion should not be 0
        if gameScore!.totalQuestions != 0 {
            courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.completion.totalCompletedQuestion = gameScore!.totalQuestions
            
            
            //confidence level
            let confidenceLevel = courseManager.calculateConfidenceLevel(correctNo: gameScore!.correctQuestions, totalQuestion: gameScore!.totalQuestions)
            
            courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.confidenceLevel = confidenceLevel
        }
        
        UserDefaults.standard.set(true, forKey: "isTodayCourseFinished")
        UserDefaults.standard.synchronize()
        
    }
    
    func setupBottomView() {
        
        guard let gameScore = gameScore else {
            return
        }
        
        let myTitle = UILabel()
        let myComment = UILabel()
        
        myTitle.font = .boldSystemFont(ofSize: 22)
        myTitle.text = "Congratulations!"
        myTitle.textAlignment = .left
        
        myComment.font = .systemFont(ofSize: 14)
        myComment.text = "Great job, you answered all questions of today's study plan - keep rocking!"
        myComment.textAlignment = .left
        myComment.lineBreakMode = .byWordWrapping
        myComment.numberOfLines = 3
        
        let myStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        myStackView.axis = .vertical
        myStackView.distribution = .equalSpacing
        myStackView.alignment = .leading
        myStackView.spacing = 5.0

        myStackView.addArrangedSubview(myTitle)
        myStackView.addArrangedSubview(myComment)
        
        let myTimeTaken = UILabel()
        let myTimeTakenLabel = UILabel()
        
        myTimeTaken.font = .boldSystemFont(ofSize: 22)
        myTimeTaken.text = timeString(time: TimeInterval(gameScore.time))
        myTimeTaken.textAlignment = .left
        
        myTimeTakenLabel.font = .boldSystemFont(ofSize: 12)
        myTimeTakenLabel.textColor = .gray
        myTimeTakenLabel.text = "TIME TAKEN"
        myTimeTakenLabel.textAlignment = .left
        
        let myStackView2 = UIStackView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        myStackView2.axis = .vertical
        myStackView2.distribution = .equalSpacing
        myStackView2.alignment = .leading
        myStackView2.spacing = 2.0
        
        myStackView2.addArrangedSubview(myTimeTaken)
        myStackView2.addArrangedSubview(myTimeTakenLabel)
        
//        self.view.addSubview(myStackView2)
//
//        myStackView2.translatesAutoresizingMaskIntoConstraints = false
//        myStackView2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
//        myStackView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        myStackView2.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150).isActive = true
        
        let myResult = UILabel()
        let myResultLabel = UILabel()
        
        myResult.font = .boldSystemFont(ofSize: 22)
        myResult.text = "\(gameScore.correctQuestions) / \(gameScore.totalQuestions)"
        myResult.textAlignment = .left
        
        myResultLabel.font = .boldSystemFont(ofSize: 12)
        myResultLabel.textColor = .gray
        myResultLabel.text = "CORRECT ANSWERS"
        myResultLabel.textAlignment = .left
        
        let myStackView3 = UIStackView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        myStackView3.axis = .vertical
        myStackView3.distribution = .equalSpacing
        myStackView3.alignment = .leading
        myStackView3.spacing = 2.0
        
        myStackView3.addArrangedSubview(myResult)
        myStackView3.addArrangedSubview(myResultLabel)
        
//        self.view.addSubview(myStackView3)
//
//        myStackView3.translatesAutoresizingMaskIntoConstraints = false
//        myStackView3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
//        myStackView3.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        myStackView3.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        
        let myTotalStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        myTotalStackView.axis = .vertical
        myTotalStackView.distribution = .equalSpacing
        myTotalStackView.alignment = .leading
        myTotalStackView.spacing = 30.0
        
        myTotalStackView.addArrangedSubview(myStackView)
        myTotalStackView.addArrangedSubview(myStackView2)
        myTotalStackView.addArrangedSubview(myStackView3)
        
        self.view.addSubview(myTotalStackView)
        myTotalStackView.translatesAutoresizingMaskIntoConstraints = false
        myTotalStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        myTotalStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        myTotalStackView.bottomAnchor.constraint(equalTo: myButton.topAnchor, constant: -40).isActive = true
        
    }
    
    func setupUpperView() {
        
        let imageName = "Celebration.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        
        self.view.addSubview(imageView)
        
        //constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
    }
    
    // MARK: - Helper
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
}

extension CourseResultViewController {
    
    func setupNavigationBar() {
        
        let navigationItem = self.navigationItem
        
        navigationItem.title = "Result"
        
        let helpButton = UIButton(type: .custom)
        helpButton.setImage(UIImage(named: "HelpButton.png"), for: .normal)
        helpButton.addTarget(self, action: #selector(studyProfileButton_clicked), for: .touchUpInside)
        helpButton.contentMode = .scaleAspectFit
        
        let rightHelpButton = UIBarButtonItem(customView: helpButton)
        
        navigationItem.rightBarButtonItem = rightHelpButton
        
    }
    
    @objc func studyProfileButton_clicked (_ sender: UIBarButtonItem) {
    }
    
}
