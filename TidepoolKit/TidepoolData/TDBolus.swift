//
//  TDBolus.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/16/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public class TDBolus: TidepoolData {
    var normal: Double?
    var expectedNormal: Double?
    var extended: Double?
    var expectedExtended: Double?
    var duration: Int?
    var expectedDuration: Int?
    
    public enum SubType: String {
        case Normal = "normal"
        case Square = "square" // Will change to "extended"
        case Combo = "dual/square" // Will change to "combo"
    }
    
    public init(normal: Double, expectedNormal: Double?, time: NSDate?) {
        self.normal = normal
        self.expectedNormal = expectedNormal
        
        super.init(type: .Bolus, subType: SubType.Normal.rawValue, time: time)
    }
    
    init(extended: Double, expectedExtended: Double?, duration: Int, expectedDuration: Int?, time: NSDate?) {
        self.extended = extended
        self.expectedExtended = expectedExtended
        self.duration = duration
        self.expectedDuration = expectedDuration
        
        super.init(type: .Bolus, subType: SubType.Square.rawValue, time: time)
    }
    
    init(normal: Double, expectedNormal: Double?, extended: Double, expectedExtended: Double?, duration: Int, expectedDuration: Int?, time: NSDate?) {
        self.normal = normal
        self.expectedNormal = expectedNormal
        self.extended = extended
        self.expectedExtended = expectedExtended
        self.duration = duration
        self.expectedDuration = expectedDuration
        
        super.init(type: .Bolus, subType: SubType.Combo.rawValue, time: time)
    }
    
    override func toDictionary(uploadId: String, deviceId: String) -> [String : AnyObject] {
        var retval: [String : AnyObject] = [
            "clockDriftOffset": 0,
            "conversionOffset": 0,
            "deviceId": deviceId,
            "deviceTime": self.deviceTime,
            "guid": NSUUID().UUIDString,
            "subType": self.subType!,
            "time": self.time,
            "timezoneOffset": self.timezoneOffset,
            "type": self.type.rawValue,
            "uploadId": uploadId
        ]
        
        // All of the expected fields are optional.
        // A combination of normal, extended, and duration
        //  make up the three bolus subtypes.
        if (self.normal != nil) {
            retval["normal"] = self.normal!
        }
        if (self.expectedNormal != nil) {
            retval["expectedNormal"] = self.expectedNormal!
        }
        if (self.extended != nil) {
            retval["extended"] = self.extended!
        }
        if (self.expectedExtended != nil) {
            retval["expectedExtended"] = self.expectedExtended!
        }
        if (self.duration != nil) {
            retval["duration"] = self.duration!
        }
        if (self.expectedDuration != nil) {
            retval["expectedDuration"] = self.expectedDuration!
        }
        return retval
    }
}