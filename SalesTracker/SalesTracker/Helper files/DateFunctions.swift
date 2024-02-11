//
//  DateFunctions.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 07/02/24.
//

import Foundation

extension Date {
    
    /// Returns an absolute reference of the current date
    /// describing the day month and year:
    /// dd-MM-yyyy
    var absoluteReference: String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_MX") // For maintaing homogeneous month symbols
        formatter.timeZone = .gmt
        formatter.dateFormat = "dd-MM-yyyy"
        
        return formatter.string(from: self)
    }
    
    /// Returns the relative reference of the current date
    /// describing the month and year:
    /// MMM-yyyy
    var relativeReference: String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_MX") // For maintaining homoheneous references
        formatter.timeZone = .gmt
        formatter.dateFormat = "MMM-yyyy"
        
        return formatter.string(from: self).lowercased()
    }
    
    /// An optional range of integers containing
    /// the days of the current month.
    /// - Returns: Range<Int>?
    var daysInMonth: Range<Int>? {
        Calendar.current.range(of: .day, in: .month, for: self)
    }
    
    /// An optional range of integers containing the days
    /// of the current month before the current day (inclusive).
    /// - Returns: Range<Int>?
    var daysInMonthUntilToday: Range<Int>? {
        guard let daysInMonth else { return nil }
        let today = self.get(.day)
        return daysInMonth.prefix { $0 <= today }
    }
    
    /// Returns the value of the specified
    /// components of the current date.
    /// - Parameters:
    ///   - components: Calendar.component
    ///   - calendar: Calendar
    /// - Returns: DateComponents
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
            return calendar.dateComponents(Set(components), from: self)
        }
    
    
    /// Returns the value of the specified component
    /// of the current date.
    /// - Parameters:
    ///   - component: Calendar.Component
    ///   - calendar: Calendar
    /// - Returns: Int
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
