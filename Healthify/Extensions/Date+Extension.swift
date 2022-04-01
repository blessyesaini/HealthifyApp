//
//  Date+Extensio.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 29/03/2022.
//

import Foundation

extension Date {

    
    /// To get the month and year of the date
    /// - Returns: Month and year in string format
    func getCurrentMonthAndYear() -> String {
       
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM" // format January, February, March, ...
        let name = nameFormatter.string(from: self)
        let year = Calendar.current.component(.year, from: self)
        return "\(name) \(year)"
    }
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
          return calendar.component(component, from: self)
      }
    func makeDayPredicate() -> NSPredicate {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 00
        components.minute = 00
        components.second = 00
        let startDate = calendar.date(from: components)
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endDate = calendar.date(from: components)
        return NSPredicate(format: "date >= %@ AND date =< %@", argumentArray: [startDate!, endDate!])
    }
    
    /// Days betwen 2 dates
    /// - Parameters:
    ///   - startDate: From date
    ///   - endDate: To Date
    /// - Returns: Difference between 2 days
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = NSCalendar.current

        let components = calendar.dateComponents([.day], from: startDate, to: endDate)

        return components.day ?? 0
    }
    
    /// First Day of the month
    /// - Returns: Date of the first day of the month
    func startOfMonth() -> Date {
          return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
      }
}
