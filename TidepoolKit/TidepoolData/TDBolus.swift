//
//  TDBolus.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/16/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

open class TDBolus: TidepoolData {
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
    
    public init(normal: Double, expectedNormal: Double?, time: Date?) {
        self.normal = normal
        self.expectedNormal = expectedNormal
        
        super.init(type: .Bolus, subType: SubType.Normal.rawValue, time: time)
    }
    
    init(extended: Double, expectedExtended: Double?, duration: Int, expectedDuration: Int?, time: Date?) {
        self.extended = extended
        self.expectedExtended = expectedExtended
        self.duration = duration
        self.expectedDuration = expectedDuration
        
        super.init(type: .Bolus, subType: SubType.Square.rawValue, time: time)
    }
    
    init(normal: Double, expectedNormal: Double?, extended: Double, expectedExtended: Double?, duration: Int, expectedDuration: Int?, time: Date?) {
        self.normal = normal
        self.expectedNormal = expectedNormal
        self.extended = extended
        self.expectedExtended = expectedExtended
        self.duration = duration
        self.expectedDuration = expectedDuration
        
        super.init(type: .Bolus, subType: SubType.Combo.rawValue, time: time)
    }
    
    override func toDictionary(_ uploadId: String, deviceId: String) -> [String : AnyObject] {
        var retval: [String : AnyObject] = [
            "clockDriftOffset": 0 as AnyObject,
            "conversionOffset": 0 as AnyObject,
            "deviceId": deviceId as AnyObject,
            "deviceTime": self.deviceTime as AnyObject,
            "guid": UUID().uuidString as AnyObject,
            "subType": self.subType! as AnyObject,
            "time": self.time as AnyObject,
            "timezoneOffset": self.timezoneOffset as AnyObject,
            "type": self.type.rawValue as AnyObject,
            "uploadId": uploadId as AnyObject
        ]
        
        // All of the expected fields are optional.
        // A combination of normal, extended, and duration
        //  make up the three bolus subtypes.
        if (self.normal != nil) {
            retval["normal"] = self.normal! as AnyObject
        }
        if (self.expectedNormal != nil) {
            retval["expectedNormal"] = self.expectedNormal! as AnyObject
        }
        if (self.extended != nil) {
            retval["extended"] = self.extended! as AnyObject
        }
        if (self.expectedExtended != nil) {
            retval["expectedExtended"] = self.expectedExtended! as AnyObject
        }
        if (self.duration != nil) {
            retval["duration"] = self.duration! as AnyObject
        }
        if (self.expectedDuration != nil) {
            retval["expectedDuration"] = self.expectedDuration! as AnyObject
        }
        return retval
    }
}
