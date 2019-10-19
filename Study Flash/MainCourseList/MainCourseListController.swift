//
//  TopicViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/10/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class MainCourseListController: UIViewController {
        
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        configueTableView()
        setupCourseManager()
        stateManager.updateState()
        navigateAccordingToState_FirstLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCourseList()
        stateManager.updateState()
        navigateAccordingToState_ViewWillAppear()
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func navigateAccordingToState_FirstLoad() {
        if stateManager.state == .courseSelected {
            courseManager.selectedCourseIndex = UserDefaults.standard.integer(forKey: "lastSelectedCourseId")
            //safeguard
            guard courseManager.selectedCourseIndex >= 0 else {return}
            
            performSegue(withIdentifier: "backToCourseDetail", sender: self)
            courseManager.allCourses[courseManager.selectedCourseIndex].courseProgress.state = .todayNotCompleted
        }
    }
    
    func navigateAccordingToState_ViewWillAppear() {
        if stateManager.state == .beginNewCourse {
                UserDefaults.standard.set(false, forKey: "isBeginNewCourse")
                UserDefaults.standard.synchronize()
        
                performSegue(withIdentifier: "backToCourseDetail", sender: self)
        }
    }
}

extension MainCourseListController: UITableViewDelegate, UITableViewDataSource {
    
    private func configueTableView() {
        myTableView = UITableView()
        myTableView.register(UINib(nibName: "CoursesTableViewCell", bundle: nil).self, forCellReuseIdentifier: "CoursesTableCell")
        myTableView.register(UINib(nibName: "CoursesTableViewFooterCell", bundle: nil).self, forCellReuseIdentifier: "FooterCell")
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        // Eliminate the line
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        // Reverse TableView
        myTableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi))
        
        self.view.addSubview(myTableView)
        
        //set constraint
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseManager.allCourses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesTableCell", for: indexPath) as! CoursesTableViewCell
         
        // MVVM
        cell.courseViewModel = courseManager.courseViewModels[indexPath.row]
        
        // Reverse TableViewCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        
        return cell
    }
    
    // setupFooter
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableCell(withIdentifier: "FooterCell") as! CoursesTableViewFooterCell
        footer.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        return footer
    }
    
    // Course Selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCourse = courseManager.allCourses[indexPath.row]
        
        // save selected course data into global
        courseManager.selectedCourse = selectedCourse
        courseManager.selectedCourseIndex = indexPath.row
        
        // passing course detail to next viewController
        if courseManager.selectedCourse?.courseProgress.state == .notStart {
            performSegue(withIdentifier: "startNewCourse", sender: self)
        } else {
            performSegue(withIdentifier: "showCourseDetails", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard myTableView.indexPathForSelectedRow != nil else {return}

        // Deselecting animation
        myTableView.deselectRow(at: myTableView.indexPathForSelectedRow!, animated: true)
    }
}

extension MainCourseListController: UINavigationBarDelegate {
    
    // MARK:- Navigation Bar
    func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else {return}

        let navigationItem = UINavigationItem()
        navigationItem.title = "Courses"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    func updateNavigationBar() {
        let navigationItem = self.navigationItem
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension MainCourseListController {
    func setupCourseManager() {
        if courseManager.allCourses.isEmpty {
            courseManager.addCourses()
        }
    }
    
    func updateCourseList() {
        courseManager.transformCourseToCourseViewModels()
        myTableView.reloadData()
    }
}






