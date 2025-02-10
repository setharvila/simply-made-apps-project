//  OfficeHours.swift
//
//  This is a class that implements the features of office hours
//

import Foundation

class OfficeHours {
    let daysOfWeek: [Int]
    let startTime: String
    let endTime: String
    
    init(daysOfWeek: [Int], startTime: String, endTime: String) {
        self.daysOfWeek = daysOfWeek
        self.startTime = startTime
        self.endTime = endTime
    }
    
    func getStartTimeDate() -> Date {
        var components = DateComponents()
        components.calendar = Calendar.current
        components.day = 1
        components.month = 1
        components.year = 1970
        components.hour = Int(startTime.split(separator: ":")[0])
        components.minute = Int(startTime.split(separator: ":")[1])
        components.second = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    func getEndTimeDate() -> Date {
        var components = DateComponents()
        components.calendar = Calendar.current
        components.day = 1
        components.month = 1
        components.year = 1970
        components.hour = Int(endTime.split(separator: ":")[0])
        components.minute = Int(endTime.split(separator: ":")[1])
        return Calendar.current.date(from: components) ?? Date.now
    }
}
