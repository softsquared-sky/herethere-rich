//
//  GetReplyResponse.swift
//  HereThere2
//
//  Created by 우소연 on 08/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//


import ObjectMapper
//GetFeedResponse, Feed, Picture
struct GetReplyResponse {
    
    var code: Int!
    var isSuccess: Bool!
    var message: String!
    var reply: [Reply]!
}

extension GetReplyResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
        reply <- map["result"]
    }
    
}

struct Reply {
    var userPicture: String!
    var nickName: String!
    var timeAgo: String!
    var commentContents: String!
}

extension Reply: Mappable {
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        userPicture <- map["userPicture"]
        nickName <- map["nickName"]
        timeAgo <- map["timeAgo"]
        commentContents <- map["commentContents"]
    }
}
