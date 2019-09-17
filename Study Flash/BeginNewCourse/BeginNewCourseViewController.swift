//
//  BeginNewCourseViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/28/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class BeginNewCourseViewController: UIViewController {
    
    private var myTableView: UITableView!
    private var myBottomView: UIView!
    private var examDateTextField: UITextField!
    private let myButton = BottomDisableButton()
    
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    
    var userSetTheDate = false {
        didSet {
            myButton.backgroundColor = .purpleThemeColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupBottomView()
        setupTableView()
    }
    
}

extension BeginNewCourseViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        myTableView = UITableView(frame: .zero)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.register(UINib(nibName: "BeginNewCourseHeaderCell", bundle: nil).self, forCellReuseIdentifier: "HeaderCell")
        myTableView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        myTableView.dataSource = self
        myTableView.delegate = self

        //enilminate thhe line
        myTableView.tableFooterView = UIView()
        myTableView.bounces = false
        myTableView.allowsSelection = false
        myTableView.separatorStyle = .none
        myTableView.showsVerticalScrollIndicator = false
    
        self.view.addSubview(myTableView)
        
        //set constraint
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 44).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -myBottomView.frame.size.height - 10).isActive = true
        
    }
    
    //header section ----------
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! BeginNewCourseHeaderCell
//        header.courseCompletionRateLabel.text = String(courseList[selectedCourseIndex].courseCompletion!) + "%" //put in xib
        return header
    }
    
    //Content Section ----------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseManager.allCourses[courseManager.selectedCourseIndex!].courseChapter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
            cell.textLabel!.text =
                courseManager.allCourses[courseManager.selectedCourseIndex!].courseChapter[indexPath.row].title
            cell.textLabel!.font = .systemFont(ofSize: 14)
        
        
        return cell
    }
}

