//
//  CoursesContetntViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/13/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit



class CoursesDetailViewController: UIViewController {
    
    private var myTableView: UITableView!
    private var myBottomView: UIView!
    private var screenSize: CGRect = UIScreen.main.bounds
    
    var isTodayCourseFinished = UserDefaults.standard.bool(forKey: "isTodayCourseFinished")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupBottomView()
        setupTableView()
        setupNavigationBar()
        
        //update number of question left
//        courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.completion.totalIncompletedQuestion = courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.completion.questionLeft()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        isTodayCourseFinished = UserDefaults.standard.bool(forKey: "isTodayCourseFinished")
        
        myTableView.reloadData()
        setupBottomView()
    }
}

extension CoursesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        myTableView = UITableView(frame: .zero)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.register(UINib(nibName: "CoursesDetailHeaderCell", bundle: nil).self, forCellReuseIdentifier: "HeaderCell")
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.separatorStyle = .none
        myTableView.allowsSelection = false
        myTableView.bounces = false

        self.view.addSubview(myTableView)
        
        //set constraint
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true // need to change
        myTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -myBottomView.frame.size.height).isActive = true

    }
    
    //header section ----------
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! CoursesDetailHeaderCell
        //update the course completion
//        print(courseManager.allCourses[courseManager.selectedCourseIndex!])
//        header.numberOfQuestion = courseManager.allCourses[courseManager.selectedCourseIndex!].numberOfQuestion
        
        header.courseCompletionRateLabel.text = String(courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.completion.calculateCompletionRate()) + "%" //put in xib
        
        return header
    }
    
    //Content Section ----------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseManager.allCourses[courseManager.selectedCourseIndex ?? 0].courseChapter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel!.text = courseManager.allCourses[courseManager.selectedCourseIndex ?? 0].courseChapter[indexPath.row].title
        return cell
    }
}

extension CoursesDetailViewController {
    
    private func setupBottomView() {
        
        myBottomView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 150))
        myBottomView.backgroundColor = .white
        
        self.view.addSubview(myBottomView)
        
        let myComment = UILabel()
        myComment.font = .systemFont(ofSize: 14)
        myComment.attributedText = modifyCommentText()
        myComment.textAlignment = .center
        myComment.backgroundColor = .white
        myComment.lineBreakMode = .byWordWrapping
        myComment.numberOfLines = 3
        myComment.sizeToFit()
        
        let myButton = BottomNormalButton()
        
        if courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.state == .todayNotCompleted {
            myButton.backgroundColor = UIColor.purpleThemeColor
            let titleName = (courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.completion.calculateCompletionRate() == 0) ? "Start New Study Session" : "Continue Study Session"
            myButton.setTitle(titleName, for: .normal)

        } else {
            myButton.backgroundColor = UIColor.lightGray
            myButton.setTitle("Done for Today", for: .normal)
        }
        
        myButton.addTarget(self, action: #selector(handleContinueStudySession), for: .touchUpInside)
        
        myBottomView.addSubview(myButton)
        myBottomView.addSubview(myComment)
        
        //set bottomView constraint
        myBottomView.translatesAutoresizingMaskIntoConstraints = false
        myBottomView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        myBottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myBottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myBottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        //button constraint on button to stackView
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.heightAnchor.constraint(equalToConstant: myButton.height).isActive = true
        myButton.leadingAnchor.constraint(equalTo: myBottomView.leadingAnchor).isActive = true
        myButton.trailingAnchor.constraint(equalTo: myBottomView.trailingAnchor).isActive = true
        myButton.bottomAnchor.constraint(equalTo: myBottomView.bottomAnchor).isActive = true
        
        //Comment Constraint
        myComment.translatesAutoresizingMaskIntoConstraints = false
        myComment.centerXAnchor.constraint(equalTo: myBottomView.centerXAnchor).isActive = true
        myComment.bottomAnchor.constraint(equalTo: myButton.topAnchor, constant: -10).isActive = true

    }
    
    @objc private func handleContinueStudySession(sender: UIButton!) {
        sender.flash()
        
        if courseManager.allCourses[courseManager.selectedCourseIndex].courseProgress.state == .todayNotCompleted {
            actionAfterCourseConfirmed()
            performSegue(withIdentifier: "startQuiz", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startQuiz" {
            if let destinationViewController = segue.destination as? UINavigationController {
                if let quizViewController = destinationViewController.viewControllers.first as? QuestionsTopViewController {
                    // Pass data to Quiz View Controller if needed
                }
            }
        }
    }
    
    func actionAfterCourseConfirmed() {
        //Confirm course selected after starting the course
        
        //save to persistence memory
        UserDefaults.standard.set(true, forKey: "isCourseSelected")
        UserDefaults.standard.set(courseManager.selectedCourse?.courseId, forKey: "lastSelectedCourseId")
        UserDefaults.standard.synchronize()
        
    }
    
    func modifyCommentText() -> NSMutableAttributedString {
        
        var questionLeft = courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.completion.questionLeft()
        //MARK:- temp use
        questionLeft = questionLeft / 3
        
        var boldQuestionNo = ""
        var normalText: String!
        var normalText2: String!
        
        if questionLeft != 0 {
            normalText  = "Only "
            boldQuestionNo = "\(questionLeft) questions left "
            normalText2 = "for today's plan.\n Keep it going!"
        } else {
            normalText = ""
            boldQuestionNo = "No question left "
            normalText2 = ""
        }
        
        let normalString = NSMutableAttributedString(string:normalText)
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:boldQuestionNo, attributes:attrs)
        normalString.append(attributedString)
        
        let normalString2 = NSMutableAttributedString(string: normalText2)
        normalString.append(normalString2)
        
        return normalString
    }
    
}

extension CoursesDetailViewController {
    
    func setupNavigationBar() {
    
        let navigationItem = self.navigationItem
        
        navigationItem.title = courseManager.selectedCourse?.courseTitle
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)

        let helpButton = UIButton(type: .custom)
        helpButton.setImage(UIImage(named: "ChartButton.png"), for: .normal)
        helpButton.addTarget(self, action: #selector(studyProfileButton_clicked), for: .touchUpInside)
        helpButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        helpButton.tintColor = .purpleThemeColor
        helpButton.contentMode = .scaleAspectFill

        let rightHelpButton = UIBarButtonItem(customView: helpButton)
        
        rightHelpButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        rightHelpButton.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rightHelpButton.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true

        navigationItem.rightBarButtonItem = rightHelpButton

    }

    @objc func studyProfileButton_clicked (_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showStudyProfile", sender: self)
    }
    
}
