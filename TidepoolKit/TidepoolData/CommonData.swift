//
//  CommonData.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

class CommonData {
    internal var data: NSMutableDictionary = [
        "conversionOffset": 0,
        "deviceId": "TidepoolKit",
        "deviceTime": NSDate(),
        "time": NSDate(),
        "timezoneOffset": NSTimeZone.localTimeZone().secondsFromGMT / 60,
    ]
    
    init(type: String, subType: String?, deviceId: String) {
        let newDeviceId: String = String(self.data["deviceId"]) + deviceId
        self.data["deviceId"] = newDeviceId
        self.data["type"] = type
        self.data["subType"] = subType
    }
}