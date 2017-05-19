//
//  TDWizard.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/17/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

// Note: TDWizard will be depricated in favor of TDCalculator
open class TDWizard: TidepoolData {
    
    fileprivate var bolus: TDBolus
    fileprivate var units: TDUnit.BG
    fileprivate var bgInput: Double?
    fileprivate var bgTarget: BGTarget?
    fileprivate var carbInput: Int?
    fileprivate var insulinCarbRatio: Int?
    fileprivate var insulinOnBoard: Double?
    fileprivate var insulinSensitivity: Double?
    fileprivate var recommended: RecommendedBolus?
    
    public init(units: TDUnit.BG, bolus: TDBolus, bgInput: Double?, bgTarget: BGTarget?, carbInput: Int?, insulinCarbRatio: Int?, insulinOnBoard: Double?, insulinSensitivity: Double?, recommended: RecommendedBolus?, time: Date?) {
        
        self.units = units
        self.bolus = bolus
        self.bgInput = bgInput
        self.bgTarget = bgTarget
        self.carbInput = insulinCarbRatio
        self.insulinCarbRatio = insulinCarbRatio
        self.insulinOnBoard = insulinOnBoard
        self.insulinSensitivity = insulinSensitivity
        self.recommended = recommended
        
        super.init(type: .Wizard, subType: nil, time: time)
    }
    
    override func toDictionary(_ uploadId: String, deviceId: String) -> [String : AnyObject] {
        var retval: [String : AnyObject] = [
            "bolus": self.bolus.toDictionary(uploadId, deviceId: deviceId) as AnyObject,
            "clockDriftOffset": 0 as AnyObject,
            "conversionOffset": 0 as AnyObject,
            "deviceId": deviceId as AnyObject,
            "deviceTime": self.deviceTime as AnyObject,
            "guid": UUID().uuidString as AnyObject,
            "subType": self.subType! as AnyObject,
            "time": self.time as AnyObject,
            "timezoneOffset": self.timezoneOffset as AnyObject,
            "type": self.type.rawValue as AnyObject,
            "units": self.units.rawValue as AnyObject,
            "uploadId": uploadId as AnyObject
        ]
        
        if (self.bgInput != nil) {
            retval["bgInput"] = self.bgInput! as AnyObject
        }
        if (self.bgTarget != nil) {
            retval["bgTarget"] = self.bgTarget!.toDictionary() as AnyObject
        }
        if (self.carbInput != nil) {
            retval["carbInput"] = self.carbInput! as AnyObject
        }
        if (self.insulinCarbRatio != nil) {
            retval["insulinCarbRatio"] = self.insulinCarbRatio! as AnyObject
        }
        if (self.insulinOnBoard != nil) {
            retval["insulinOnBoard"] = self.insulinOnBoard! as AnyObject
        }
        if (self.insulinSensitivity != nil) {
            retval["insulinSensitivity"] = self.insulinSensitivity! as AnyObject
        }
        if (self.recommended != nil) {
            retval["recommended"] = self.recommended!.toDictionary() as AnyObject
        }
        
        return retval
    }
    
    public struct BGTarget {
        
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
        
        public init(target: Double, range: Double) {
            self.schema = .animas
            
            self.target = target
            self.range = range
        }
        
        public init(target: Double, high: Double) {
            self.schema = .insulet
            
            self.target = target
            self.high = high
        }
        
        public init(low: Double, high: Double) {
            self.schema = .medtronic
            
            self.low = low
            self.high = high
        }
        
        public init(target: Double) {
            self.schema = .tandem
            
            self.target = target
        }
        
        func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject]
            
            switch self.schema {
            case .animas:
                retval = [
                    "target": self.target! as AnyObject,
                    "range": self.range! as AnyObject
                ]
            case .insulet:
                retval = [
                    "target": self.target! as AnyObject,
                    "high": self.high! as AnyObject
                ]
            case .medtronic:
                retval = [
                    "low": self.low! as AnyObject,
                    "high": self.high! as AnyObject
                ]
            case .tandem:
                retval = [
                    "target": self.target! as AnyObject
                ]
            }
            
            return retval
        }
    }
    
    public struct RecommendedBolus {
        fileprivate var carb: Double?
        fileprivate var correction: Double?
        fileprivate var net: Double?
        
        public init(carb: Double?, correction: Double?, net: Double?) {
            self.carb = carb
            self.correction = correction
            self.net = net
        }
        
        func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            
            if (self.carb != nil) {
                retval["carb"] = self.carb! as AnyObject
            }
            if (self.correction != nil) {
                retval["correction"] = self.correction! as AnyObject
            }
            if (self.net != nil) {
                retval["net"] = self.net! as AnyObject
            }
            
            return retval
        }
    }
}
