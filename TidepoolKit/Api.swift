//
//  Api.swift
//  TidepoolKit
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import Foundation

private let API_URL = "https://int-api.tidepool.org"
private let UPLOAD_URL = "https://int-uploads.tidepool.org"

class Api {
    private var loggedIn = false
    private var x_tidepool_session_token: String = ""
    
    private func request(method: String, baseUrl: String, urlExtension: String, headerDict: [String: String], body: NSData?, completion: (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void) {
        
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
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            completion(response: response, data: data, error: error)
        }
        
        task.resume()
    }
    
    func login(username: String, password: String, completion: (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void) {
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        
        let headerDict = ["Authorization":"Basic \(base64LoginString)"]
        
        request("POST", baseUrl: API_URL, urlExtension: "/auth/login", headerDict: headerDict, body: nil, completion: completion)
    }
    
    func logout(completion: (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void) {
        let headerDict = ["x-tidepool-session-token":"\(x_tidepool_session_token)"]

        request("POST", baseUrl: API_URL, urlExtension: "/auth/logout", headerDict: headerDict, body: nil, completion: completion)
    }
    
    
}