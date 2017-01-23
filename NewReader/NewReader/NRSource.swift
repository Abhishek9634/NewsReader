//
//  NRSource.swift
//  NewReader
//
//  Created by Abhishek Thapliyal on 1/24/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class NRSource: NSObject {

    public var id : NSString?
    public var name : NSString?
    public var sourceDescription : NSString?
    public var url : NSString?
    public var category : NSString?
//    public var launguage : NSString?
    public var country : NSString?
    
//    public var urlToLogos : NSDictionary?
    public var small : NSString?
    public var medium : NSString?
    public var large : NSString?
    
    public var sortBysAvailable : NSArray?
    
    override init() {
        
    }
    
    init(dictionary : [String:Any]) {
        super.init()
        self.parseDictionary(dictionary: dictionary)
    }
    
    public func parseDictionary(dictionary : [String:Any]) {
        
        self.id = dictionary["id"] as? NSString
        self.name = dictionary["name"] as? NSString
        self.sourceDescription = dictionary["description"] as? NSString
        self.url = dictionary["url"] as? NSString
        self.category = dictionary["category"] as? NSString
//        self.launguage = dictionary["launguage"] as? NSString // GIVING NIL
        self.country = dictionary["country"] as? NSString
        
//        self.urlToLogos = NSDictionary(dictionary : (dictionary["urlToLogos"] as! NSDictionary))
//        self.small = self.urlToLogos?["small"] as? NSString
//        self.medium = self.urlToLogos?["medium"] as? NSString
//        self.large = self.urlToLogos?["large"] as? NSString
        
        self.sortBysAvailable = NSArray(array: dictionary["sortBysAvailable"] as! NSArray)
    }
    
//    override var description : String {
//        
//        return "id : \(self.id!)\n name : \(self.name!)\n description : \(self.sourceDescription!)\n url : \(self.url!)\n category : \(self.category!)\n launguage : \(self.launguage?.description)\n urlToLogos : \(self.urlToLogos?.description)\n sortBysAvailable : \(self.sortBysAvailable?.description)"
//    }

}
