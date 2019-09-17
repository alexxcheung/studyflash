//
//  StudyProfile.swift
//  Study Flash
//
//  Created by Alex Cheung on 6/1/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class StudyProfileViewController: UIViewController, TKRadarChartDelegate, TKRadarChartDataSource {
    
    @IBOutlet weak var dateOfExam: UILabel!
    @IBOutlet weak var dayLeft: UILabel!
    @IBOutlet weak var confidenceLevel: UILabel!
    
    let myButton = UIButton()
    private var chart: TKRadarChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        setupNavigationBar()
        setupButton()
        
        showExamDate()
        showDayLeft()
        showConfidenceLevel()
        
        setupTKChart()
        
    }
    
    func setupTKChart() {
        let width = view.bounds.width - 40
        chart = TKRadarChart(frame: CGRect(x: 0, y: 0, width: width, height: width))
        chart.configuration.radius = width / 3
        chart.dataSource = self
        chart.delegate = self
        chart.center = view.center
        chart.reloadData()
        view.addSubview(chart)
        
        //        chart.translatesAutoresizingMaskIntoConstraints = false
        //        chart.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        //        chart.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        //        chart.bottomAnchor.constraint(equalTo: myButton.topAnchor, constant: -20).isActive = true
    }
    
    func numberOfStepForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 5
    }
    func numberOfRowForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 5
            //courseManager.selectedCourse!.courseChapter.count
    }
    func numberOfSectionForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 1
    }
    
    func titleOfRowForRadarChart(_ radarChart: TKRadarChart, row: Int) -> String {
        return "Chapter\(row + 1)"
    }
    
    func valueOfSectionForRadarChart(withRow row: Int, section: Int) -> CGFloat {
        if row == 0 {
            return CGFloat(courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.confidenceLevel / 100 * 5)
        } else {
            return 1
        }
    }
    
    
    func colorOfLineForRadarChart(_ radarChart: TKRadarChart) -> UIColor {
        return UIColor.purpleThemeColor
    }
    
    func colorOfFillStepForRadarChart(_ radarChart: TKRadarChart, step: Int) -> UIColor {
        switch step {
        case 1:
            return UIColor.white
        case 2:
            return UIColor.white
        case 3:
            return UIColor.white
        case 4:
            return UIColor.white
        default:
            return UIColor.white
        }
    }
    
    func colorOfSectionFillForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        if section == 0 {
            return UIColor(red:1,  green:0.867,  blue:0.012, alpha:0.4)
        } else {
            return UIColor(red:0,  green:0.788,  blue:0.543, alpha:0.4)
        }
    }
    
    func colorOfSectionBorderForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        if section == 0 {
            return UIColor(red:1,  green:0.867,  blue:0.012, alpha:1)
        } else {
            return UIColor(red:0,  green:0.788,  blue:0.543, alpha:1)
        }
    }
    
    func fontOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    
}

extension StudyProfileViewController {
    private func showExamDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy "
        dateOfExam.text = formatter.string(from: courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.dateOfExam)
    }
    
    private func showDayLeft() {
        let secondLeft = courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.dateOfExam.timeIntervalSince(Date())
        let dayLeft: Int = Int((secondLeft / (60 * 60 * 24)).rounded(.up))
        
        self.dayLeft.text = String(dayLeft)
    }
    
    private func showConfidenceLevel() {
        self.confidenceLevel.text = "\(courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress.confidenceLevel)%"
    }
    
    func setupTopView() {
        
    }
    
    func setupMidView() {

    }
    
    func setupBottomView() {
        
    }
    
    func setupButton() {
        myButton.backgroundColor = UIColor.pinkThemeColor
        myButton.frame = .zero
        myButton.tintColor = .white
        myButton.layer.cornerRadius = 8
        myButton.setTitle("Reset Course", for: .normal)
        myButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: -10,right: -10)
        myButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 30,bottom: 10,right: 30)
        myButton.titleLabel?.lineBreakMode = .byWordWrapping
        myButton.titleLabel?.textAlignment = .center
        myButton.titleLabel?.font = .systemFont(ofSize: 16)
//        startButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 19)
        myButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(myButton)
        
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
    }
    
    @objc func buttonAction(sender: UIButton) {
        sender.flash()
        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Confirm to reset?", message: "Reset the plan will clear all you progress", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Continue to reset", style: UIAlertAction.Style.destructive, handler: { action in
            self.resetPlan()
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func resetPlan() {
        print("resetPlan")
        //reset all the progress, including Exam date, completion, confidence,
        //.......
        courseManager.resetAll()
        
        let mainCourseListController = self.navigationController?.viewControllers[0] as! UIViewController
        self.navigationController?.popToViewController(mainCourseListController, animated: false)
        
        //popup for reset complete
        let alert = UIAlertController(title: "Course Reset Completed", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    

    func setupNavigationBar() {
        
        let navigationItem = self.navigationItem
        navigationItem.title = "Study Board"
    }
    
}
