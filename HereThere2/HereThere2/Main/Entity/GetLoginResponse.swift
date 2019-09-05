//
//  GetLoginResponse.swift
//  HereThere2
//
//  Created by 우소연 on 05/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import ObjectMapper

struct GetLoginResponse {
    
    var message: String!
    var isSuccess: Bool?
    var code: Int?
    var result2 = [String: String]()
    //var locationNo: Int!
    //var location: String!
}

extension GetLoginResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
        result2 <- map["result"]
    }
}

