//
//  CourseDetailWithScheduleViewController.swift
//  Study Flash
//
//  Created by 李宇恒 on 13/6/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//


import UIKit
import Foundation

class CourseDetailWithScheduleViewController: UIViewController {
    
    private var screenSize: CGRect = UIScreen.main.bounds

    var isTodayCourseFinished = UserDefaults.standard.bool(forKey: "isTodayCourseFinished")

    var dayCount = 1
    var streakCount = 0
//    var questionsCount = 30
//    var numberOfQuestion = courseManager.allCourses[courseManager.selectedCourseIndex!].numberOfQuestion
//    var myArray: NSArray = ["Hardware Basics","Router Essentials","Router Configuration"]
    var weekArray = [String]()
    let calendar = Calendar.current
    var today = Date()
    let examDate = courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.dateOfExam
    let examDateComponents = DateComponents(year: 2019, month: 6, day: 30)
    let startDateComponents = DateComponents(year: 2019, month: 6, day: 15)
    var todayDaysCountFromStartDay = 0
    var pastStatus = [0: true, 1: false, 2: true, 3: true, 4: false, 5: true, 6: true, 7: true, 8: false, 9: true, 10: false, 11: true, 12: false, 13: true, 14: true, 15: true, 16: true, 17: true, 18: true, 19: true, 20: true]
    
    
    weak var studyDayLabel: UILabel!
    weak var collectionView: UICollectionView!
    weak var streakLabel: UILabel!
    weak var todayLabel: UILabel!
    weak var descriptionLabel: UILabel!
    weak var tableView: UITableView!
    weak var promoLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let myWeekdayModel = WeekdayModel()
        let weekdayArray = myWeekdayModel.getWeekdayArray(startDateComponents, examDateComponents: examDateComponents)
        weekArray += weekdayArray
        let daysCountFromStartDay = myWeekdayModel.getTodayDaysCountFromStartDay(startDateComponents)
        todayDaysCountFromStartDay = daysCountFromStartDay
        
        let studyDayLabel = UILabel(frame: .zero)
        studyDayLabel.text = "Study Day \(dayCount)"
        studyDayLabel.font = .boldSystemFont(ofSize: 44)
        studyDayLabel.textColor = .black
        studyDayLabel.textAlignment = .left
        studyDayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //        self.view.addSubview(collectionView)
        
        self.collectionView = collectionView
        
        let streakLabel = UILabel(frame: .zero)
        //        streakLabel.text = "Great job, you are on a \(streakCount) day streak! 😎"
        streakLabel.font = .systemFont(ofSize: 18)
        streakLabel.textColor = .black
        streakLabel.textAlignment = .center
        
        let normalText = "Great job, you are on a "
        let boldText  = "\(streakCount) day"
        let normalText2 = " streak! 😎"
        let attributedString = NSMutableAttributedString(string: normalText)
        let attributedString2 = NSMutableAttributedString(string: normalText2)
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
        
        attributedString.append(boldString)
        attributedString.append(attributedString2)
        streakLabel.attributedText = attributedString
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let todayLabel = UILabel(frame: .zero)
        todayLabel.text = "Today"
        todayLabel.font = .systemFont(ofSize: 23)
        todayLabel.textColor = .black
        todayLabel.textAlignment = .left
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.text = "Your study plan for today includes a total of \(courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.completion.totalQuestion) questions from the following chapters:"
        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView = tableView
        
        
        let promoLabel = UILabel(frame: .zero)
        promoLabel.text = "Start studying now to continue your streak!"
        promoLabel.font = .boldSystemFont(ofSize: 17)
        promoLabel.textColor = .black
        promoLabel.textAlignment = .left
        promoLabel.numberOfLines = 0
        promoLabel.lineBreakMode = .byWordWrapping
        promoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
//        let myButton = UIButton()
//        myButton.tintColor = .white
//        var titleName = ""
//
//        if isTodayCourseFinished {
//            myButton.backgroundColor = UIColor.lightGray
//            titleName = "Done for today!"
//        } else {
//            myButton.backgroundColor = UIColor.purpleThemeColor
//            titleName = (courseManager.allCourses[courseManager.selectedCourseIndex!].CourseCompletionInPercentage() == 0) ? "Start New Study Session" : "Continue Study Session"
//        }
//
//        myButton.frame = .zero
//        myButton.setTitle(titleName, for: .normal)
//        myButton.titleLabel?.lineBreakMode = .byWordWrapping
//        myButton.titleLabel?.textAlignment = .center
//        myButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
//        myButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: 20,right: -10)
//        myButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
//        myButton.addTarget(self, action: #selector(handleContinueStudySession), for: .touchUpInside)
//        myButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(myButton)
        
        
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        stackView.axis = NSLayoutConstraint.Axis.vertical
        //        stackView.alignment = .top
        //        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.addArrangedSubview(studyDayLabel)
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(streakLabel)
        stackView.addArrangedSubview(todayLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(promoLabel)
        //        stackView.setCustomSpacing(100, after: stackView.subviews[2])
        //        stackView.setCustomSpacing(20, after: stackView.subviews[4])
        //        stackView.setCustomSpacing(40, after: stackView.subviews[5])
        //        stackView.setCustomSpacing(10, after: stackView.subviews[0])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            studyDayLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40),
            studyDayLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -15),
            studyDayLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 70),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: streakLabel.topAnchor, constant: -20),
            //                        streakLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            streakLabel.bottomAnchor.constraint(lessThanOrEqualTo: todayLabel.topAnchor, constant: -30),
            todayLabel.topAnchor.constraint(greaterThanOrEqualTo: streakLabel.bottomAnchor, constant: 50),
            todayLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -30),
            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            tableView.heightAnchor.constraint(equalToConstant: 170),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: promoLabel.topAnchor, constant: -30),
            promoLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
            promoLabel.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: stackView.bottomAnchor, multiplier: -30),
