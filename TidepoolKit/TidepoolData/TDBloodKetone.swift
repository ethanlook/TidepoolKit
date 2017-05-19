//
//  TDBloodKetone.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/16/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

open class TDBloodKetone: TidepoolData {
    var value: Double
    var units: TDUnit.BG
    
    public init(value: Double, time: Date?) {
        self.value = value
        self.units = .MMOLL
        
        super.init(type: .BloodKetone, subType: nil, time: time)
    }
    
    override func toDictionary(_ uploadId: String, deviceId: String) -> [String : AnyObject] {
        let retval: [String : AnyObject] = [
            "clockDriftOffset": 0 as AnyObject,
            "conversionOffset": 0 as AnyObject,
            "deviceId": deviceId as AnyObject,
            "deviceTime": self.deviceTime as AnyObject,
            "guid": UUID().uuidString as AnyObject,
            "time": self.time as AnyObject,
            "timezoneOffset": self.timezoneOffset as AnyObject,
            "type": self.type.rawValue as AnyObject,
            "units": self.units.rawValue as AnyObject,
            "uploadId": uploadId as AnyObject,
            "value": self.value as AnyObject
        ]
        return retval
    }
}
