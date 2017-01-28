//
//  NRNetworkManager.swift
//  NewReader
//
//  Created by Abhishek Thapliyal on 1/23/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

enum LANGUAGES : String {
    
    case ENG = "en"
}

var API_KEY : String = "7b1568b218554e659e942bfed4c4e20d"

class NRNetworkManager: NSObject {

    
    public var status : NSString?
    public var source : NSString?
    public var sortBy : NSString?
    
    public var articles : NSArray?
    public var sources : NSArray?
    
    public var articleArray : NSMutableArray?
    public var sourceArray : NSMutableArray?
    
    //====================================================================================================================================
    // GET ARTICLES METHOD
    //====================================================================================================================================
    
    public func getNewsArticle(sortType:NSString, completion : @escaping (_ articleArray:NSArray, _ error:NSError?) -> Void) {
    
        let URLString : String = "https://newsapi.org/v1/articles"
        let param = String(format:"source=the-next-web&sortBy=latest&apiKey=%@", API_KEY)
        let request : NSMutableURLRequest = NRHTTPRequest.getServerRequest(urlString: URLString, paramString: param)
        NRHTTPResponse.responseWithRequest(request: request, requestTitle: "FETCH_ARTICLES", completion: { (json, error) in
        
            print("ERROR :: \(error?.localizedDescription)")
            self.articleArray = NSMutableArray()
            if (error == nil)
            {
                let dictionary : [String:Any] = json as! [String : Any]
                
                self.status = dictionary["status"]! as? NSString
                self.source = dictionary["source"]! as? NSString
                self.sortBy = dictionary["sortBy"]! as? NSString
                
                self.articles = NSArray(array: dictionary["articles"] as! NSArray)
                
                for articleDict in self.articles as! [[String:Any]] {
                    
                    let article = NRArticle(dictionary: articleDict)
                    self.articleArray?.add(article)
    //                print("ARTICLE \n \(article.description)")
                    }
            }
            completion(self.articleArray!, error)
        })
    }
    
    //====================================================================================================================================
    // GET SOURCE METHOD
    //====================================================================================================================================
    
    public func getNewsSource(completion : @escaping (_ sourceArray:NSArray, _ error:NSError?) -> Void) {
        
        let URLString : String = "https://newsapi.org/v1/sources"
        let param = String(format:"language=%@", LANGUAGES.ENG.rawValue)
        let request : NSMutableURLRequest = NRHTTPRequest.getServerRequest(urlString: URLString, paramString: param)
        NRHTTPResponse.responseWithRequest(request: request, requestTitle: "FETCH_SOURCES", completion: { (json, error) in
            
            print("ERROR :: \(error?.localizedDescription)")
            self.sourceArray = NSMutableArray()
            if (error == nil)
            {
                let dictionary : [String:Any] = json as! [String : Any]
                
                self.status = dictionary["status"]! as? NSString
                
                self.sources = NSArray(array: dictionary["sources"] as! NSArray)
                for sourcesDict in self.sources as! [[String:Any]] {
                    
                    let sourceOb = NRSource(dictionary: sourcesDict)
                    self.sourceArray?.add(sourceOb)
    //                print("SOURCE \n \(sourceOb.description)")
                }
            }
            completion(self.sourceArray!, error)
        })
    }
}
