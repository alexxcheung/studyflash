//
//  CourseManager.swift
//  Study Flash
//
//  Created by Alex Cheung on 6/1/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//
import Foundation

let courseManager = CourseManager.sharedInstance
private var _SingletonSharedInstance =  CourseManager()

class CourseManager {
    
    public class var sharedInstance : CourseManager {
        return _SingletonSharedInstance
    }
    
    var allCourses = [Course]()
    var courseViewModels = [CourseViewModel]()
    var courseListFromJSON = [CourseInfo]()
    
    var selectedCourse: Course?
    var selectedCourseIndex: Int!
    
    //the place you fetch the courses
    func addCourses() {
        courseListFromJSON = self.fetchDataFromJSON(filename: "cisco")!
        importDataFromJSON()
    }
    
    func importDataFromJSON() {
        //initizte courseProgress
        var courseProgress = CourseProgress()
        
        for index in 0 ... courseListFromJSON.count - 1 {
            var sumOfQuestions = 0
            for chapterIndex in 0 ... courseListFromJSON[index].chapters.count - 1 {
                if let questions = courseListFromJSON[index].chapters[chapterIndex].questions {
                        sumOfQuestions += questions.count
                }
            }
            
            courseProgress.completion.totalQuestion = sumOfQuestions
 
            allCourses.append(Course(courseId: courseListFromJSON[index].id,
                                     courseTitle: courseListFromJSON[index].title,
                                     courseSubtitle: courseListFromJSON[index].subtitle,
                                     courseChapter: courseListFromJSON[index].chapters,
                                     courseProgress: courseProgress))
            
        }
    }
    
    func transformCourseToCourseViewModels() {
        courseViewModels = allCourses.map({return CourseViewModel(course: $0)})
    }
    
    func resetAll() {
        UserDefaults.standard.set(false, forKey: "isCourseSelected")
        UserDefaults.standard.set(false, forKey: "isTodayCourseFinished")
        UserDefaults.standard.synchronize()
        
        //reset the data in courseManager
        courseManager.allCourses[courseManager.selectedCourseIndex!].courseProgress = CourseProgress()
    }
    
    func calculateConfidenceLevel(correctNo: Int, totalQuestion: Int) -> Double {
        return Double(correctNo * 100 / totalQuestion)
    }
}

extension CourseManager {
    //MARK: -load course from JSON
    private func fetchDataFromJSON(filename fileName: String) -> [CourseInfo]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CourseData.self, from: data)

                return jsonData.courses

            } catch {
                print("Failed to fetch courses:\(error)")
            }
        }
        return nil
    }
}
