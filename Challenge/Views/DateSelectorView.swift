//
//  DateSelectorView.swift
//  Challenge
//
//  Created by Seth Arvila on 2/6/25.
//


import SwiftUI

struct DateSelectorView: View {
    @StateObject var viewModel: TimeCheckViewModel
//    @Binding var selectedDate: Date
    var body: some View {
        VStack {
            Text("When would you like to check?")
                .font(.headline)
                .foregroundStyle(.blue)
            
            // Future: Change the animation to be "happy" (bounce) for a positive outcome and "mad" (shake) for a negative outcome
            // Future: it feels kind of akward having the initial state with instructions. It would probably be better if it determined if the default date value is valid. But instructions are also important. Maybe it could show the first time the app is run, but never again after that, with a firstUse key saved in persistent storage.
            DatePicker("Pick a date", selection: $viewModel.date)
                .labelsHidden()
                .onChange(of: viewModel.date) {
                    withAnimation(.bouncy) {
                        _ = viewModel.isWithinOfficeHours()
                    }
                }
                
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(20)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .shadow(radius: 2.0)
        
    }
        
}
