//
//  Api.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation
import CryptoSwift

private let API_URL = "https://int-api.tidepool.org"
private let UPLOAD_URL = "https://int-uploads.tidepool.org"
private let DEVICE_ID = "TidepoolKit"

public enum TidepoolError: ErrorType {
    case HTTPError(status: Int)
}

public class TidepoolApiClient {
    private var x_tidepool_session_token: String = ""
    private var userid: String = ""
    
    public init() { }
    
    private func request(method: String, baseUrl: String, urlExtension: String, headerDict: [String: String], body: NSData?, completion: (success: Bool, data: NSData?, error: ErrorType?) -> Void) {
        
        var urlString = baseUrl + urlExtension
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = method
        for (field, value) in headerDict {
            request.setValue(value, forHTTPHeaderField: field)
        }
        request.HTTPBody = body
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            let httpResponse = response as! NSHTTPURLResponse
            
            if (httpResponse.statusCode == 200) {
                if let x_tidepool_session_token = httpResponse.allHeaderFields["x-tidepool-session-token"] as? String {
                    self.x_tidepool_session_token = x_tidepool_session_token
                }
                
                return completion(success: true, data: data, error: nil)
            } else {
                return completion(success: false, data: data, error: TidepoolError.HTTPError(status: httpResponse.statusCode))
            }
        }
        
        task.resume()
    }
    
    public func login(username: String, password: String, completion: (success: Bool, error: ErrorType?) -> Void) {
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        
        let headerDict = ["Authorization":"Basic \(base64LoginString)"]
        
        request("POST", baseUrl: API_URL, urlExtension: "/auth/login", headerDict: headerDict, body: nil) { (success, data, error) in
            
            if (success) {
                
                let jsonResult: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                self.userid = jsonResult.valueForKey("userid") as! String
            }
            
            completion(success: success, error: error)
        }
    }
    
    public func logout(completion: (success: Bool, error: ErrorType?) -> Void) {
        let headerDict = ["x-tidepool-session-token":"\(x_tidepool_session_token)"]
        
        request("POST", baseUrl: API_URL, urlExtension: "/auth/logout", headerDict: headerDict, body: nil) { (success, data, error) in
            completion(success: success, error: error)
        }
    }
    
    public func uploadData(data: TDSet, completion: (success: Bool, error: ErrorType?) -> Void) {
        let headerDict = [
            "x-tidepool-session-token":"\(x_tidepool_session_token)",
            "Content-Type":"application/json"
        ]
        
        let body = data.toNSDataForUpload(TidepoolApiClient.getUploadId("TidepoolKit", time: Datetime.getISOStringForDate(NSDate())), deviceId: DEVICE_ID)
        
        request("POST", baseUrl: UPLOAD_URL, urlExtension: "/data/\(self.userid)", headerDict: headerDict, body: body) { (success, data, error) in
            completion(success: success, error: error)
        }
    }
    
    private static func getUploadId(deviceId: String, time: String) -> String {
        let uploadIdSuffix = "\(deviceId)_\(time)"
        let uploadIdSuffixMd5Hash = uploadIdSuffix.md5()
        return "upid_\(uploadIdSuffixMd5Hash)"
    }
    
    public func fetchData(completion: (success: Bool, data: TDSet?, error: ErrorType?) -> Void) {
        let headerDict = ["x-tidepool-session-token":"\(x_tidepool_session_token)"]
        
        request("GET", baseUrl: API_URL, urlExtension: "/data/\(self.userid)", headerDict: headerDict, body: nil) { (success, data, error) in
            var parsedData: TDSet?
            if (success) {
                parsedData = TDSet()
                let jsonResult: NSArray = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                
                for item in jsonResult {
                    switch TDType(rawValue: item.valueForKey("type") as! String)! {
                    case .Basal: break
//                        basal.add(someData as! TDBasal)
                    case .BloodKetone: break
//                        bloodKetone.add(someData as! TDBloodKetone)
                    case .Bolus: break
//                        bolus.add(someData as! TDBolus)
                    case .CBG:
                        parsedData!.add(TDCbg.makeObjectFromJSON(item))
                    case .CGMSettings: break
//                        cgmSettings.add(someData as! TDCgmSettings)
                    case .PumpSettings: break
//                        pumpSettings.add(someData as! TDPumpSettings)
                    case .SMBG:
                        parsedData!.add(TDSmbg.makeObjectFromJSON(item))
                    case .Wizard: break
//                        wizard.add(someData as! TDWizard)
                    }
                }
            }
            completion(success: success, data: parsedData, error: error)
        }
    }
}