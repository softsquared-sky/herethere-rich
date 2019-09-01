//
//  NationResponse.swift
//  HereThere2
//
//  Created by 우소연 on 02/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import ObjectMapper

struct NationResponse {
   
    var message: String!
    var isSuccess: Bool!
    var code: Int!
    var nations: [String]!
}

extension NationResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
        nations <- map["result"]
        //tutorials <- map["result"]
    }
    
}

 struct Nation {
    var locationNo: Int!
    var location: String!
    
 }

extension Nation: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        locationNo <- map["locationNo"]
        location <- map["location"]
        
    }
}

