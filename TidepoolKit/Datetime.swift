//
//  Datetime.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/15/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public struct Datetime {
    
    private static let MILLI_IN_MIN = 60000
    
    public static func getISOStringForDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.stringFromDate(date)
    }
    
    public static func getDeviceTimeForDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.stringFromDate(date)
    }
    
    public static func getTimezoneOffset() -> Int {
        return NSTimeZone.localTimeZone().secondsFromGMT / 60
    }
    
    public static func dateForString(dateStr: String) -> NSDate? {
        let dateFormatterA = NSDateFormatter()
        dateFormatterA.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterB = NSDateFormatter()
        dateFormatterB.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        
        return dateFormatterA.dateFromString(dateStr) ?? dateFormatterB.dateFromString(dateStr)
    }
    
    public static func dateFromComponents(components: NSDateComponents) -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateFromComponents(components)
    }
    
    public static func endTime(date: NSDate, minutes duration: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateByAddingUnit(.Minute, value: 5, toDate: date, options: [])!
    }
    
    public static func minutesBetweenDates(start: NSDate, end: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        return calendar.components(.Minute, fromDate: start, toDate: end, options: []).minute
    }
    
    public static func millisecondsBetweenDates(start: NSDate, end: NSDate) -> Int {
        return minutesBetweenDates(start, end: end) * MILLI_IN_MIN
    }
}