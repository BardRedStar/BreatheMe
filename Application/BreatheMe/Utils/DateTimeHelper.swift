//
//  DateTimeHelper.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 17.10.2021.
//

import Foundation

class DateTimeHelper {

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

    /// A formatters with day time format, e.g. "21:13:44"
    private static let dayTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    // MARK: - Date methods

    /// Gets string representation of `date` by following rules:
    /// * If date is today - returns "Today"
    /// * If date is yesterday - returns "Yesterday"
    /// * If date is in this year - returns date without a year, e.g "12 Sep"
    /// * If date is in past years - returns date with year, e.g. "12 Sep 2020"
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

    /// Formats `date` as day time (e.g. "21:13:54")
    static func formattedTimeFromDate(_ date: Date) -> String {
        dayTimeFormatter.string(from: date)
    }

    /// Gets duration between `from` and `to` dates and formats it as seconds and milliseconds (e.g. "1s 123ms")
    static func formattedDuration(from fromDate: Date, to toDate: Date) -> String {
        let interval = fromDate.distance(to: toDate)
        let scaled = Int((interval * 1000.0).rounded(.towardZero))

        let seconds = scaled / 1000
        let milliseconds = scaled % 1000

        return "\(seconds)s \(milliseconds)ms"
    }
}
