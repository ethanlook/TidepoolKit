//
//  TDCbgSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/21/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding CBG values.
public class TDCbgSet {
    
    private var data = [TDCbg]()
    
    /// Returns an empty `TDCbgSet`.
    public init() { }
    
    /**
     Adds a CBG value to the dataset.
     
     - Parameter someCbg: The `TDCbg` to be added to the set.
     - Returns: the `TDCbgSet` itself for easy chaining.
     */
    public func add(someCbg: TDCbg) -> TDCbgSet {
        data.append(someCbg)
        return self
    }
    
    /**
     Creates the associated JSON array for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TDCbg`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TDCbg`.
     - Returns: `[[String : AnyObject]]` for the associated `TDCbgSet`.
     */
    internal func toJSONArrayForUpload(uploadId: String, deviceId: String) -> [[String : AnyObject]] {
        return data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
    }
}