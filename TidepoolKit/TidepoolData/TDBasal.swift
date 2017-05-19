//
//  TDBasal.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/16/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

open class TDBasal: TidepoolData {
    
    public enum DeliveryType: String {
        case Scheduled = "scheduled"
        case Temp = "temp"
        case Suspend = "suspend"
    }
    
    var deliveryType: DeliveryType
    var duration: Int
    var rate: Double
    
    public init(deliveryType: DeliveryType, duration: Int, rate: Double, time: Date?) {
        self.deliveryType = deliveryType
        self.duration = duration
        self.rate = rate
        
        super.init(type: .Basal, subType: nil, time: time)
    }
    
    override func toDictionary(_ uploadId: String, deviceId: String) -> [String : AnyObject] {
        let retval: [String : AnyObject] = [
            "clockDriftOffset": 0 as AnyObject,
            "conversionOffset": 0 as AnyObject,
            "deliveryType": self.deliveryType.rawValue as AnyObject,
            "deviceId": deviceId as AnyObject,
            "deviceTime": self.deviceTime as AnyObject,
            "duration": self.duration as AnyObject,
            "rate": self.rate as AnyObject,
            "guid": UUID().uuidString as AnyObject,
            "time": self.time as AnyObject,
            "timezoneOffset": self.timezoneOffset as AnyObject,
            "type": self.type.rawValue as AnyObject,
            "uploadId": uploadId as AnyObject
        ]
        return retval
    }
}
