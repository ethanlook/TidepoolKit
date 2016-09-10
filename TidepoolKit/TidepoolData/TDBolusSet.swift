//
//  TDBolusSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/21/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding bolus events.
public class TDBolusSet {
    
    private var data = [TDBolus]()
    
    /// Returns an empty `TDBolusSet`.
    public init() { }
    
    /**
     Adds a bolus event to the dataset.
     
     - Parameter someBolus: The `TDBolus` to be added to the set.
     - Returns: the `TDBolusSet` itself for easy chaining.
     */
    public func add(someBolus: TDBolus) -> TDBolusSet {
        data.append(someBolus)
        return self
    }
    
    /**
     Creates the associated JSON array for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TDBolus`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TDBolus`.
     - Returns: `[[String : AnyObject]]` for the associated `TDBolusSet`.
     */
    internal func toJSONArrayForUpload(uploadId: String, deviceId: String) -> [[String : AnyObject]] {
        return data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
    }
}