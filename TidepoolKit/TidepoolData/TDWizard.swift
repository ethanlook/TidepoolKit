//
//  TDWizard.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/17/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

// Note: TDWizard will be depricated in favor of TDCalculator
public class TDWizard: TidepoolData {
    
    private var bolus: TDBolus
    private var units: TDUnit.BG
    private var bgInput: Double?
    private var bgTarget: BGTarget?
    private var carbInput: Int?
    private var insulinCarbRatio: Int?
    private var insulinOnBoard: Double?
    private var insulinSensitivity: Double?
    private var recommended: RecommendedBolus?
    
    public init(units: TDUnit.BG, bolus: TDBolus, bgInput: Double?, bgTarget: BGTarget?, carbInput: Int?, insulinCarbRatio: Int?, insulinOnBoard: Double?, insulinSensitivity: Double?, recommended: RecommendedBolus?, time: NSDate?) {
        
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
    
    override func toDictionary(uploadId: String, deviceId: String) -> [String : AnyObject] {
        var retval: [String : AnyObject] = [
            "bolus": self.bolus.toDictionary(uploadId, deviceId: deviceId),
            "clockDriftOffset": 0,
            "conversionOffset": 0,
            "deviceId": deviceId,
            "deviceTime": self.deviceTime,
            "guid": NSUUID().UUIDString,
            "subType": self.subType!,
            "time": self.time,
            "timezoneOffset": self.timezoneOffset,
            "type": self.type.rawValue,
            "units": self.units.rawValue,
            "uploadId": uploadId
        ]
        
        if (self.bgInput != nil) {
            retval["bgInput"] = self.bgInput!
        }
        if (self.bgTarget != nil) {
            retval["bgTarget"] = self.bgTarget!.toDictionary()
        }
        if (self.carbInput != nil) {
            retval["carbInput"] = self.carbInput!
        }
        if (self.insulinCarbRatio != nil) {
            retval["insulinCarbRatio"] = self.insulinCarbRatio!
        }
        if (self.insulinOnBoard != nil) {
            retval["insulinOnBoard"] = self.insulinOnBoard!
        }
        if (self.insulinSensitivity != nil) {
            retval["insulinSensitivity"] = self.insulinSensitivity!
        }
        if (self.recommended != nil) {
            retval["recommended"] = self.recommended!.toDictionary()
        }
        
        return retval
    }
    
    public struct BGTarget {
        
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
        
        public init(target: Double, range: Double) {
            self.schema = .Animas
            
            self.target = target
            self.range = range
        }
        
        public init(target: Double, high: Double) {
            self.schema = .Insulet
            
            self.target = target
            self.high = high
        }
        
        public init(low: Double, high: Double) {
            self.schema = .Medtronic
            
            self.low = low
            self.high = high
        }
        
        public init(target: Double) {
            self.schema = .Tandem
            
            self.target = target
        }
        
        func toDictionary() -> [String : AnyObject] {
            let retval: [String : AnyObject]
            
            switch self.schema {
            case .Animas:
                retval = [
                    "target": self.target!,
                    "range": self.range!
                ]
            case .Insulet:
                retval = [
                    "target": self.target!,
                    "high": self.high!
                ]
            case .Medtronic:
                retval = [
                    "low": self.low!,
                    "high": self.high!
                ]
            case .Tandem:
                retval = [
                    "target": self.target!
                ]
            }
            
            return retval
        }
    }
    
    public struct RecommendedBolus {
        private var carb: Double?
        private var correction: Double?
        private var net: Double?
        
        public init(carb: Double?, correction: Double?, net: Double?) {
            self.carb = carb
            self.correction = correction
            self.net = net
        }
        
        func toDictionary() -> [String : AnyObject] {
            var retval: [String : AnyObject] = [:]
            
            if (self.carb != nil) {
                retval["carb"] = self.carb!
            }
            if (self.correction != nil) {
                retval["correction"] = self.correction!
            }
            if (self.net != nil) {
                retval["net"] = self.net!
            }
            
            return retval
        }
    }
}