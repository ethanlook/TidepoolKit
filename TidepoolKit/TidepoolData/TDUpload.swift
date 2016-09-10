//
//  TDUpload.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/19/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/**
 Self-monitored blood glucose, as measured with a fingerstick blood-glucose meter.
 */
private class TDUpload: TidepoolData {
    
    /**
     Returns a `TDUpload` object representing a self-monitored blood glucose value.
     
     - Parameter units: Of type `TDUnit.BG`, the units of `value`.
     - Parameter value: The actual blood glucose value.
     - Parameter time: Optional, the timestamp at which the reading occured.
     - Returns: The `TDSmbg` object.
     */
    private init(time: NSDate?) {
        
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
            "uploadId": uploadId
        ]
        return retval
    }
}