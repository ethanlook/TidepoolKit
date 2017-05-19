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
    fileprivate init(time: Date?) {
        
        super.init(type: .SMBG, subType: nil, time: time)
    }
    
    /**
     Returns a dictionary representation of the `TDSmbg` object.
     
     - Note: This method is not intended to be called by a client, hence its `internal` designation.
     
     - Parameter uploadId: The associated `uploadId` to be included in the dictionary.
     - Parameter deviceId: The associated `deviceId` to be included in the dictionary.
     - Returns: A dictionary representation of the `TDSmbg` object.
     */
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
            "uploadId": uploadId as AnyObject
        ]
        return retval
    }
}
