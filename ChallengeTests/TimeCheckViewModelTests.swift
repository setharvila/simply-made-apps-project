import XCTest

@testable import Challenge

class TimeCheckViewModelTests: XCTestCase {
    func testInit() {
        // Arrange
        let expectedDate = Date()
        let expectedOfficeHours = OfficeHours(daysOfWeek: [0,6], startTime: "10:00", endTime: "13:00")

        // Act
        let result = TimeCheckViewModel(date: expectedDate, officeHours: expectedOfficeHours)

        // Assert
        XCTAssertEqual(result.date, expectedDate)
        XCTAssertEqual(result.officeHours.daysOfWeek, expectedOfficeHours.daysOfWeek)
        XCTAssertEqual(result.officeHours.startTime, expectedOfficeHours.startTime)
        XCTAssertEqual(result.officeHours.endTime, expectedOfficeHours.endTime)
    }

    func testStringForDateInOfficeHours_DateIsInsideOfficeHours() {
        var components = DateComponents()
        components.day = 10
        components.month = 2
        components.year = 2025
        components.hour = 10
        components.minute = 30
        components.second = 0
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 10:30:00 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        let expectedString = "Date is within"
        
        XCTAssertEqual(expectedString, viewModel.stringForDateInOfficeHours())
    }
    
    func testStringForDateInOfficeHours_DateIsOutsideOfficeHours() {
        var components = DateComponents()
        components.day = 10
        components.month = 2
        components.year = 2025
        components.hour = 11
        components.minute = 30
        components.second = 0
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 11:30:00 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        let expectedString = "Date is not within"
        
        XCTAssertEqual(expectedString, viewModel.stringForDateInOfficeHours())
    }
    
    func testBoolForIsWithinOfficeHours_ReturnFalseBeforeStart() {
        var components = DateComponents()
        components.day = 10
        components.month = 2
        components.year = 2025
        components.hour = 9
        components.minute = 59
        components.second = 59
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 9:59:59 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        
        XCTAssertFalse(viewModel.isWithinOfficeHours())
    }
    
    func testBoolForIsWithinOfficeHours_ReturnTrueExactStart() {
        var components = DateComponents()
        components.day = 10
        components.month = 2
        components.year = 2025
        components.hour = 10
        components.minute = 00
        components.second = 00
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 10:00:00 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        
        XCTAssertTrue(viewModel.isWithinOfficeHours())
    }
    
    func testBoolForIsWithinOfficeHours_ReturnTrueMiddle() {
        var components = DateComponents()
        components.day = 10
        components.month = 2
        components.year = 2025
        components.hour = 10
        components.minute = 30
        components.second = 00
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 10:30:00 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        
        XCTAssertTrue(viewModel.isWithinOfficeHours())
    }
    
    func testBoolForIsWithinOfficeHours_ReturnTrueExactEnd() {
        var components = DateComponents()
        components.day = 10
        components.month = 2
        components.year = 2025
        components.hour = 11
        components.minute = 00
        components.second = 59
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 11:00:59 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        
        XCTAssertTrue(viewModel.isWithinOfficeHours())
    }
    
    func testBoolForIsWithinOfficeHours_ReturnFalseAfterEnd() {
        var components = DateComponents()
        components.day = 10
        components.month = 2
        components.year = 2025
        components.hour = 11
        components.minute = 01
        components.second = 00
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 11:00:01 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        
        XCTAssertFalse(viewModel.isWithinOfficeHours())
    }
    
    func testStringforGetMessageInOfficeHours() {
        var components = DateComponents()
        components.day = 10
        components.month = 2
        components.year = 2025
        components.hour = 10
        components.minute = 30
        components.second = 0
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 10:30:00 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        let expectedString = "Office hours are avaliable during this time"
        _ = viewModel.isWithinOfficeHours()
        XCTAssertEqual(expectedString, viewModel.getMessage())
    }
    
    func testStringforGetMessageOutOfOfficeHours() {
        var components = DateComponents()
        components.day = 11
        components.month = 2
        components.year = 2025
        components.hour = 11
        components.minute = 30
        components.second = 0
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 11:30:00 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        let expectedString = "Sorry, office hours are not avaliable during this time"
        _ = viewModel.isWithinOfficeHours()
        XCTAssertEqual(expectedString, viewModel.getMessage())
    }
    
    func testSymbolforGetMessageInOfficeHours() {
        var components = DateComponents()
        components.day = 10
        components.month = 2
        components.year = 2025
        components.hour = 10
        components.minute = 30
        components.second = 0
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 10:30:00 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        let expectedString = "checkmark.circle.fill"
        _ = viewModel.isWithinOfficeHours()
        XCTAssertEqual(expectedString, viewModel.getSymbol())
    }
    
    func testSymbolforGetMessageOutOfOfficeHours() {
        var components = DateComponents()
        components.day = 11
        components.month = 2
        components.year = 2025
        components.hour = 11
        components.minute = 30
        components.second = 0
       
        let inputDate = Calendar.current.date(from: components)! // Feb 10, 2025 11:30:00 AM
        
        let officeHours = OfficeHours(daysOfWeek: [1], startTime: "10:00", endTime: "11:00")
        let viewModel = TimeCheckViewModel(date: inputDate, officeHours: officeHours)
        let expectedString = "x.circle.fill"
        _ = viewModel.isWithinOfficeHours()
        XCTAssertEqual(expectedString, viewModel.getSymbol())
    }
    
    
}
