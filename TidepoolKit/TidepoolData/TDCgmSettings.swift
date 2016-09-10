//
//  TDCGMSettings.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/18/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public class TDCgmSettings: TidepoolData {
    
    public enum Manufacturer {
        case Dexcom
        case Medtronic
    }
    
    private var manufacturer: Manufacturer
    private var units: TDUnit.BG
    private var highAlerts: LevelAlerts
    private var lowAlerts: LevelAlerts
    private var outOfRangeAlerts: OutOfRangeAlerts
    private var rateOfChangeAlerts: RateOfChangeAlerts
    private var transmitterId: String
    
    public init(units: TDUnit.BG, highAlerts: LevelAlerts, lowAlerts: LevelAlerts, outOfRangeAlerts: OutOfRangeAlerts, rateOfChangeAlerts: RateOfChangeAlerts, transmitterId: String, time: NSDate?) {
        
        self.manufacturer = .Dexcom
        self.units = units
        self.highAlerts = highAlerts
        self.lowAlerts = lowAlerts
        self.outOfRangeAlerts = outOfRangeAlerts
        self.rateOfChangeAlerts = rateOfChangeAlerts
        self.transmitterId = transmitterId
        
        super.init(type: .CGMSettings, subType: nil, time: time)
    }
    
    override func toDictionary(uploadId: String, deviceId: String) -> [String : AnyObject] {
        var retval: [String : AnyObject]
        
        if (self.manufacturer == .Dexcom) {
            retval = [
                "clockDriftOffset": 0,
                "conversionOffset": 0,
                "deviceId": deviceId,
                "deviceTime": self.deviceTime,
                "guid": NSUUID().UUIDString,
                "highAlerts": self.highAlerts.toDictionary(),
                "lowAlerts": self.lowAlerts.toDictionary(),
                "outOfRangeAlerts": self.outOfRangeAlerts.toDictionary(),
                "rateOfChangeAlerts": self.rateOfChangeAlerts.toDictionary(),
                "time": self.time,
                "timezoneOffset": self.timezoneOffset,
                "transmitterId": self.transmitterId,
                "type": self.type.rawValue,
                "units": self.units.rawValue,
                "uploadId": uploadId
            ]
        } else if (self.manufacturer == .Medtronic) {
            retval = [:]
        } else {
            retval = [:]
        }
        
        return retval
    }
    
    public class LevelAlerts {
        private var enabled: Bool
        private var level: Double
        private var snooze: Int
        
        public init(enabled: Bool, level: Double, snooze: Int) {
            self.enabled = enabled
            self.level = level
            self.snooze = snooze
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject] = [
                "enabled": self.enabled,
                "level": self.level,
                "snooze": self.snooze
            ]
            return retval
        }
    }
    
    public class OutOfRangeAlerts {
        private var enabled: Bool
        private var snooze: Int
        
        public init(enabled: Bool, snooze: Int) {
            self.enabled = enabled
            self.snooze = snooze
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject] = [
                "enabled": self.enabled,
                "snooze": self.snooze
            ]
            return retval
        }
    }
    
    public class RateOfChangeAlerts {
        private var fallRate: RateAlert
        private var riseRate: RateAlert
        
        public init(fallRate: RateAlert, riseRate: RateAlert) {
            self.fallRate = fallRate
            self.riseRate = riseRate
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject] = [
                "fallRate": self.fallRate.toDictionary(),
                "riseRate": self.riseRate.toDictionary()
            ]
            return retval
        }
        
        public class RateAlert {
            private var enabled: Bool
            private var rate: Double
            
            public init(enabled: Bool, rate: Double) {
                self.enabled = enabled
                self.rate = rate
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                let retval: [String : AnyObject] = [
                    "enabled": self.enabled,
                    "rate": self.rate
                ]
                return retval
            }
        }
    }
}