//
//  TidepoolKitTests.swift
//  TidepoolKitTests
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import XCTest
@testable import TidepoolKit

class TidepoolKitTests: XCTestCase {
    
    var tidepoolApi: TidepoolApiClient = TidepoolApiClient()
    
    let username = "ethan+tidepoolkit2@lookfamily.org"
    let password = "h@ckd@yz"
    
    override func setUp() {
        super.setUp()
        let expectation = self.expectation(description: "Login")

        self.tidepoolApi.login(self.username, password: self.password) { (success, error) in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        let expectation = self.expectation(description: "Logout")
        
        self.tidepoolApi.logout() { (success, error) in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testUpload() {
        let data = TDSet()
                          .add(TDSmbg(units: .MGDL, value: 101, time: Datetime.dateForString("2016-09-15T06:30:00")))
                          .add(TDCbg(units: .MGDL, value: 333, time: Datetime.dateForString("2016-09-15T06:40:00")))
                          .add(TDBloodKetone(value: 222, time: Datetime.dateForString("2016-09-15T07:30:00")))
                          .add(TDBolus(normal: 10.5, expectedNormal: 13, time: Datetime.dateForString("2016-09-15T07:00:00")))
                          .add(TDBasal(deliveryType: .Temp, duration: 2000000, rate: 1.5, time: Datetime.dateForString("2016-09-15T09:00:00")))
                          .add(TDBasal(deliveryType: .Temp, duration: 1800000, rate: 0.75, time: Datetime.dateForString("2016-09-15T09:30:00")))
        
        
        let expectation = self.expectation(description: "Upload")
        self.tidepoolApi.uploadData(data) { (success, error) in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testUploadPumpSettings() {
        
        let units = TDPumpSettings.Units(carbs: .Grams, bg: .MGDL)
        
        let standard = TDPumpSettings.BasalSchedule(segments: [TDPumpSettings.BasalSchedule.Segment(start: 0, rate: 1.0), TDPumpSettings.BasalSchedule.Segment(start: 43200000, rate: 1.5)])
        let exercise = TDPumpSettings.BasalSchedule(segments: [TDPumpSettings.BasalSchedule.Segment(start: 0, rate: 2.0), TDPumpSettings.BasalSchedule.Segment(start: 43200000, rate: 3.5)])
        let basalSchedules = TDPumpSettings.BasalSchedules(schedules: ["Standard" : standard, "Exercise" : exercise])
        
        let bgTarget = TDPumpSettings.BGTarget(segments: [TDPumpSettings.BGTarget.Segment(start: 0, low: 100, high: 200)])
        
        let carbRatio = TDPumpSettings.CarbRatio(segments: [TDPumpSettings.CarbRatio.Segment(start: 0, amount: 12)])
        
        let insulinSensitivity = TDPumpSettings.InsulinSensitivity(segments: [TDPumpSettings.InsulinSensitivity.Segment(start: 0, amount: 60)])
        
        let pumpSettings = TDPumpSettings(units: units, activeSchedule: "Exercise", basalSchedules: basalSchedules, bgTarget: bgTarget, carbRatio: carbRatio, insulinSensitivity: insulinSensitivity, time: Datetime.dateForString("2016-09-15T06:30:00"))
        
        let data = TDSet().add(pumpSettings)
        
        let expectation = self.expectation(description: "Upload Pump Settings")
        self.tidepoolApi.uploadData(data) { (success, error) in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
