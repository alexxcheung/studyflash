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
    case firstLaunch
    case showMainCourseList
    case courseSelected //selected a course
    case courseInProgress //Taking Quiz
    case beginNewCourse
    case courseCompleted
}

enum LogState: String {
    case loggedIn
    case loggedOut
}

class StateManager {
    
    var state: AppState!
    var logState: LogState = .loggedOut
    
    public class var sharedInstance: StateManager {
        return _SingletonSharedInstance
    }
    
    private let defaults = UserDefaults.standard
    
    private func checkState() -> AppState {
        if isFirstLaunch() {
            return .firstLaunch
        } else {
            
            if isBeginNewCourse() {
                return .beginNewCourse
            } else if isCourseSelected() {
                courseManager.selectedCourseIndex = 0
                return .courseSelected
            }
            
            return .showMainCourseList
        }
    }
    
    func updateState() {
        self.state = self.checkState()
        print(self.state!)
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
