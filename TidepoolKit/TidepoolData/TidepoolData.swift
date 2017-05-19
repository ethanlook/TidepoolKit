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
open class TidepoolData {
    internal var clockDriftOffset: Int = 0
    internal var conversionOffset: Int = 0
    internal var deviceId: String?
    internal var deviceTime: String = Datetime.getDeviceTimeForDate(Date())
    internal var guid: String?
    internal var subType: String?
    internal var time: String = Datetime.getISOStringForDate(Date())
    internal var timezoneOffset: Int = Datetime.getTimezoneOffset()
    internal var type: TDType
    internal var uploadId: String?
    
    internal init(type: TDType, subType: String?, time: Date?) {
        self.type = type
        self.subType = subType
        
        if (time != nil) {
            self.deviceTime = Datetime.getDeviceTimeForDate(time!)
            self.time = Datetime.getISOStringForDate(time!)
        }
    }
    
    internal init(clockDriftOffset: Int, conversionOffset: Int, deviceId: String, deviceTime: String, guid: String, time: String, timezoneOffset: Int, type: TDType, uploadId: String) {
        
        self.clockDriftOffset = clockDriftOffset
        self.conversionOffset = conversionOffset
        self.deviceId = deviceId
        self.deviceTime = deviceTime
        self.guid = guid
        self.time = time
        self.timezoneOffset = timezoneOffset
        self.type = type
        self.uploadId = uploadId
        
    }
    
    /**
     Returns a dictionary representation of the `TidepoolData` object.
     
     - Note: This method is not intended to be called by a client, hence its `internal` designation. In addition, because an instance of this class cannot be created, this method simply returns an empty dictionary. Subclasses of `TidepoolData` are expected to override the function.
     
     - Parameter uploadId: The associated `uploadId` to be included in the dictionary.
     - Parameter deviceId: The associated `deviceId` to be included in the dictionary.
     - Returns: A dictionary representation of the `TDSmbg` object.
     */
    internal func toDictionary(_ uploadId: String, deviceId: String) -> [String : AnyObject] {
        return [:]
    }
}
