//
//  TutorialResponse.swift
//  HereThere2
//
//  Created by 우소연 on 26/08/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import ObjectMapper

struct TutorialResponse {
    var code: Int!
    var message: String!
    //var tutorials: [Tutorial?]!
}

extension TutorialResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        //tutorials <- map["result"]
    }
    
}

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
