//
//  TDPumpSettings.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/18/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

open class TDPumpSettings: TidepoolData {
    
    fileprivate var units: Units
    fileprivate var activeSchedule: String
    fileprivate var basalSchedules: BasalSchedules
    
    fileprivate var bgTarget: BGTarget?
    fileprivate var carbRatio: CarbRatio?
    fileprivate var insulinSensitivity: InsulinSensitivity?
    
    fileprivate var bgTargets: BGTargets?
    fileprivate var carbRatios: CarbRatios?
    fileprivate var insulinSensitivities: InsulinSensitivities?
    
    public init(units: Units, activeSchedule: String, basalSchedules: BasalSchedules, bgTarget: BGTarget, carbRatio: CarbRatio, insulinSensitivity: InsulinSensitivity, time: Date?) {
        
        self.units = units
        self.activeSchedule = activeSchedule
        self.basalSchedules = basalSchedules
        
        self.bgTarget = bgTarget
        self.carbRatio = carbRatio
        self.insulinSensitivity = insulinSensitivity
        
        super.init(type: .PumpSettings, subType: nil, time: time!)
    }
    
    public init(units: Units, activeSchedule: String, basalSchedules: BasalSchedules, bgTargets: BGTargets, carbRatios: CarbRatios, insulinSensitivities: InsulinSensitivities, time: Date?) {
        
        self.units = units
        self.activeSchedule = activeSchedule
        self.basalSchedules = basalSchedules
        
        self.bgTargets = bgTargets
        self.carbRatios = carbRatios
        self.insulinSensitivities = insulinSensitivities
        
        super.init(type: .PumpSettings, subType: nil, time: time)
    }
    
    override func toDictionary(_ uploadId: String, deviceId: String) -> [String : AnyObject] {
        var retval: [String : AnyObject] = [
            "activeSchedule": self.activeSchedule as AnyObject,
            "basalSchedules": self.basalSchedules.toDictionary() as AnyObject,
            "clockDriftOffset": 0 as AnyObject,
            "conversionOffset": 0 as AnyObject,
            "deviceId": deviceId as AnyObject,
            "deviceTime": self.deviceTime as AnyObject,
            "guid": UUID().uuidString as AnyObject,
            "time": self.time as AnyObject,
            "timezoneOffset": self.timezoneOffset as AnyObject,
            "type": self.type.rawValue as AnyObject,
            "units": self.units.toDictionary() as AnyObject,
            "uploadId": uploadId as AnyObject
        ]
        
        if (self.bgTarget != nil && self.carbRatio != nil && self.insulinSensitivity != nil) {
            retval["bgTarget"] = self.bgTarget!.toDictionary() as AnyObject
            retval["carbRatio"] = self.carbRatio!.toDictionary() as AnyObject
            retval["insulinSensitivity"] = self.insulinSensitivity!.toDictionary() as AnyObject
        }
        if (self.bgTargets != nil && self.carbRatios != nil && self.insulinSensitivities != nil) {
            retval["bgTargets"] = self.bgTargets!.toDictionary() as AnyObject
            retval["carbRatios"] = self.carbRatios!.toDictionary() as AnyObject
            retval["insulinSensitivities"] = self.insulinSensitivities!.toDictionary() as AnyObject
        }
        
        return retval
    }
    
    public struct Units {
        fileprivate var carbs: TDUnit.Carbs
        fileprivate var bg: TDUnit.BG
        
