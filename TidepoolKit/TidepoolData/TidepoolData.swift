//
//  TidepoolData.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A Tidepool data unit.
/// *"120 without units reads as 120 wombats."*
public enum TDUnit {
    /// Options for blood glucose values.
    public enum BG: String {
        /// Milligrams per deciliter.
        case MGDL = "mg/dL"
        
        /// Millimoles per liter.
        case MMOLL = "mmol/L"
    }
    
    /// Options for carb values.
    public enum Carbs: String {
        /// Grams
        case Grams = "grams"
    }
}

/// A Tidepool data type, and the associated string raw value.
public enum TDType: String {
    /// Self-monitored blood glucose, as measured with a fingerstick blood-glucose meter.
    case SMBG = "smbg"
    
    /// Continuous blood glucose, as measured with a continuous blood-glucose monitor.
    case CBG = "cbg"
    
    /// Blood ketone concentration, as measured by a fingerstick meter with blood ketone testing capabilities.
    case BloodKetone = "bloodKetone"
    
    /// A one-time dose of fast-acting insulin, as administered by an insulin pump.
    case Bolus = "bolus"
    
    /// A "slow drip" of insulin, as administered by an insulin pump.
    case Basal = "basal"
    
    /// A bolus event with associated "wizard" or "calculator" recommendations, as administered by an insulin pump.
    case Wizard = "wizard"
    
    /// The settings associated with a continuous blood-glucose monitor.
    case CGMSettings = "cgmSettings"
    
    /// The settings associated with an insulin pump.
    case PumpSettings = "pumpSettings"
}

/// A piece of Tidepool data and the common fields associated with all data.
public class TidepoolData {
    internal let conversionOffset = 0
    internal var deviceTime: String = Datetime.getDeviceTimeForDate(NSDate())
    internal var subType: String?
    internal var time: String = Datetime.getISOStringForDate(NSDate())
    internal let timezoneOffset: Int = Datetime.getTimezoneOffset()
    internal var type: TDType
    
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