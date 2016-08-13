//
//  DataProcessor.swift
//  DemoProduct
//
//  Created by YANGSHENG ZOU on 2016-08-12.
//  Copyright © 2016 YANGSHENG ZOU. All rights reserved.
//


import SwiftyJSON

class DataProcessor: NSObject {
    // the class receives and processs data from APICommunicator. it is a data provider to view controller as well
    
    
    // -----------------------for singleton ---------------------------
    
    private static let singleton = DataProcessor()
    
    private override init(){
        // set init private to make it singleton
        
    }
    
    static func sharedInstance() -> DataProcessor {
        // the only method to get singleton
        return singleton
    }
    
    //----------------------end-------------------------------------
    
    
    
    
    
    
    // -----------------------for cache opeartion---------------------------
    
    let commodityUnitCacheKey = "commodityUnit" // the key for of cache for commodityUnit
    let regionsCacheKey = "regisons"  // the key for of cache for regions
    
    
    private let cache = NSCache()
    
    
    func cacheData(object:AnyObject? , key:String){
        // store data in cache
        
        if(object != nil){
            if(JSON(object!)["result"]){
                cache.setObject(object!, forKey: key)
                
            }
        }
    }
    
    func getDataFromCache(key:String) -> SwiftyJSON.JSON?{
        
        // get data from cache for key
        let data = cache.objectForKey(key)
        if(data != nil){
            if(key == commodityUnitCacheKey){
                let CommodityUnitJSON = JSON(data!)["data"]["commodityUnit"]
                return CommodityUnitJSON
            }
                
            else if (key == regionsCacheKey){
                let regionsJSON = JSON(data!)["regions"]
                return regionsJSON
            }
        }
        return nil
    }
    
    //-------------------------------end-------------------------------
    
    
    func getMatchingRegion(string : String) -> [SwiftyJSON.JSON]{
        
        // get the region with matching string
        var result: [SwiftyJSON.JSON] = [];
        
        let regionsJSON = getDataFromCache(regionsCacheKey)
        if(regionsJSON != nil && string != ""){
            for i in 0..<regionsJSON!.count {
                let region = regionsJSON![i]
                let cityString = regionsJSON![i]["city_name"].string
                let provinceString = regionsJSON![i]["province_name"].string
                if  (cityString!.uppercaseString.containsString(string.uppercaseString) || provinceString!.uppercaseString.containsString(string.uppercaseString) ){
                    result.append(region)  // compare the uppercase string, it can be matched by province or city name
                }
            }
        }
        return result
    }
    
    
    
}
