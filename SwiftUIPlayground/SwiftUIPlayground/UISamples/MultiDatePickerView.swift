//
//  MultiDatePickerView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 25/07/2022.
//

import SwiftUI

struct MultiDatePickerView: View {
    @State private var dates = Set<DateComponents>()
    
    @Environment(\.calendar) var calendar
    var body: some View {
        List {
            Section(header: Text("Free Dates selections")) {
                
                MultiDatePicker("Select your favorite dates", selection: $dates)
            }
            Section(header: Text("Range Dates selections")) {
                
                MultiDatePicker("Select your favorite dates from today", selection: $dates, in: Date.now...)
            }
            
            Text(summary)
        }.navigationTitle("🗓 Multi Date Picker")
    }
    
    var summary: String {
        dates.compactMap { components in
            calendar.date(from: components)?.formatted(date: .long, time: .omitted)
        }.formatted()
    }
}

struct MultiDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDatePickerView()
    }
}
