//
//  TDBasalSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/21/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding basal segments.
public class TDBasalSet {
    
    private var data = [TDBasal]()
    
    /// Returns an empty `TDBasalSet`.
    public init() { }
    
    /**
     Adds a basal segment to the dataset.
     
     - Parameter someBasal: The `TDBasal` to be added to the set.
     - Returns: the `TDBasalSet` itself for easy chaining.
     */
    public func add(someBasal: TDBasal) -> TDBasalSet {
        data.append(someBasal)
        return self
    }
    
    /**
     Creates the associated JSON array for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TDBasal`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TDBasal`.
     - Returns: `[[String : AnyObject]]` for the associated `TDBasalSet`.
     */
    internal func toJSONArrayForUpload(uploadId: String, deviceId: String) -> [[String : AnyObject]] {
        return data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
    }
}