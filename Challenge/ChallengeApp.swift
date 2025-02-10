import SwiftUI

@main
struct ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            let officeHours = OfficeHours(daysOfWeek: [1,2,3,4,5], startTime: "08:00", endTime: "17:30")
            let viewModel = TimeCheckViewModel(date: Date(), officeHours: officeHours)
            TimeCheckView(viewModel: viewModel)
        }
    }
}
