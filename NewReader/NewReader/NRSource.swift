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
    public var language : NSString?
    public var country : NSString?
    
    public var urlsToLogos : [String: Any]?
    public var small : NSString?
    public var medium : NSString?
    public var large : NSString?
    
    public var sortBysAvailable : NSArray?
    
    override init() {
        
    }
    
    /********************************************************
     CUSTOM INTIALIZATION : INIT WITH DICTIONARY
     ********************************************************/
    
    init(dictionary : [String:Any]) {
        super.init()
        self.parseDictionary(dictionary: dictionary)
    }
    
    /********************************************************
     PARSING DICTIONARY : MAPPING DATA TO CLASS PROPERTIES
     ********************************************************/
    
    public func parseDictionary(dictionary : [String:Any]) {
        
        self.id = dictionary["id"] as? NSString
        self.name = dictionary["name"] as? NSString
        self.sourceDescription = dictionary["description"] as? NSString
        self.url = dictionary["url"] as? NSString
        self.category = dictionary["category"] as? NSString
        self.language = dictionary["language"] as? NSString
        self.country = dictionary["country"] as? NSString
        
        self.urlsToLogos = dictionary["urlsToLogos"] as! [String : Any]?
        self.small = self.urlsToLogos?["small"] as? NSString
        self.medium = self.urlsToLogos?["medium"] as? NSString
        self.large = self.urlsToLogos?["large"] as? NSString
//        print("SMALL : \(self.small!)")
        
        self.sortBysAvailable = NSArray(array: dictionary["sortBysAvailable"] as! NSArray)
    }
    
    /********************************************************
     OVERRIDE CLASS DESCRIPTION
     ********************************************************/
    
    override var description : String {
        
        return "id : \(self.id!)\n name : \(self.name!)\n description : \(self.sourceDescription!)\n url : \(self.url!)\n category : \(self.category!)\n language : \(self.language!)\n urlToLogos : \(self.urlsToLogos?.description)\n sortBysAvailable : \(self.sortBysAvailable?.description)"
    }

}
