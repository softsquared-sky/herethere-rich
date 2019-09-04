//
//  Login2Response.swift
//  HereThere2
//
//  Created by 우소연 on 03/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//
import ObjectMapper

struct Login2Response {
    
    var message: String!
    var isSuccess: Bool!
    var code: Int!
    var result: [Login2]!
    //var locationNo: Int!
    //var location: String!
}

extension Login2Response: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
        result <- map["result"]
        //location <- map["result.location"]
        //locationNo <- map["result.locationNo"]
        //tutorials <- map["result"]
    }
    
}

struct Login2 {
    var jwt: String!
    
}

extension Login2: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        jwt <- map["jwt"]
        
    }
}
