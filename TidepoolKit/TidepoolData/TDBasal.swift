//
//  TDBasal.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/16/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public class TDBasal: TidepoolData {
    
    public enum DeliveryType: String {
        case Scheduled = "scheduled"
        case Temp = "temp"
        case Suspend = "suspend"
    }
    
    var deliveryType: DeliveryType
    var duration: Int
    var rate: Double
    
    public init(deliveryType: DeliveryType, duration: Int, rate: Double, time: NSDate?) {
        self.deliveryType = deliveryType
        self.duration = duration
        self.rate = rate
        
        super.init(type: .Basal, subType: nil, time: time)
    }
    
    override func toDictionary(uploadId: String, deviceId: String) -> [String : AnyObject] {
        let retval: [String : AnyObject] = [
            "clockDriftOffset": 0,
            "conversionOffset": 0,
            "deliveryType": self.deliveryType.rawValue,
            "deviceId": deviceId,
            "deviceTime": self.deviceTime,
            "duration": self.duration,
            "rate": self.rate,
            "guid": NSUUID().UUIDString,
            "time": self.time,
            "timezoneOffset": self.timezoneOffset,
            "type": self.type.rawValue,
            "uploadId": uploadId
        ]
        return retval
    }
}