//
//  ContentView.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 12.03.2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var color: Color = .blue
    @State private var date: Date = .now
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays

    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []

    var body: some View {
        VStack {
            LabeledContent("Colendar color") {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            LabeledContent("Date/Time") {
                DatePicker("", selection: $date)
            }
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.bold)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    Text("\(day.formatted(.dateTime.day()))")
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background {
                            Circle()
                                .foregroundStyle(.blue)
                                .opacity(0.3)
                        }
                }
            }
        }
        .padding()
        .onAppear {
            print("startOfMonth ", Date().startOfMonth)
            print("endOfMonth ", Date().endOfMonth)
            print("endOfMonth1 ", Date().endOfMonth1)
        }
    }
}

#Preview {
    CalendarView()
}
