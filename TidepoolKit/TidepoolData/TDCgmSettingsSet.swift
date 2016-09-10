//
//  TDCgmSettingsSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/21/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding CGM settings.
public class TDCgmSettingsSet {
    
    private var data = [TDCgmSettings]()
    
    /// Returns an empty `TDCgmSettingsSet`.
    public init() { }
    
    /**
     Adds CGM settings to the dataset.
     
     - Parameter someCgmSettings: The `TDCgmSettings` to be added to the set.
     - Returns: the `TDCgmSettingsSet` itself for easy chaining.
     */
    public func add(someCgmSettings: TDCgmSettings) -> TDCgmSettingsSet {
        data.append(someCgmSettings)
        return self
    }
    
    /**
     Creates the associated JSON array for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TDCgmSettings`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TDCgmSettings`.
     - Returns: `[[String : AnyObject]]` for the associated `TDCgmSettingsSet`.
     */
    internal func toJSONArrayForUpload(uploadId: String, deviceId: String) -> [[String : AnyObject]] {
        return data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
    }
}