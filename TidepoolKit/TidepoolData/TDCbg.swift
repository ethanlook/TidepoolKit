//
//  TDCbg.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// Continuous blood glucose, as measured with a continuous blood-glucose monitor.
open class TDCbg: TidepoolData {
    var value: Double
    var units: TDUnit.BG
    
    /**
     Returns a `TDCbg` object representing a continuous blood glucose value. Use this init when creating a new cbg value that is not already represented on Tidepool servers.
     
     - Parameter units: Of type `TDUnit.BG`, the units of `value`.
     - Parameter value: The actual blood glucose value.
     - Parameter time: Optional, the timestamp at which the reading occured.
     - Returns: A `TDCbg` object.
     */
    public init(units: TDUnit.BG, value: Double, time: Date?) {
        self.units = units
        self.value = value
        
        super.init(type: .CBG, subType: nil, time: time)
    }
    
    /**
     Returns a `TDCbg` object representing a continuous blood glucose value. Use this init when representing an event fetched from Tidepool.
     
     TODO verify that this is the correct model for client
     
     - Parameter clockDriftOffset: TODO
     - Parameter conversionOffset: TODO
     - Parameter deviceId: TODO
     - Parameter deviceTime: TODO
     - Parameter guid: TODO
     - Parameter time: TODO
     - Parameter timezoneOffset: TODO
     - Parameter units: Of type `TDUnit.BG`, the units of `value`.
     - Parameter uploadId: TODO
     - Parameter value: The actual blood glucose value.
     - Returns: A `TDCbg` object.
     */
    internal init(clockDriftOffset: Int, conversionOffset: Int, deviceId: String, deviceTime: String, guid: String, time: String, timezoneOffset: Int, units: TDUnit.BG, uploadId: String, value: Double) {
        
        self.units = units
        self.value = value
        
        super.init(clockDriftOffset: clockDriftOffset, conversionOffset: conversionOffset, deviceId: deviceId, deviceTime: deviceTime, guid: guid, time: time, timezoneOffset: timezoneOffset, type: .CBG, uploadId: uploadId)
    }
    
    /**
     Makes a `TDCbg` object from JSON data.
     
     - Parameter data: The JSON to be parsed into a cbg value.
     - Returns: A `TDCbg` object.
     */
    static internal func makeObjectFromJSON(_ data: AnyObject) -> TDCbg {
        return TDCbg(clockDriftOffset: data.value(forKey: "clockDriftOffset") as! Int,
                     conversionOffset: data.value(forKey: "conversionOffset") as! Int,
                     deviceId: data.value(forKey: "deviceId") as! String,
                     deviceTime: data.value(forKey: "deviceTime") as! String,
                     guid: data.value(forKey: "guid") as! String,
                     time: data.value(forKey: "time") as! String,
                     timezoneOffset: data.value(forKey: "timezoneOffset") as! Int,
                     units: TDUnit.BG(rawValue: data.value(forKey: "units") as! String)!,
                     uploadId: data.value(forKey: "uploadId") as! String,
                     value: data.value(forKey: "value") as! Double)
    }
    
    /**
     Returns a dictionary representation of the `TDCbg` object.
     
     - Note: This method is not intended to be called by a client, hence its `internal` designation.
     
     - Parameter uploadId: The associated `uploadId` to be included in the dictionary.
     - Parameter deviceId: The associated `deviceId` to be included in the dictionary.
     - Returns: A dictionary representation of the `TDCbg` object.
     */
    override func toDictionary(_ uploadId: String, deviceId: String) -> [String : AnyObject] {
        let retval: [String : AnyObject] = [
            "clockDriftOffset": self.clockDriftOffset as AnyObject,
            "conversionOffset": self.conversionOffset as AnyObject,
            "deviceId": self.deviceId as AnyObject ?? deviceId as AnyObject,
            "deviceTime": self.deviceTime as AnyObject,
            "guid": UUID().uuidString as AnyObject,
            "time": self.time as AnyObject,
            "timezoneOffset": self.timezoneOffset as AnyObject,
            "type": self.type.rawValue as AnyObject,
            "units": self.units.rawValue as AnyObject,
            "uploadId": self.uploadId as AnyObject ?? uploadId as AnyObject,
            "value": self.value as AnyObject
        ]
        return retval
    }
}
