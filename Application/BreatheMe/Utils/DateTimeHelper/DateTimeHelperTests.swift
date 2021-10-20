//
//  DateTimeHelperTests.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 20.10.2021.
//

@testable import BreatheMe
import Foundation
import XCTest

class DateTimeHelperTests: XCTestCase {

    // MARK: - Formatted day

    func testFormattedDay_Today() {
        XCTAssertEqual(DateTimeHelper.formattedDayFromDate(Date()), "Today")
    }

    func testFormattedDay_Yesterday() {
        let date = Date().addingTimeInterval(-86401)
        XCTAssertEqual(DateTimeHelper.formattedDayFromDate(date), "Yesterday")
    }

    func testFormattedDay_ThisYear() {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())

        let date = Calendar.current.date(from: DateComponents(year: currentYear, month: 9, day: 5))!
        XCTAssertEqual(DateTimeHelper.formattedDayFromDate(date), "5 Sep")
    }

    func testFormattedDay_PastYear() {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())

        let date = Calendar.current.date(from: DateComponents(year: currentYear - 1, month: 9, day: 5))!
        XCTAssertEqual(DateTimeHelper.formattedDayFromDate(date), "5 Sep \(currentYear - 1)")
    }

    // MARK: - Formatted time

    func testFormattedTime_12Hours() {
        let date = Calendar.current.date(from: DateComponents(hour: 11, minute: 55, second: 12))!
        XCTAssertEqual(DateTimeHelper.formattedTimeFromDate(date), "11:55:12")
    }

    func testFormattedTime_24Hours() {
        let calendar = Calendar.current
        let date = calendar.date(from: DateComponents(hour: 21, minute: 55, second: 12))!
        XCTAssertEqual(DateTimeHelper.formattedTimeFromDate(date), "21:55:12")
    }

    // MARK: - Formatterd duration tests

    func testFormattedDuration_Normal() {
        let date1 = Date()
        let date2 = Date().addingTimeInterval(-10.213)
        XCTAssertEqual(DateTimeHelper.formattedDuration(from: date2, to: date1), "10s 213ms")
    }

    func testFormattedDuration_ZeroSeconds() {
        let date1 = Date()
        let date2 = Date().addingTimeInterval(-0.2)
        XCTAssertEqual(DateTimeHelper.formattedDuration(from: date2, to: date1), "0s 200ms")
    }

    func testFormattedDuration_ZeroMilliseconds() {
        let date1 = Date()
        let date2 = Date().addingTimeInterval(-1.0)
        XCTAssertEqual(DateTimeHelper.formattedDuration(from: date2, to: date1), "1s 0ms")
    }

    func testFormattedDuration_Zero() {
        let date1 = Date()
        let date2 = Date()
        XCTAssertEqual(DateTimeHelper.formattedDuration(from: date2, to: date1), "0s 0ms")
    }

    func testFormattedDuration_PastDateGreaterThanFuture() {
        let date1 = Date()
        let date2 = Date().addingTimeInterval(1.213)
        XCTAssertEqual(DateTimeHelper.formattedDuration(from: date2, to: date1), "1s 213ms")
    }
}
