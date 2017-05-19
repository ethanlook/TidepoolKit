//
//  TDWizardSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/21/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding wizard/calculator events.
open class TDWizardSet {
    
    fileprivate var data = [TDWizard]()
    
    /// Returns an empty `TDWizardSet`.
    public init() { }
    
    /**
     Adds a wizard event to the dataset.
     
     - Parameter someWizard: The `TDWizard` to be added to the set.
     - Returns: the `TDWizardSet` itself for easy chaining.
     */
    open func add(_ someWizard: TDWizard) -> TDWizardSet {
        data.append(someWizard)
        return self
    }
    
    /**
     Creates the associated JSON array for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TDWizard`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TDWizard`.
     - Returns: `[[String : AnyObject]]` for the associated `TDWizardSet`.
     */
    internal func toJSONArrayForUpload(_ uploadId: String, deviceId: String) -> [[String : AnyObject]] {
        return data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
    }
}
