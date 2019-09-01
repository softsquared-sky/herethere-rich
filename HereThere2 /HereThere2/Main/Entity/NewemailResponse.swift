//
//  NewemailResponse.swift
//  HereThere2
//
//  Created by 우소연 on 01/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import ObjectMapper

struct NewemailResponse {
    var code: Int?
    var isSuccess: Bool?
    var message: String!
    //var tutorials: [Tutorial?]!
}

extension NewemailResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
    }
    
}
