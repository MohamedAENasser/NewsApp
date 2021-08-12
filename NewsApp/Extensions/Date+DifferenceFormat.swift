//
//  Date+DifferenceFormat.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 11/08/2021.
//

import Foundation

extension Date {
    func offset(from date: Date) -> String {
        let dayHourMinuteSecond: Set<Calendar.Component> = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)

        var number = 0
        var dateString = ""
        if let years = difference.year, years > 0 {
            number = years
            dateString = "date_year"
        }
        else if let months = difference.month, months > 0 {
            number = months
            dateString = "date_month"
        }
        else if let weeks = difference.weekOfMonth, weeks > 0 {
            number = weeks
            dateString = "date_week"
        }
        else if let days = difference.day, days > 0 {
            number = days
            dateString = "date_day"
        }
        else if let hours = difference.hour, hours > 0 {
            number = hours
            dateString = "date_hour"
        }
        else if let minutes = difference.minute, minutes > 0 {
            number = minutes
            dateString = "date_minute"
        }
        else if let seconds = difference.second, seconds > 0 {
            number = seconds
            dateString = "date_second"
        } else {
            return ""
        }
        var finalDateString = "dashboard_date_prefix".localized + " "
        switch number {
        case 1:
            finalDateString += "\(dateString)_singular".localized
        case 2:
            finalDateString += "\(dateString)_double".localized
        case let num where num <= 10:
            finalDateString += "\(number)".localized + " "
            finalDateString += "\(dateString)_less_than_10".localized
        default:
            finalDateString += "\(number)".localized + " "
            finalDateString += "\(dateString)_plural".localized
        }
        return finalDateString
    }
}
