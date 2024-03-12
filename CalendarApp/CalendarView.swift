//
//  ContentView.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 12.03.2024.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            print(Date.capitalizedFirstLettersOfWeekdays)
            print(Date.fullMonthNames)
        }
    }
}

#Preview {
    CalendarView()
}
