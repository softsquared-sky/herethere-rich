//
//  GetLoginResponse.swift
//  HereThere2
//
//  Created by 우소연 on 05/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import ObjectMapper
import AlamofireObjectMapper

struct GetLoginResponse {
    
    var message: String!
    var isSuccess: Bool?
    var code: Int?
    var result2: Jwt!
    
    //var result2 : [Jwt]!
    //var locationNo: Int!
    //var location: String!
}

extension GetLoginResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        result2 <- map["result"]
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
    }
}

struct Jwt {
    //var locationNo: Int!
    var jwt: String!
    
}

extension Jwt: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        jwt <- map["jwt"]
        
    }
}
