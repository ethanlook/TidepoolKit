//
//  TDSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/8/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding Tidepool data.
open class TDSet {
    
    /// The grouped basal segments in the set.
    open var basal = TDBasalSet()
    
    /// The grouped blood ketone values in the set.
    open var bloodKetone = TDBloodKetoneSet()
    
    /// The grouped bolus events in the set.
    open var bolus = TDBolusSet()
    
    /// The grouped CBG values in the set.
    open var cbg = TDCbgSet()
    
    /// The grouped CGM settings in the set.
    open var cgmSettings = TDCgmSettingsSet()
    
    /// The grouped pump settings in the set.
    open var pumpSettings = TDPumpSettingsSet()
    
    /// The grouped smbg values in the set.
    open var smbg = TDSmbgSet()
    
    /// The grouped wizard/calculator events in the set.
    open var wizard = TDWizardSet()
    
    /// Returns an empty `TDSet`.
    public init() { }
    
    /**
     Adds a piece of `TidepoolData` to the dataset.
     
     - Parameter someData: The `TidepoolData` to be added to the set.
     - Returns: The `TDSet` itself for easy chaining.
     */
    open func add(_ someData: TidepoolData) -> TDSet {
        switch someData.type {
        case .Basal:
            basal.add(someData as! TDBasal)
        case .BloodKetone:
            bloodKetone.add(someData as! TDBloodKetone)
        case .Bolus:
            bolus.add(someData as! TDBolus)
        case .CBG:
            cbg.add(someData as! TDCbg)
        case .CGMSettings:
            cgmSettings.add(someData as! TDCgmSettings)
        case .PumpSettings:
            pumpSettings.add(someData as! TDPumpSettings)
        case .SMBG:
            smbg.add(someData as! TDSmbg)
        case .Wizard:
            wizard.add(someData as! TDWizard)
        }
        return self
    }
    
    /**
     Creates the associated `NSData` for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TidepoolData`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TidepoolData`.
     - Returns: `NSData` for the associated `TDSet`.
     */
    internal func toNSDataForUpload(_ uploadId: String, deviceId: String) -> Data {
        var jsonArray: [[String : AnyObject]] = []
        
        jsonArray += basal.toJSONArrayForUpload(uploadId, deviceId: deviceId)
        jsonArray += bloodKetone.toJSONArrayForUpload(uploadId, deviceId: deviceId)
        jsonArray += bolus.toJSONArrayForUpload(uploadId, deviceId: deviceId)
        jsonArray += cbg.toJSONArrayForUpload(uploadId, deviceId: deviceId)
        jsonArray += cgmSettings.toJSONArrayForUpload(uploadId, deviceId: deviceId)
        jsonArray += pumpSettings.toJSONArrayForUpload(uploadId, deviceId: deviceId)
        jsonArray += smbg.toJSONArrayForUpload(uploadId, deviceId: deviceId)
        jsonArray += wizard.toJSONArrayForUpload(uploadId, deviceId: deviceId)
        
        return try! JSONSerialization.data(withJSONObject: jsonArray, options: JSONSerialization.WritingOptions.prettyPrinted)
    }
}
