//
//  Extensions.swift
//  WeatherApp-SwiftUI
//
//  Created by DB-MBP-023 on 12/04/24.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ corners: UIRectCorner, _ radius: CGFloat) -> some View {
        clipShape(RoundedCorner(corners: corners, radius: radius))
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {

    var corners: UIRectCorner = .allCorners
    var radius: CGFloat = .infinity
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//Rounded value
extension Double{
    func roundDouble()-> String{
        return String(format: "%.0f", self)
    }
    
}

extension Int {
    func epochTime(_ date: Double)-> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        return String(format: "\(date)", self)
    }
}

typealias UnixTimestamp = Int

extension Date {
    /// Date to Unix timestamp.
    var unixTimestamp: UnixTimestamp {
        return UnixTimestamp(self.timeIntervalSince1970) // millisecond precision
    }

    func stringFromDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    func stringFromDateYear(format: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY"
        let date = formatter.string(from: format)
        return date
    }
    
    func stringYearMonthDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let dateStr = formatter.string(from: date)
        return dateStr
    }
}

extension UnixTimestamp {
    /// Unix timestamp to date.
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(self / 1)) // must take a millisecond-precise Unix timestamp
    }
}
