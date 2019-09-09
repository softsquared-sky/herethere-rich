//
//  GetProfileResponse.swift
//  HereThere2
//
//  Created by 우소연 on 07/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//


import ObjectMapper
//GetFeedResponse, Feed, Picture
struct GetProfileResponse {
    var code: Int!
    var isSuccess: Bool!
    var message: String!
    var profile: [Profile]!
}

extension GetProfileResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
        profile <- map["result"]
    }
    
}

struct Profile {
    var userPicture: String?
    var nickName: String!
    var email: String!
    var schoolName: String!
    var status: String!
}

extension Profile: Mappable {
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        userPicture <- map["userPicture"]
        nickName <- map["nickName"]
        email <- map["email"]
        schoolName <- map["schoolName"]
        status <- map["status"]
    }
}
