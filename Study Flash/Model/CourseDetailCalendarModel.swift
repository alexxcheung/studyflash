//
//  CourseDetailCalendarModel.swift
//  Study Flash
//
//  Created by 李宇恒 on 13/6/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import Foundation

public class WeekdayModel {
    
    public func getTodayDaysCountFromStartDay(_ startDateComponents: DateComponents) -> Int {
        let calendar = Calendar.current
        let today = Date()
        let startDate = calendar.date(from: startDateComponents)
        return calendar.dateComponents([.day], from: startDate!, to: today).day!
    }
    
    public func getWeekdayArray(_ startDateComponents: DateComponents, examDateComponents: DateComponents) -> [String] {
        
        let calendar = Calendar.current
        let examDate = calendar.date(from: examDateComponents)
        let startDate = calendar.date(from: startDateComponents)
        let studyDaysCount = calendar.dateComponents([.day], from: startDate!, to: examDate!).day
        let weekdayOfStartDay = calendar.component(.weekday, from: startDate!)
        let studyDaysRange = 0...studyDaysCount!
        var weekdayArrays = [String]()
        
        for i in studyDaysRange {
            let x = weekdayOfStartDay + i
            let y = weekdayNameFrom(weekdayNumber: x)
            weekdayArrays.append(y)
        }
        return weekdayArrays
        
    }
    
    private func weekdayNameFrom(weekdayNumber: Int) -> String {
        let calendar = Calendar.current
        let dayIndex = ((weekdayNumber - 1) + (calendar.firstWeekday - 1)) % 7
        return calendar.veryShortWeekdaySymbols[dayIndex]
    }
}

