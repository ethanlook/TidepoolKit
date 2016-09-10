//
//  TDBloodKetoneSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/21/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding blood ketone values.
public class TDBloodKetoneSet {
    
    private var data = [TDBloodKetone]()
    
    /// Returns an empty `TDBloodKetoneSet`.
    public init() { }
    
    /**
     Adds a CBG value to the dataset.
     
     - Parameter someBloodKetone: The `TDBloodKetone` to be added to the set.
     - Returns: the `TDBloodKetoneSet` itself for easy chaining.
     */
    public func add(someBloodKetone: TDBloodKetone) -> TDBloodKetoneSet {
        data.append(someBloodKetone)
        return self
    }
    
    /**
     Creates the associated JSON array for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TDBloodKetone`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TDBloodKetone`.
     - Returns: `[[String : AnyObject]]` for the associated `TDBloodKetoneSet`.
     */
    internal func toJSONArrayForUpload(uploadId: String, deviceId: String) -> [[String : AnyObject]] {
        return data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
    }
}