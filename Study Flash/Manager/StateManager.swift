//
//  StateManager.swift
//  Study Flash
//
//  Created by Alex Cheung on 13/8/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import Foundation

let stateManager = StateManager.sharedInstance
private var _SingletonSharedInstance = StateManager()

enum AppState: String {
    case FirstLaunch
    case showMainCourseList
    case courseSelected //selected a course
    case courseInProgress //Taking Quiz
    case beginNewCourse
    case courseCompleted
}

class StateManager {
    
    public class var sharedInstance: StateManager {
        return _SingletonSharedInstance
    }
    
    var state: AppState = .FirstLaunch
    private let defaults = UserDefaults.standard
    
    func checkState() {
        
        if isFirstLaunch() {
            self.state = .FirstLaunch
        } else if isOnboardingFinish() {
            self.state = .showMainCourseList
            
            if isCourseSelected() {
                self.state = .courseSelected
                
                //temp:
            }
        }
    }
    
    func isFirstLaunch() -> Bool {
        if let _ = defaults.string(forKey: "isFirstLaunch") {
            return false
        } else {
            defaults.set(false, forKey: "isFirstLaunch")
            return true
        }
    }
    
    func isOnboardingFinish() -> Bool {
        return defaults.bool(forKey: "isOnboardingFinish") == true ? true : false
    }
    
    func isCourseSelected() -> Bool {
        return defaults.bool(forKey: "isCourseSelected") == true ? true : false
    }
    
    func isBeginNewCourse() -> Bool {
        return defaults.bool(forKey: "isBeginNewCourse") == true ? true : false
    }
    
    
    
    
}
