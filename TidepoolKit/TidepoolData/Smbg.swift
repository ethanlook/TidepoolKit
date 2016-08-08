//
//  Smbg.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

class Smbg: CommonData {
    init(value: Double, deviceId: String) {
        super.init(type: "smbg", subType: nil, deviceId: deviceId)
        
        self.data["value"] = value
        self.data["units"] = "mg/dL"
    }
}