//
//  RCCall.swift
//  RCiOSLibrary
//
//  Created by Raymond_Chan on 9/10/2018.
//  Copyright © 2018 Raymond_Chan. All rights reserved.
//

import UIKit
import Alamofire

public class RCCall: NSObject {
    public static let sharedInstance = RCCall()

    private override init() {
        print("init RCCall...")
    }

    public func getStringValueByAlamofire(closure:@escaping ([String: AnyObject]) -> (Void)){
        Alamofire.request("http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=e6831708-02b4-4ef8-98fa-4b4ce53459d9").responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                // convert data to dictionary array
                if let result = response.value as? [String: AnyObject] {
                    let dataList: [[String : Any]]? = result["result"]?["results"] as? [[String : Any]]
                    for data in dataList! {
                        print("locationName: \(data["locationName"]!)") // 所在縣市
                        print("parameterName1: \(data["parameterName1"]!)") // 天氣
                        print("startTime: \(data["startTime"]!)") // 起始時間
                        print("endTime: \(data["endTime"]!)") // 結束時間
                        print()
                    }
                    closure(result)
                }
            } else {
                print("error: \(response.error)")
            }
        })
    }
}
