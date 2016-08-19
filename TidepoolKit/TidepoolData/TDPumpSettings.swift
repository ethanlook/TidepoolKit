//
//  TDPumpSettings.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/18/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public class TDPumpSettings: TidepoolData {
    
    private var units: Units
    private var activeSchedule: String
    private var basalSchedules: BasalSchedules
    
    private var bgTarget: BGTarget?
    private var carbRatio: CarbRatio?
    private var insulinSensitivity: InsulinSensitivity?
    
    private var bgTargets: BGTargets?
    private var carbRatios: CarbRatios?
    private var insulinSensitivities: InsulinSensitivities?
    
    public init(units: Units, activeSchedule: String, basalSchedules: BasalSchedules, bgTarget: BGTarget, carbRatio: CarbRatio, insulinSensitivity: InsulinSensitivity, time: NSDate?) {
        
        self.units = units
        self.activeSchedule = activeSchedule
        self.basalSchedules = basalSchedules
        
        self.bgTarget = bgTarget
        self.carbRatio = carbRatio
        self.insulinSensitivity = insulinSensitivity
        
        super.init(type: .PumpSettings, subType: nil, time: time)
    }
    
    public init(units: Units, activeSchedule: String, basalSchedules: BasalSchedules, bgTargets: BGTargets, carbRatios: CarbRatios, insulinSensitivities: InsulinSensitivities, time: NSDate?) {
        
        self.units = units
        self.activeSchedule = activeSchedule
        self.basalSchedules = basalSchedules
        
        self.bgTargets = bgTargets
        self.carbRatios = carbRatios
        self.insulinSensitivities = insulinSensitivities
        
        super.init(type: .PumpSettings, subType: nil, time: time)
    }
    
    override func toDictionary(uploadId: String, deviceId: String) -> [String : AnyObject] {
        var retval: [String : AnyObject] = [
            "activeSchedule": self.activeSchedule,
            "basalSchedules": self.basalSchedules.toDictionary(),
            "clockDriftOffset": 0,
            "conversionOffset": 0,
            "deviceId": deviceId,
            "deviceTime": self.deviceTime,
            "guid": NSUUID().UUIDString,
            "time": self.time,
            "timezoneOffset": self.timezoneOffset,
            "type": self.type.rawValue,
            "units": self.units.toDictionary(),
            "uploadId": uploadId
        ]
        
        if (self.bgTarget != nil && self.carbRatio != nil && self.insulinSensitivity != nil) {
            retval["bgTarget"] = self.bgTarget!.toDictionary()
            retval["carbRatio"] = self.carbRatio!.toDictionary()
            retval["insulinSensitivity"] = self.insulinSensitivity!.toDictionary()
        }
        if (self.bgTargets != nil && self.carbRatios != nil && self.insulinSensitivities != nil) {
            retval["bgTargets"] = self.bgTargets!.toDictionary()
            retval["carbRatios"] = self.carbRatios!.toDictionary()
            retval["insulinSensitivities"] = self.insulinSensitivities!.toDictionary()
        }
        
        return retval
    }
    
    public struct Units {
        private var carbs: TDUnit.Carbs
        private var bg: TDUnit.BG
        
        public init(carbs: TDUnit.Carbs, bg: TDUnit.BG) {
            self.carbs = carbs
            self.bg = bg
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject] = [
                "carbs": self.carbs.rawValue,
                "bg": self.bg.rawValue
            ]
            return retval
        }
    }
    
    public struct BasalSchedules {
        
        private var schedules: [String : BasalSchedule]
        
        public init(schedules: [String : BasalSchedule]) {
            self.schedules = schedules
        }

        internal func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            for (name, schedule) in schedules {
                retval[name] = schedule.toDictionary()
            }
            return retval
        }
    }
    
    public struct BasalSchedule {
        
        private var segments: [Segment]
        
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
            
            private var start: Int
            private var rate: Double
            
            public init(start: Int, rate: Double) {
                self.start = start
                self.rate = rate
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                let retval: [String : AnyObject] = [
                    "rate": self.rate,
                    "start": self.start
                ]
                return retval
            }
        }
    }
    
    public struct BGTargets {
        
        private var schedules: [String : BGTarget]
        
        public init(schedules: [String : BGTarget]) {
            self.schedules = schedules
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            for (name, schedule) in schedules {
                retval[name] = schedule.toDictionary()
            }
            return retval
        }
    }
    
    public struct BGTarget {

        private var segments: [Segment]
        
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
            
            private enum Schema {
                case Animas
                case Insulet
                case Medtronic
                case Tandem
            }
            
            private var schema: Schema
            private var low: Double?
            private var high: Double?
            private var target: Double?
            private var range: Double?
            private var start: Int
            
            public init(start: Int, target: Double, range: Double) {
                self.schema = .Animas
                
                self.start = start
                self.target = target
                self.range = range
            }
            
            public init(start: Int, target: Double, high: Double) {
                self.schema = .Insulet
                
                self.start = start
                self.target = target
                self.high = high
            }
            
            public init(start: Int, low: Double, high: Double) {
                self.schema = .Medtronic
                
                self.start = start
                self.low = low
                self.high = high
            }
            
            public init(start: Int, target: Double) {
                self.schema = .Tandem
                
                self.start = start
                self.target = target
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                var retval: [String : AnyObject] = [
                    "start": self.start
                ]
                if (self.low != nil) {
                    retval["low"] = self.low!
                }
                if (self.high != nil) {
                    retval["high"] = self.high!
                }
                if (self.target != nil) {
                    retval["target"] = self.target!
                }
                if (self.range != nil) {
                    retval["range"] = self.range!
                }
                return retval
            }
        }
    }
    
    public struct CarbRatios {
        
        private var schedules: [String : CarbRatio]
        
        public init(schedules: [String : CarbRatio]) {
            self.schedules = schedules
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            for (name, schedule) in schedules {
                retval[name] = schedule.toDictionary()
            }
            return retval
        }
    }
    
    public struct CarbRatio {
        
        private var segments: [Segment]
        
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
            
            private var start: Int
            private var amount: Int
            
            public init(start: Int, amount: Int) {
                self.start = start
                self.amount = amount
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                let retval: [String : AnyObject] = [
                    "start": self.start,
                    "amount": self.amount
                ]
                return retval
            }
        }
    }

    public struct InsulinSensitivities {
        
        private var schedules: [String : InsulinSensitivity]
        
        public init(schedules: [String : InsulinSensitivity]) {
            self.schedules = schedules
        }
        
        internal func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            for (name, schedule) in schedules {
                retval[name] = schedule.toDictionary()
            }
            return retval
        }
    }
    
    public struct InsulinSensitivity {
        
        private var segments: [Segment]
        
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
            
            private var start: Int
            private var amount: Int
            
            public init(start: Int, amount: Int) {
                self.start = start
                self.amount = amount
            }
            
            internal func toDictionary() -> [String : AnyObject] {
                let retval: [String : AnyObject] = [
                    "start": self.start,
                    "amount": self.amount
                ]
                return retval
            }
        }
    }
}