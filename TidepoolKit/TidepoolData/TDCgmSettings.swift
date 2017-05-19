//
//  TDCGMSettings.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/18/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

open class TDCgmSettings: TidepoolData {
    
    public enum Manufacturer {
        case dexcom
        case medtronic
    }
    
    fileprivate var manufacturer: Manufacturer
    fileprivate var units: TDUnit.BG
    fileprivate var highAlerts: LevelAlerts
    fileprivate var lowAlerts: LevelAlerts
    fileprivate var outOfRangeAlerts: OutOfRangeAlerts
    fileprivate var rateOfChangeAlerts: RateOfChangeAlerts
    fileprivate var transmitterId: String
    
    public init(units: TDUnit.BG, highAlerts: LevelAlerts, lowAlerts: LevelAlerts, outOfRangeAlerts: OutOfRangeAlerts, rateOfChangeAlerts: RateOfChangeAlerts, transmitterId: String, time: Date?) {
        
        self.manufacturer = .dexcom
        self.units = units
        self.highAlerts = highAlerts
        self.lowAlerts = lowAlerts
        self.outOfRangeAlerts = outOfRangeAlerts
        self.rateOfChangeAlerts = rateOfChangeAlerts
        self.transmitterId = transmitterId
        
        super.init(type: .CGMSettings, subType: nil, time: time)
    }
    
    override func toDictionary(_ uploadId: String, deviceId: String) -> [String : AnyObject] {
        var retval: [String : AnyObject]
        
        if (self.manufacturer == .dexcom) {
            retval = [
                "clockDriftOffset": 0 as AnyObject,
                "conversionOffset": 0 as AnyObject,
                "deviceId": deviceId as AnyObject,
                "deviceTime": self.deviceTime as AnyObject,
                "guid": UUID().uuidString as AnyObject,
                "highAlerts": self.highAlerts.toDictionary() as AnyObject,
                "lowAlerts": self.lowAlerts.toDictionary() as AnyObject,
                "outOfRangeAlerts": self.outOfRangeAlerts.toDictionary() as AnyObject,
                "rateOfChangeAlerts": self.rateOfChangeAlerts.toDictionary() as AnyObject,
                "time": self.time as AnyObject,
                "timezoneOffset": self.timezoneOffset as AnyObject,
                "transmitterId": self.transmitterId as AnyObject,
                "type": self.type.rawValue as AnyObject,
                "units": self.units.rawValue as AnyObject,
                "uploadId": uploadId as AnyObject
            ]
        } else if (self.manufacturer == .medtronic) {
            retval = [:]
        } else {
            retval = [:]
        }
        
        return retval
    }
    
    open class LevelAlerts {
        fileprivate var enabled: Bool
        fileprivate var level: Double
        fileprivate var snooze: Int
        
        public init(enabled: Bool, level: Double, snooze: Int) {
            self.enabled = enabled
            self.level = level
            self.snooze = snooze
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject] = [
                "enabled": self.enabled as AnyObject,
                "level": self.level as AnyObject,
                "snooze": self.snooze as AnyObject
            ]
            return retval
        }
    }
    
    open class OutOfRangeAlerts {
        fileprivate var enabled: Bool
        fileprivate var snooze: Int
        
        public init(enabled: Bool, snooze: Int) {
            self.enabled = enabled
            self.snooze = snooze
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject] = [
                "enabled": self.enabled as AnyObject,
                "snooze": self.snooze as AnyObject
            ]
            return retval
        }
    }
    
    open class RateOfChangeAlerts {
        fileprivate var fallRate: RateAlert
        fileprivate var riseRate: RateAlert
        
        public init(fallRate: RateAlert, riseRate: RateAlert) {
            self.fallRate = fallRate
            self.riseRate = riseRate
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject] = [
                "fallRate": self.fallRate.toDictionary() as AnyObject,
                "riseRate": self.riseRate.toDictionary() as AnyObject
            ]
            return retval
        }
        
        open class RateAlert {
            fileprivate var enabled: Bool
            fileprivate var rate: Double
            
            public init(enabled: Bool, rate: Double) {
                self.enabled = enabled
                self.rate = rate
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                let retval: [String : AnyObject] = [
                    "enabled": self.enabled as AnyObject,
                    "rate": self.rate as AnyObject
                ]
                return retval
            }
        }
    }
}
