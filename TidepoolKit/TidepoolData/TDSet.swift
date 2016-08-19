//
//  TDSet.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/8/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

public class TDSet {
    private var data = [TidepoolData]()
    
    public init() { }
    
    public func add(someData: TidepoolData) -> TDSet {
        data.append(someData)
        return self
    }
    
    func toJSONForUpload(uploadId: String, deviceId: String) -> NSData {
        let jsonArray = data.map { (d) -> [String : AnyObject] in
            return d.toDictionary(uploadId, deviceId: deviceId)
        }
        return try! NSJSONSerialization.dataWithJSONObject(jsonArray, options: NSJSONWritingOptions.PrettyPrinted)
    }
}