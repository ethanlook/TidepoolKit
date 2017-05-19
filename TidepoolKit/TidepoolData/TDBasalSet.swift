//
//  TDBasalSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/21/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

/// A set for holding basal segments.
open class TDBasalSet {
    
    fileprivate var data = [TDBasal]()
    
    /// Returns an empty `TDBasalSet`.
    public init() { }
    
    /**
     Adds a basal segment to the dataset.
     
     - Parameter someBasal: The `TDBasal` to be added to the set.
     - Returns: the `TDBasalSet` itself for easy chaining.
     */
    open func add(_ someBasal: TDBasal) -> TDBasalSet {
        data.append(someBasal)
        return self
    }
    
    /**
     Fixes any overlapping basal durations.
     
     In the Tidepool ingestion services, basals that overlap are
        marked as a `mismatched-series`. To prevent that, before
        upload, we must remove any overlaps.
     */
    fileprivate func processForUpload() {
        
        // TODO: treat case count 2 same as general case
        if data.count <= 1 {
            return
        } else if data.count == 2 {
            let first = data[0],
                firstStart = Datetime.dateForString(first.time)!,
                secondStart = Datetime.dateForString(data[1].time)!
            
            first.duration = min(first.duration, Datetime.millisecondsBetweenDates(firstStart, end: secondStart))
            
            return
        }
        
        for i in 0...(data.count - 2) {
            let cur = data[i],
                curStart = Datetime.dateForString(cur.time)!,
                nextStart = Datetime.dateForString(data[i + 1].time)!
            
            cur.duration = min(cur.duration, Datetime.minutesBetweenDates(curStart, end: nextStart))
        }
        
    }
    
    /**
     Creates the associated JSON array for upload.
     
     - Parameter uploadId: The associated `uploadId` to be included in each piece of `TDBasal`.
     - Parameter deviceId: The associated `deviceId` to be included in each piece of `TDBasal`.
     - Returns: `[[String : AnyObject]]` for the associated `TDBasalSet`.
     */
    internal func toJSONArrayForUpload(_ uploadId: String, deviceId: String) -> [[String : AnyObject]] {
        
        processForUpload()
        
        return data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
    }
}
