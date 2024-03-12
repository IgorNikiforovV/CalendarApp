//
//  Dete+Extension.swift
//  CalendarApp
//
//  Created by Игорь Никифоров on 12.03.2024.
//

import Foundation

extension Date {
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        let weekdays = calendar.veryShortWeekdaySymbols

        return weekdays.map { weekday in
            guard let firstLetter = weekday.first else { return "" }
            return String(firstLetter).capitalized
        }
    }

    static var fullMonthNames: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current

        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(
                from: DateComponents(year: 2000, month: month, day: 1)
            )
            return date.map{ dateFormatter.string(from: $0) }
        }
    }
}
