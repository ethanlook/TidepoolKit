//
//  Api.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation
import CryptoSwift

/*
 While you could change these URLs to point at production
    REST APIs, our friends at Tidepool would really prefer
    if you didn't do that.
 */
private let API_URL = "https://int-api.tidepool.org"
private let UPLOAD_URL = "https://int-uploads.tidepool.org"
private let DEVICE_ID = "TidepoolKit"

public enum TidepoolError: Error {
    case httpError(status: Int)
}

open class TidepoolApiClient {
    fileprivate var x_tidepool_session_token: String = ""
    fileprivate var userid: String = ""
    
    public init() { }
    
    fileprivate func request(_ method: String, baseUrl: String, urlExtension: String, headerDict: [String: String], body: Data?, completion: @escaping (_ success: Bool, _ data: Data?, _ error: Error?) -> Void) {
        
        var urlString = baseUrl + urlExtension
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = method
        for (field, value) in headerDict {
            request.setValue(value, forHTTPHeaderField: field)
        }
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            
            if (httpResponse.statusCode == 200) {
                if let x_tidepool_session_token = httpResponse.allHeaderFields["x-tidepool-session-token"] as? String {
                    self.x_tidepool_session_token = x_tidepool_session_token
                }
                
                return completion(true, data, nil)
            } else {
                return completion(false, data, TidepoolError.httpError(status: httpResponse.statusCode))
            }
        }
        
        task.resume()
    }
    
    open func login(_ username: String, password: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedString(options: [])
        
        let headerDict = ["Authorization":"Basic \(base64LoginString)"]
        
        request("POST", baseUrl: API_URL, urlExtension: "/auth/login", headerDict: headerDict, body: nil) { (success, data, error) in
            
            if (success) {
                
                let jsonResult: NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                self.userid = jsonResult.value(forKey: "userid") as! String
            }
            
            completion(success, error)
        }
    }
    
    open func logout(_ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        let headerDict = ["x-tidepool-session-token":"\(x_tidepool_session_token)"]
        
        request("POST", baseUrl: API_URL, urlExtension: "/auth/logout", headerDict: headerDict, body: nil) { (success, data, error) in
            completion(success, error)
        }
    }
    
    open func uploadData(_ data: TDSet, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        let headerDict = [
            "x-tidepool-session-token":"\(x_tidepool_session_token)",
            "Content-Type":"application/json"
        ]
        
        let body = data.toNSDataForUpload(TidepoolApiClient.getUploadId("TidepoolKit", time: Datetime.getISOStringForDate(Date())), deviceId: DEVICE_ID)
        
        request("POST", baseUrl: UPLOAD_URL, urlExtension: "/data/\(self.userid)", headerDict: headerDict, body: body) { (success, data, error) in
            completion(success, error)
        }
    }
    
    fileprivate static func getUploadId(_ deviceId: String, time: String) -> String {
        let uploadIdSuffix = "\(deviceId)_\(time)"
        let uploadIdSuffixMd5Hash = uploadIdSuffix.md5()
        return "upid_\(uploadIdSuffixMd5Hash)"
    }
    
    open func fetchData(_ completion: @escaping (_ success: Bool, _ data: TDSet?, _ error: Error?) -> Void) {
        let headerDict = ["x-tidepool-session-token":"\(x_tidepool_session_token)"]
        
        request("GET", baseUrl: API_URL, urlExtension: "/data/\(self.userid)", headerDict: headerDict, body: nil) { (success, data, error) in
            var parsedData: TDSet?
            if (success) {
                parsedData = TDSet()
                let jsonResult: NSArray = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                
                for item in jsonResult {
                    switch TDType(rawValue: (item as AnyObject).value(forKey: "type") as! String)! {
                    case .Basal: break
//                        basal.add(someData as! TDBasal)
                    case .BloodKetone: break
//                        bloodKetone.add(someData as! TDBloodKetone)
                    case .Bolus: break
//                        bolus.add(someData as! TDBolus)
                    case .CBG:
                        parsedData!.add(TDCbg.makeObjectFromJSON(item as AnyObject))
                    case .CGMSettings: break
//                        cgmSettings.add(someData as! TDCgmSettings)
                    case .PumpSettings: break
//                        pumpSettings.add(someData as! TDPumpSettings)
                    case .SMBG:
                        parsedData!.add(TDSmbg.makeObjectFromJSON(item as AnyObject))
                    case .Wizard: break
//                        wizard.add(someData as! TDWizard)
                    }
                }
            }
            completion(success, parsedData, error)
        }
    }
}
