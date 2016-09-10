//
//  TDSmbgSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/21/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding SMBG values.
public class TDSmbgSet {
    
    private var data = [TDSmbg]()
    
    /// Returns an empty `TDSmbgSet`.
    public init() { }
    
    /**
     Adds a SMBG value to the dataset.
     
     - Parameter someSmbg: The `TDSmbg` to be added to the set.
     - Returns: the `TDSmbgSet` itself for easy chaining.
     */
    public func add(someSmbg: TDSmbg) -> TDSmbgSet {
        data.append(someSmbg)
        return self
    }
    
    /**
     Creates the associated JSON array for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TDSmbg`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TDSmbg`.
     - Returns: `[[String : AnyObject]]` for the associated `TDSmbgSet`.
     */
    internal func toJSONArrayForUpload(uploadId: String, deviceId: String) -> [[String : AnyObject]] {
        return data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
    }
}