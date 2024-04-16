//
//  ContentView.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 12.03.2024.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    //@State private var color: Color = .blue
    let date: Date
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    let selectedActivity: Activity?
    @Query private var workouts: [Workout]

    init(date: Date, selectedActivity: Activity?) {
        self.date = date
        self.selectedActivity = selectedActivity
        let endOfMonthAdjustment = Calendar.current.date(byAdding: .day, value: -1, to: date.endOfMonth)!
        let predicate = #Predicate<Workout> { $0.date >= date.startOfMonth && $0.date <= endOfMonthAdjustment }
        _workouts = Query(filter: predicate, sort: \Workout.date)
    }

    var body: some View {
        let color = selectedActivity == nil ? .blue : Color(hex: selectedActivity!.hexColor)!
        VStack {
//            LabeledContent("Colendar color") {
//                ColorPicker("", selection: $color, supportsOpacity: false)
//            }
//            LabeledContent("Date/Time") {
//                DatePicker("", selection: $date)
//            }
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
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Text("\(day.formatted(.dateTime.day()))")
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background {
                                Circle()
                                    .foregroundStyle(
                                        Date.now.startOfDay == day.startOfDay
                                        ? .red.opacity(0.3) : color.opacity(0.3)

                                    )
                            }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
    }
}

#Preview {
    CalendarView(date: .now, selectedActivity: nil)
        .modelContainer(Activity.preview)
}
