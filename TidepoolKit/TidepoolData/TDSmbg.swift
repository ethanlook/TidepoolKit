//
//  TDSmbg.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/**
 Self-monitored blood glucose, as measured with a fingerstick blood-glucose meter.
 */
public class TDSmbg: TidepoolData {
    var value: Double
    var units: TDUnit.BG
    
    /**
     Returns a `TDSmbg` object representing a self-monitored blood glucose value.
     
     - Parameter units: Of type `TDUnit.BG`, the units of `value`.
     - Parameter value: The actual blood glucose value.
     - Parameter time: *Optional*, the timestamp at which the reading occured.
     - Returns: The `TDSmbg` object.
     */
    public init(units: TDUnit.BG, value: Double, time: NSDate?) {
        self.value = value
        self.units = units
        
        super.init(type: .SMBG, subType: nil, time: time)
    }
    
    /**
     Returns a dictionary representation of the `TDSmbg` object.
     
     - Note: This method is not intended to be called by a client, hence its `internal` designation.
     
     - Parameter uploadId: The associated `uploadId` to be included in the dictionary.
     - Parameter deviceId: The associated `deviceId` to be included in the dictionary.
     - Returns: A dictionary representation of the `TDSmbg` object.
     */
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