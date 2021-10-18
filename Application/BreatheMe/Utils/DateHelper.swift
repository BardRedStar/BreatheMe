//
//  DateHelper.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 17.10.2021.
//

import Foundation

class DateHelper {

    // MARK: - Formatters

    /// A formatters with day and month format, e.g. "12 Sep"
    private static let dayMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()

    /// A formatters with day, month and year format, e.g. "12 Sep 2021"
    private static let dayMonthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        return formatter
    }()

    /// A formatters with day, month and year format, e.g. "12 Sep 2021"
    private static let dayTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    // MARK: - Date methods

    static func formattedDayFromDate(_ date: Date) -> String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current

        if calendar.isDateInToday(date) {
            return "Today"
        }

        if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }

        let currentDate = Date()
        let currentDateYear = calendar.component(.year, from: currentDate)
        let dateYear = calendar.component(.year, from: date)

        if currentDateYear == dateYear {
            return dayMonthFormatter.string(from: date)
        }

        return dayMonthYearFormatter.string(from: date)
    }

    static func formattedTimeFromDate(_ date: Date) -> String {
        dayTimeFormatter.string(from: date)
    }
}
