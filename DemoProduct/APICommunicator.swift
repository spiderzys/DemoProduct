//
//  APICommunicator.swift
//  DemoProduct
//
//  Created by YANGSHENG ZOU on 2016-08-11.
//  Copyright © 2016 YANGSHENG ZOU. All rights reserved.
//

import UIKit
import Alamofire


// This class is for communication with API. It contains two methods to get commodity unit and region


class APICommunicator: NSObject {
    
    // -------------------for singleton pattern------------------
    private static let singleton = APICommunicator()
    
    private override init(){
        // set init private to make it singleton
        
    }
    
    static func sharedInstance() -> APICommunicator {
        // the only method to get singleton
        return singleton
    }
    // -------------------- end-------------------------------------
    
  
    
    
    
    
    
    // --------------------request parameter------------------------
    
    private let commodityUnitRequestUrl = NSURL(string: "http://dualstack.FL2-Dev-api02-1164870265.us-east-1.elb.amazonaws.com/api/v2/data")!  // url to get commodity data
    
    private let regionsRequestUrl = NSURL(string: "http://dualstack.FL2-Dev-api02-1164870265.us-east-1.elb.amazonaws.com/api/v2/data/search_region")! // url to get region data
    
    
    private let commodityRequestPara = ["data": ["commodityUnit": "2013-04-25 18:03:12"]] // post method parameter for commodity request
    
    private let regionsRequestPara = ["search": "ott"] // post method parameter for regisons request
    
    //----------------------end-------------------------------------
    
    
    
    
    
    
    
    
    //----------------------------request opertaion---------------------------
    
    private func getDataFromAPI(parameters: [String : AnyObject], url:NSURL, method: Alamofire.Method, cacheKey: String) {
        
        // connect API and send data for data processor

        Alamofire.request(method, url, parameters: parameters, encoding: .JSON ).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    DataProcessor.sharedInstance().cacheData(value, key: cacheKey)
                    
                }
                
            case .Failure(let error):
                print(error)
                
            }
          
        }
        
    }
    
    
    internal func reachRegionsAPI(){
        
        // get region
        getDataFromAPI(regionsRequestPara, url:regionsRequestUrl, method: .POST, cacheKey: DataProcessor.sharedInstance().regionsCacheKey)

    }
    
  
    internal func reachCommodityUnitAPI(){
        
        // get commodityUnit
        
        getDataFromAPI(commodityRequestPara, url:commodityUnitRequestUrl, method: .POST, cacheKey: DataProcessor.sharedInstance().commodityUnitCacheKey)
            
        
    /*
         Alamofire.request(.POST, commodityUnitUrl!, parameters: ["data": ["commodityUnit": "2013-04-25 18:03:12"]], encoding: .JSON ).validate().responseJSON { response in
         switch response.result {
         case .Success:
         if let value = response.result.value {
         let json = JSON(value)
         print("JSON: \(json)")
         }
         case .Failure(let error):
         print(error)
         }
         }
         */
    }

    //----------------------end-------------------------------------
    
}
