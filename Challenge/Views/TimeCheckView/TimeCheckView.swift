// TimeCheckView.swift
// This is the main view and entry point into the app. It allows users to input a date and time and it tells them if the date supplied is within office hours.


import SwiftUI

struct TimeCheckView: View {
    @StateObject var viewModel: TimeCheckViewModel

    var body: some View {
        ZStack {
            viewModel.getBGGradient()
                .ignoresSafeArea()

            VStack {
                Text("Office Hours")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                Text("Schedule")
                    .foregroundStyle(.secondary)

                ScheduledHoursView(viewModel: viewModel)
                
                Spacer()
                
                // Future: Update the sensory feedback to give a positive or negative feedback based on the outcome.
                Image(systemName: viewModel.getSymbol())
                    .frame(height: 150, alignment: .top)
                    .font(.system(size: 130))
                    .opacity(0.75)
                    .symbolEffect(.bounce, value: viewModel.resultState)
                    .sensoryFeedback(.impact, trigger: viewModel.getSymbol())
                
                Text(viewModel.getMessage())
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    
                Spacer()
                DateSelectorView(viewModel: viewModel)
                    .padding()
            }
        }
        .foregroundStyle(.white)
        
    }
}

#Preview {
    let officeHours = OfficeHours(daysOfWeek: [1,3,4], startTime: "11:00", endTime: "18:00")
    let viewModel = TimeCheckViewModel(date: Date(), officeHours: officeHours)
    TimeCheckView(viewModel: viewModel)
}




