import Foundation
import SwiftUI
import UIKit

class TimeCheckViewModel: ObservableObject {
    @Published public var date: Date
    @Published public var officeHours: OfficeHours
    @Published public var resultState: ResultStates = .waiting
    
    init(date: Date, officeHours: OfficeHours) {
        self.date = date
        self.officeHours = officeHours
    }
    
    // This functionality is only used for testing purposes
    func stringForDateInOfficeHours() -> String {
        if isWithinOfficeHours() {
            return "Date is within"
        } else {
            return "Date is not within"
        }
    }
    
    
    // Returns a background gradient based on the result
    func getBGGradient() -> LinearGradient {
        let startPoint: UnitPoint = .topLeading
        let endPoint: UnitPoint = .bottomTrailing
        switch resultState {
        case .waiting:
            return LinearGradient(colors: [.blue, .green], startPoint: startPoint, endPoint: endPoint)
        case .good:
            return LinearGradient(colors: [.green, Color.darkGreen], startPoint: startPoint, endPoint: endPoint)
        case .bad:
            return LinearGradient(colors: [.red, Color.darkRed], startPoint: startPoint, endPoint: endPoint)
        }
    }
    
    
    // Symbol to be shown in the view
    func getSymbol() -> String {
        switch resultState {
        case .waiting:
            return "clock.badge.questionmark.fill"
        case .good:
            return "checkmark.circle.fill"
        case .bad:
            return "x.circle.fill"
        }
    }
    
    
    // Message to display the result
    func getMessage () -> String {
        switch resultState {
        case .waiting:
            return "To get started, select a date and time below."
        case .good:
            return "Office hours are avaliable during this time"
        case .bad:
            return "Sorry, office hours are not avaliable during this time"
        }
    }
    
    
    // Compares the value of the supplied date with the office hours
    func isWithinOfficeHours() -> Bool {
        let calendar = Calendar.current
        let dayOfWeekIndex = Calendar.current.component(.weekday, from: date) - 1
        
        // Check if the day is a day that has office hours
        if (!officeHours.daysOfWeek.contains(dayOfWeekIndex)) {
            resultState = .bad
            return false
        }
        
        // Convert the dates to new date components with the inputted time and a default date
        let dateTimeComponent = calendar.dateComponents([.hour, .minute], from: date)
        let hoursStartTimeComponent = calendar.dateComponents([.hour, .minute], from: officeHours.getStartTimeDate())
        let hoursEndTimeComponent = calendar.dateComponents([.hour, .minute], from: officeHours.getEndTimeDate())
        
        let dateSeconds = dateTimeComponent.hour! * 3600 + dateTimeComponent.minute! * 60
        let startSeconds = hoursStartTimeComponent.hour! * 3600 + hoursStartTimeComponent.minute! * 60
        let endSeconds = hoursEndTimeComponent.hour! * 3600 + hoursEndTimeComponent.minute! * 60
        
        
        if (dateSeconds <= endSeconds && dateSeconds >= startSeconds) {
            resultState = .good
            return true
        }
        
        else {
            resultState = .bad
            return false
        }
        
    }
}


