//
//  Datetime.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/15/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public struct Datetime {
    
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
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.dateFromString(dateStr)
    }
    
    public static func dateFromComponents(components: NSDateComponents) -> NSDate? {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        return calendar?.dateFromComponents(components)
    }
}