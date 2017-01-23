//
//  NRHTTPResponse.swift
//  NewReader
//
//  Created by Abhishek Thapliyal on 1/23/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

enum RESPONSE_CODE : Int {
    
    case SUCCESS = 200
    case ERROR = 400
}

class NRHTTPResponse: NSObject {

    class func responseWithRequest(request:NSMutableURLRequest , requestTitle:String , completion : @escaping (_ json:Any, _ error:NSError?) -> Void) {
        
        let task : URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let httpResponse = response as! HTTPURLResponse
            print("HTTP RESPONSE \(httpResponse.description) && CODE :: \(httpResponse.statusCode)")
            print("ERROR RESPONSE (IF-ANY) :: \(error?.localizedDescription)")
            
            var jsonResponse: Any? = nil
            
            do {
                jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            }
            catch let err as NSError
            {
                print("RESPONSE_EXCEPTION :: \(err.localizedDescription)")
            }
            if httpResponse.statusCode == RESPONSE_CODE.SUCCESS.rawValue {
                //
            }
            completion(jsonResponse as Any, error as NSError?)
            print("ERROR RESPONSE DATA (IF-ANY) :: \(jsonResponse)")
        }
        task.resume()
    }

}
