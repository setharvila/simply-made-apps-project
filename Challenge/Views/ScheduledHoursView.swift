//
//  ScheduledHoursView.swift
//  Challenge
//
//  Created by Seth Arvila on 2/6/25.
//


import SwiftUI

struct ScheduledHoursView: View {
    @StateObject var viewModel: TimeCheckViewModel
    
    
    var body: some View {
        VStack {
            Text("Scheduled Hours")
                .foregroundStyle(.gray)
                .font(.caption)
                .padding(.bottom, 5)
            
            // This can probably be written better using .short date formatting and looping through the days of the week. I didn't have time to implement that within the constraints of this challenege
            HStack {
                Text("Su")
                    .opacity(viewModel.officeHours.daysOfWeek.description.contains("0") ? 1.0 : 0.25)
                Text("Mo")
                    .opacity(viewModel.officeHours.daysOfWeek.description.contains("1") ? 1.0 : 0.25)
                Text("Tu")
                    .opacity(viewModel.officeHours.daysOfWeek.description.contains("2") ? 1.0 : 0.25)
                Text("We")
                    .opacity(viewModel.officeHours.daysOfWeek.description.contains("3") ? 1.0 : 0.25)
                Text("Th")
                    .opacity(viewModel.officeHours.daysOfWeek.description.contains("4") ? 1.0 : 0.25)
                Text("Fr")
                    .opacity(viewModel.officeHours.daysOfWeek.description.contains("5") ? 1.0 : 0.25)
                Text("Sa")
                    .opacity(viewModel.officeHours.daysOfWeek.description.contains("6") ? 1.0 : 0.25)
            }
            .foregroundStyle(.gray)
            .bold()
            Text("\(viewModel.officeHours.getStartTimeDate(), style: .time) - \(viewModel.officeHours.getEndTimeDate(), style: .time)")
                .foregroundStyle(.blue)
                .font(.title2)
                .bold()
        }
        .padding(20)
        
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .shadow(radius: 2.0)
    }
}

#Preview {
    let officeHours = OfficeHours(daysOfWeek: [1,3,4], startTime: "11:00", endTime: "14:00")
    let viewModel = TimeCheckViewModel(date: Date(), officeHours: officeHours)
    ScheduledHoursView(viewModel: viewModel)
}