extension BeginNewCourseViewController {
    
    
    
    
    //MARK:- BottomView
    func setupBottomView() {
        
        myBottomView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
        myBottomView.backgroundColor = .white
        
        self.view.addSubview(myBottomView)
        
        //set bottomView constraint
        myBottomView.translatesAutoresizingMaskIntoConstraints = false
        myBottomView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        myBottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myBottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myBottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        //Button
        myButton.setTitle("Create Plan", for: .normal)
        myButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        myBottomView.addSubview(myButton)
        
        //button constraint on button to stackView
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.heightAnchor.constraint(equalToConstant: myButton.height).isActive = true
        myButton.leadingAnchor.constraint(equalTo: myBottomView.leadingAnchor).isActive = true
        myButton.trailingAnchor.constraint(equalTo: myBottomView.trailingAnchor).isActive = true
        myButton.bottomAnchor.constraint(equalTo: myBottomView.bottomAnchor).isActive = true
        
        
        //Comment
        let myComment = UILabel()
        myComment.font = .systemFont(ofSize: 15)
        myComment.attributedText = modifyCommentText()
        myComment.textAlignment = .left
        myComment.backgroundColor = .white
        myComment.lineBreakMode = .byWordWrapping
        myComment.numberOfLines = 3
        
        //MARK:- DatePicker
        examDateTextField = TextField()
        
        configureDatePicker()
        examDateTextField.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        examDateTextField.textAlignment = .center
        examDateTextField.font = .boldSystemFont(ofSize: 16)
        
        examDateTextField.layer.borderWidth = 0.5
        examDateTextField.layer.borderColor = UIColor.purpleThemeColor.cgColor
        examDateTextField.layer.cornerRadius = 5
        examDateTextField.text = "Select Exam Date"
        examDateTextField.textColor = .purpleThemeColor
        
        examDateTextField.delegate = self
        examDateTextField.inputView = datePicker
        examDateTextField.inputAccessoryView = toolbar
        
        let totalQuestionLabel = UILabel()
        totalQuestionLabel.font = .boldSystemFont(ofSize: 18)
        totalQuestionLabel.textColor = .purpleThemeColor
        totalQuestionLabel.text = "Total: \(courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.completion.totalQuestion) questions"
        totalQuestionLabel.textAlignment = .center
        totalQuestionLabel.backgroundColor = .white
        
        let myStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        myStackView.axis = .vertical
        myStackView.distribution = .equalSpacing
        myStackView.alignment = .center
        myStackView.spacing = 15.0
        
        myStackView.addArrangedSubview(totalQuestionLabel)
        myStackView.addArrangedSubview(myComment)
        myStackView.addArrangedSubview(examDateTextField)
        
        myBottomView.addSubview(myStackView)
        
        //set constraint on stackView to bottomView
        myStackView.translatesAutoresizingMaskIntoConstraints = false
        myStackView.leadingAnchor.constraint(equalTo: myBottomView.leadingAnchor, constant: 20).isActive = true
        myStackView.trailingAnchor.constraint(equalTo: myBottomView.trailingAnchor, constant: -20).isActive = true
        myStackView.centerXAnchor.constraint(equalTo: myBottomView.centerXAnchor).isActive = true
        myStackView.bottomAnchor.constraint(equalTo: myButton.topAnchor, constant: -25).isActive = true

        //Comment Constraint
        totalQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        totalQuestionLabel.widthAnchor.constraint(equalTo: myStackView.widthAnchor).isActive = true
        
        myComment.translatesAutoresizingMaskIntoConstraints = false
        myComment.widthAnchor.constraint(equalTo: myStackView.widthAnchor).isActive = true
        
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Please select Exam Date", message: "for creating a customized study plan", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @objc private func buttonAction(sender: UIButton!) {
        sender.flash()
        
        guard userSetTheDate == true else {return showAlert()}
        
        actionAfterCourseSelected()
        
        UserDefaults.standard.set(true, forKey: "isBeginNewCourse")
        UserDefaults.standard.synchronize()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func actionAfterCourseSelected() {
        //Confirm course selected after starting the course
        
        courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.state = .todayNotCompleted
        
        //save to persistence memory
        UserDefaults.standard.set(true, forKey: "isCourseSelected")
        UserDefaults.standard.set(courseManager.selectedCourse?.courseId, forKey: "lastSelectedCourseId")
        UserDefaults.standard.synchronize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CourseDetailWithScheduleViewController  {
            //pass the course name
        }
    }
    
    func modifyCommentText() -> NSMutableAttributedString {
        let normalText  = "In order to create a personalized and efficient study plan for you, please specify the date of your exam: "
        let normalString = NSMutableAttributedString(string:normalText)
        
        let boldQuestionNo = ""
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:boldQuestionNo, attributes:attrs)
        normalString.append(attributedString)
        
        let normalText2 = ""
        let normalString2 = NSMutableAttributedString(string: normalText2)
        normalString.append(normalString2)
        
        return normalString
    }
    
}

extension BeginNewCourseViewController: UITextFieldDelegate {
    
    func configureDatePicker() {
        //Formate Date
//        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.minimumDate = Date()
        datePicker.tintColor = .purpleThemeColor
        
        //ToolBar
//        let toolbar = UIToolbar()
        
        let doneButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        toolbar.sizeToFit()
        toolbar.backgroundColor = .white
        toolbar.tintColor = .purpleThemeColor
    }

    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        examDateTextField.text = formatter.string(from: datePicker.date)
        userSetTheDate = true
        
        let dateTimestamp = datePicker.date
        courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.dateOfExam = dateTimestamp
        
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension BeginNewCourseViewController {
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.height, height:44))

        navigationBar.barTintColor = .white
        navigationBar.tintColor = .lightGray
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.gray]

        self.view.addSubview(navigationBar)

        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let navItem = UINavigationItem(title: courseManager.selectedCourse!.courseTitle)

        
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
        
        navItem.rightBarButtonItem = rightExitButton
        navigationBar.setItems([navItem], animated: false)
    }
    
    @objc func handleExitButton (_ sender: UIBarButtonItem) {
        //save exam date
        self.dismiss(animated: true, completion: nil)
    }
    
}
