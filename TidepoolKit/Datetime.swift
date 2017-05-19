//
//  Datetime.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/15/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public struct Datetime {
    
    fileprivate static let MILLI_IN_MIN = 60000
    
    public static func getISOStringForDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.string(from: date)
    }
    
    public static func getDeviceTimeForDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    public static func getTimezoneOffset() -> Int {
        return NSTimeZone.local.secondsFromGMT() / 60
    }
    
    public static func dateForString(_ dateStr: String) -> Date? {
        let dateFormatterA = DateFormatter()
        dateFormatterA.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterB = DateFormatter()
        dateFormatterB.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        
        return dateFormatterA.date(from: dateStr) ?? dateFormatterB.date(from: dateStr)
    }
    
    public static func dateFromComponents(_ components: DateComponents) -> Date? {
        let calendar = Calendar.current
        return calendar.date(from: components)
    }
    
    public static func endTime(_ date: Date, minutes duration: Int) -> Date {
        let calendar = Calendar.current
        return (calendar as NSCalendar).date(byAdding: .minute, value: 5, to: date, options: [])!
    }
    
    public static func minutesBetweenDates(_ start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        return (calendar as NSCalendar).components(.minute, from: start, to: end, options: []).minute!
    }
    
    public static func millisecondsBetweenDates(_ start: Date, end: Date) -> Int {
        return minutesBetweenDates(start, end: end) * MILLI_IN_MIN
    }
}
