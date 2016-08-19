//
//  TDBloodKetone.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/16/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public class TDBloodKetone: TidepoolData {
    var value: Double
    var units: TDUnit.BG
    
    public init(value: Double, time: NSDate?) {
        self.value = value
        self.units = .MMOLL
        
        super.init(type: .BloodKetone, subType: nil, time: time)
    }
    
    override func toDictionary(uploadId: String, deviceId: String) -> [String : AnyObject] {
        let retval: [String : AnyObject] = [
            "clockDriftOffset": 0,
            "conversionOffset": 0,
            "deviceId": deviceId,
            "deviceTime": self.deviceTime,
            "guid": NSUUID().UUIDString,
            "time": self.time,
            "timezoneOffset": self.timezoneOffset,
            "type": self.type.rawValue,
            "units": self.units.rawValue,
            "uploadId": uploadId,
            "value": self.value
        ]
        return retval
    }
}