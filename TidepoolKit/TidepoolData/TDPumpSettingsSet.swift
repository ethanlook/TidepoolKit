//
//  TDPumpSettingsSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/21/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding pump settings.
open class TDPumpSettingsSet {
    
    fileprivate var data = [TDPumpSettings]()
    
    /// Returns an empty `TDPumpSettingsSet`.
    public init() { }
    
    /**
     Adds pump settings to the dataset.
     
     - Parameter somePumpSettings: The `TDPumpSettings` to be added to the set.
     - Returns: the `TDPumpSettingsSet` itself for easy chaining.
     */
    open func add(_ somePumpSettings: TDPumpSettings) -> TDPumpSettingsSet {
        data.append(somePumpSettings)
        return self
    }
    
    /**
     Creates the associated JSON array for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TDPumpSettings`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TDPumpSettings`.
     - Returns: `[[String : AnyObject]]` for the associated `TDPumpSettingsSet`.
     */
    internal func toJSONArrayForUpload(_ uploadId: String, deviceId: String) -> [[String : AnyObject]] {
        return data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
    }
}