//            myButton.heightAnchor.constraint(equalToConstant: 90),
//            myButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            myButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            myButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            //            stackView.heightAnchor.constraint(equalToConstant: 600),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            stackView.bottomAnchor.constraint(lessThanOrEqualTo: myButton.topAnchor, constant: -15),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
            ])
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
        //        self.collectionView.isPagingEnabled = true
        //        self.collectionView.isScrollEnabled = true
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyTableCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        
        
        
        //        let myWeekdayModel = WeekdayModel()
        //        let weekdayArray = myWeekdayModel.getWeekdayArray(DateComponents(year: 2019, month: 6, day: 1), examDateComponents: DateComponents(year: 2019, month: 6, day: 30))
        
//        setupBottomView()
        setupNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        isTodayCourseFinished = UserDefaults.standard.bool(forKey: "isTodayCourseFinished")
        
        tableView.reloadData()
        setupBottomView()
        
        
    }
}

extension CourseDetailWithScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.textLabel.text = weekArray[indexPath.row]
        if indexPath.row == todayDaysCountFromStartDay {
            cell.textLabel.font = .boldSystemFont(ofSize: 20)
            cell.textLabel.textColor = .black
            cell.statusImage.image = UIImage(named: "Today")
        } else if indexPath.row < todayDaysCountFromStartDay && pastStatus[indexPath.row] == true {
            cell.textLabel.font = .systemFont(ofSize: 20)
            cell.textLabel.textColor = .gray
            cell.statusImage.image = UIImage(named: "Done")
        } else if indexPath.row < todayDaysCountFromStartDay && pastStatus[indexPath.row] == false {
            cell.textLabel.font = .systemFont(ofSize: 20)
            cell.textLabel.textColor = .gray
            cell.statusImage.image = UIImage(named: "Missed")
        } else {
            cell.textLabel.font = .systemFont(ofSize: 20)
            cell.textLabel.textColor = .gray
            cell.statusImage.image = UIImage(named: "Future")
        }
        return cell
    }
}
extension CourseDetailWithScheduleViewController: UICollectionViewDelegate {
    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath)!
        cell.backgroundColor = .green
    }
}

extension CourseDetailWithScheduleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 30, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension CourseDetailWithScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseManager.allCourses[courseManager.selectedCourseIndex ?? 0].courseChapter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableCell", for: indexPath as IndexPath)
        cell.textLabel!.text = courseManager.allCourses[courseManager.selectedCourseIndex ?? 0].courseChapter[indexPath.row].title
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        return cell
    }
    
    
}

extension CourseDetailWithScheduleViewController {
    
    private func setupBottomView() {

    let myButton = UIButton()
    myButton.tintColor = .white
    var titleName = ""
    
    if isTodayCourseFinished {
        myButton.backgroundColor = UIColor.lightGray
        titleName = "Done for today!"
    } else {
        myButton.backgroundColor = UIColor.primaryThemeColor
//        titleName = (courseManager.allCourses[courseManager.selectedCourseIndex!].CourseCompletionInPercentage() == 0) ? "Start New Study Session" : "Continue Study Session"
    }
    
    myButton.frame = .zero
    myButton.setTitle(titleName, for: .normal)
    myButton.titleLabel?.lineBreakMode = .byWordWrapping
    myButton.titleLabel?.textAlignment = .center
    myButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    myButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: 20,right: -10)
    myButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
    myButton.addTarget(self, action: #selector(handleContinueStudySession), for: .touchUpInside)
    myButton.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(myButton)
    
        NSLayoutConstraint.activate([
//            studyDayLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40),
//            studyDayLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -15),
//            studyDayLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: 70),
//            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: streakLabel.topAnchor, constant: -20),
//            //                        streakLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
//            streakLabel.bottomAnchor.constraint(lessThanOrEqualTo: todayLabel.topAnchor, constant: -30),
//            todayLabel.topAnchor.constraint(greaterThanOrEqualTo: streakLabel.bottomAnchor, constant: 50),
//            todayLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10),
//            descriptionLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -30),
//            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
//            tableView.heightAnchor.constraint(equalToConstant: 170),
//            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: promoLabel.topAnchor, constant: -30),
//            promoLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
//            promoLabel.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: stackView.bottomAnchor, multiplier: -30),
            myButton.heightAnchor.constraint(equalToConstant: 90),
            myButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            myButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            //            stackView.heightAnchor.constraint(equalToConstant: 600),
//            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            stackView.bottomAnchor.constraint(lessThanOrEqualTo: myButton.topAnchor, constant: -15)
//            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            //            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
//            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
            ])
        
        
    }
    
    
    
    @objc private func handleContinueStudySession(sender: UIButton!) {
        sender.flash()

        if !isTodayCourseFinished {
            confirmSelectedCourse()
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
    
    func confirmSelectedCourse() {
        //Confirm course selected after starting the course
        
        //save to persistence memory
        UserDefaults.standard.set(true, forKey: "isCourseSelected")
        UserDefaults.standard.set(courseManager.selectedCourse?.courseId, forKey: "lastSelectedCourseId")
        
        UserDefaults.standard.synchronize()
    }
    
}


extension CourseDetailWithScheduleViewController {
    
    func setupNavigationBar() {
        
        let navigationItem = self.navigationItem
        
        navigationItem.title = courseManager.selectedCourse?.courseTitle
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        let helpButton = UIButton(type: .custom)
        helpButton.setImage(UIImage(named: "ChartButton.png"), for: .normal)
        helpButton.addTarget(self, action: #selector(studyProfileButton_clicked), for: .touchUpInside)
        helpButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        helpButton.tintColor = .primaryThemeColor
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
