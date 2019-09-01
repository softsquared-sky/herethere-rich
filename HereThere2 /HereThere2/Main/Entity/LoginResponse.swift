//
//  LoginResponse.swift
//  HereThere2
//
//  Created by 우소연 on 01/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import ObjectMapper

struct LoginResponse {
    var code: Int!
    var isSuccess: Int!
    var message: String!
    //var tutorials: [Tutorial?]!
}

extension LoginResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
        //tutorials <- map["result"]
    }
    
}
/*
struct Tutorial {
    var seq: Int!
    var type: String!
    var url: String!
    var content: String!
}

extension Tutorial: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        seq <- map["seq"]
        type <- map["type"]
        url <- map["url"]
        content <- map["content"]
    }
}
 */
