import UIKit

let calendar = Calendar.current
let components = DateComponents(calendar: .current, year: 2023, month: 2, day: 1)
let date = components.date!
let range = date.daysInMonthBeforeToday!

extension Date {
    /// An optional range of integers containing
    /// the days of the current month.
    ///
    var daysInMonth: Range<Int>? {
        Calendar.current.range(of: .day, in: .month, for: self)
    }
    
    /// An optional range of integers containing the days
    /// of the current month before the current day (inclusive).
    ///
    var daysInMonthBeforeToday: Range<Int>? {
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