        public init(carbs: TDUnit.Carbs, bg: TDUnit.BG) {
            self.carbs = carbs
            self.bg = bg
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject] = [
                "carbs": self.carbs.rawValue as AnyObject,
                "bg": self.bg.rawValue as AnyObject
            ]
            return retval
        }
    }
    
    public struct BasalSchedules {
        
        fileprivate var schedules: [String : BasalSchedule]
        
        public init(schedules: [String : BasalSchedule]) {
            self.schedules = schedules
        }

        internal func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            for (name, schedule) in schedules {
                retval[name] = schedule.toDictionary() as AnyObject
            }
            return retval
        }
    }
    
    public struct BasalSchedule {
        
        fileprivate var segments: [Segment]
        
        public init(segments: [Segment]) {
            self.segments = segments
        }
        
        internal func toDictionary() -> [[String : AnyObject]] {
            let retval: [[String : AnyObject]] = self.segments.map { (segment) -> [String : AnyObject] in
                return segment.toDictionary()
            }
            return retval
        }
        
        public struct Segment {
            
            fileprivate var start: Int
            fileprivate var rate: Double
            
            public init(start: Int, rate: Double) {
                self.start = start
                self.rate = rate
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                let retval: [String : AnyObject] = [
                    "rate": self.rate as AnyObject,
                    "start": self.start as AnyObject
                ]
                return retval
            }
        }
    }
    
    public struct BGTargets {
        
        fileprivate var schedules: [String : BGTarget]
        
        public init(schedules: [String : BGTarget]) {
            self.schedules = schedules
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            for (name, schedule) in schedules {
                retval[name] = schedule.toDictionary() as AnyObject
            }
            return retval
        }
    }
    
    public struct BGTarget {

        fileprivate var segments: [Segment]
        
        public init(segments: [Segment]) {
            self.segments = segments
        }
        
        internal func toDictionary() -> [[String : AnyObject]] {
            let retval: [[String : AnyObject]] = self.segments.map { (segment) -> [String : AnyObject] in
                return segment.toDictionary()
            }
            return retval
        }
        
        public struct Segment {
            
            fileprivate enum Schema {
                case animas
                case insulet
                case medtronic
                case tandem
            }
            
            fileprivate var schema: Schema
            fileprivate var low: Double?
            fileprivate var high: Double?
            fileprivate var target: Double?
            fileprivate var range: Double?
            fileprivate var start: Int
            
            public init(start: Int, target: Double, range: Double) {
                self.schema = .animas
                
                self.start = start
                self.target = target
                self.range = range
            }
            
            public init(start: Int, target: Double, high: Double) {
                self.schema = .insulet
                
                self.start = start
                self.target = target
                self.high = high
            }
            
            public init(start: Int, low: Double, high: Double) {
                self.schema = .medtronic
                
                self.start = start
                self.low = low
                self.high = high
            }
            
            public init(start: Int, target: Double) {
                self.schema = .tandem
                
                self.start = start
                self.target = target
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                var retval: [String : AnyObject] = [
                    "start": self.start as AnyObject
                ]
                if (self.low != nil) {
                    retval["low"] = self.low! as AnyObject
                }
                if (self.high != nil) {
                    retval["high"] = self.high! as AnyObject
                }
                if (self.target != nil) {
                    retval["target"] = self.target! as AnyObject
                }
                if (self.range != nil) {
                    retval["range"] = self.range! as AnyObject
                }
                return retval
            }
        }
    }
    
    public struct CarbRatios {
        
        fileprivate var schedules: [String : CarbRatio]
        
        public init(schedules: [String : CarbRatio]) {
            self.schedules = schedules
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            for (name, schedule) in schedules {
                retval[name] = schedule.toDictionary() as AnyObject
            }
            return retval
        }
    }
    
    public struct CarbRatio {
        
        fileprivate var segments: [Segment]
        
        public init(segments: [Segment]) {
            self.segments = segments
        }
        
        internal func toDictionary() -> [[String : AnyObject]] {
            let retval: [[String : AnyObject]] = self.segments.map { (segment) -> [String : AnyObject] in
                return segment.toDictionary()
            }
            return retval
        }
        
        public struct Segment {
            
            fileprivate var start: Int
            fileprivate var amount: Int
            
            public init(start: Int, amount: Int) {
                self.start = start
                self.amount = amount
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                let retval: [String : AnyObject] = [
                    "start": self.start as AnyObject,
                    "amount": self.amount as AnyObject
                ]
                return retval
            }
        }
    }

    public struct InsulinSensitivities {
        
        fileprivate var schedules: [String : InsulinSensitivity]
        
        public init(schedules: [String : InsulinSensitivity]) {
            self.schedules = schedules
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            for (name, schedule) in schedules {
                retval[name] = schedule.toDictionary() as AnyObject
            }
            return retval
        }
    }
    
    public struct InsulinSensitivity {
        
        fileprivate var segments: [Segment]
        
        public init(segments: [Segment]) {
            self.segments = segments
        }
        
        internal func toDictionary() -> [[String : AnyObject]] {
            let retval: [[String : AnyObject]] = self.segments.map { (segment) -> [String : AnyObject] in
                return segment.toDictionary()
            }
            return retval
        }
        
        public struct Segment {
            
            fileprivate var start: Int
            fileprivate var amount: Int
            
            public init(start: Int, amount: Int) {
                self.start = start
                self.amount = amount
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                let retval: [String : AnyObject] = [
                    "start": self.start as AnyObject,
                    "amount": self.amount as AnyObject
                ]
                return retval
            }
        }
    }
}
