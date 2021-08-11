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
            dateString = "year"
        }
        else if let months = difference.month, months > 0 {
            number = months
            dateString = "month"
        }
        else if let weeks = difference.weekOfMonth, weeks > 0 {
            number = weeks
            dateString = "week"
        }
        else if let days = difference.day, days > 0 {
            number = days
            dateString = "day"
        }
        else if let hours = difference.hour, hours > 0 {
            number = hours
            dateString = "hour"
        }
        else if let minutes = difference.minute, minutes > 0 {
            number = minutes
            dateString = "minute"
        }
        else if let seconds = difference.second, seconds > 0 {
            number = seconds
            dateString = "second"
        }
        dateString = "\(number) \(dateString)\(number > 1 ? "s" : "") ago"
        return dateString
    }
}
