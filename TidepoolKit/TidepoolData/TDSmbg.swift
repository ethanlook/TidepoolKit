//
//  TDSmbg.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public class TDSmbg: TidepoolData {
    var value: Double
    var units: TDUnit.BG
    
    public init(units: TDUnit.BG, value: Double, time: NSDate?) {
        self.value = value
        self.units = units
        
        super.init(type: .SMBG, subType: nil, time: time)
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