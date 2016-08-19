//
//  TDSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/8/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding Tidepool data.
public class TDSet {
    private var data = [TidepoolData]()
    
    /// Returns an empty `TDSet`.
    public init() { }
    
    /**
     Adds a piece of `TidepoolData` to the dataset.
     
     - Parameter someData: The `TidepoolData` to be added to the set.
     - Returns: The `TDSet` itself for easy chaining.
     */
    public func add(someData: TidepoolData) -> TDSet {
        data.append(someData)
        return self
    }
    
    /**
     Creates the associated `NSData` for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TidepoolData`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TidepoolData`.
     - Returns: `NSData` for the associated `TDSet`.
     */
    internal func toJSONForUpload(uploadId: String, deviceId: String) -> NSData {
        let jsonArray = data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
        return try! NSJSONSerialization.dataWithJSONObject(jsonArray, options: NSJSONWritingOptions.PrettyPrinted)
    }
}