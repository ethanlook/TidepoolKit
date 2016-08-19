//
//  TDCommonData.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public enum TDUnit {
    public enum BG: String {
        case MGDL = "mg/dL"
        case MMOLL = "mmol/L"
    }
    public enum Carbs: String {
        case Grams = "grams"
    }
}

public enum TDType: String {
    case SMBG = "smbg"
    case CBG = "cbg"
    case BloodKetone = "bloodKetone"
    case Bolus = "bolus"
    case Basal = "basal"
    case Wizard = "wizard"
    case CGMSettings = "cgmSettings"
    case PumpSettings = "pumpSettings"
}

public class TidepoolData {
    let conversionOffset = 0
    var deviceTime: String = Datetime.getDeviceTimeForDate(NSDate())
    var subType: String?
    var time: String = Datetime.getISOStringForDate(NSDate())
    let timezoneOffset: Int = Datetime.getTimezoneOffset()
    var type: TDType
    
    internal init(type: TDType, subType: String?, time: NSDate?) {
        self.type = type
        self.subType = subType
        
        if (time != nil) {
            self.deviceTime = Datetime.getDeviceTimeForDate(time!)
            self.time = Datetime.getISOStringForDate(time!)
        }
    }
    
    internal func toDictionary(uploadId: String, deviceId: String) -> [String : AnyObject] {
        return [:]
    }
}