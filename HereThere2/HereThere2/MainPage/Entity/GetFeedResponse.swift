//
//  GetFeedResponse.swift
//  HereThere2
//
//  Created by 우소연 on 04/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//

import ObjectMapper
//GetFeedResponse, Feed, Picture
struct GetFeedResponse {
    
    var code: Int!
    var isSuccess: Bool!
    var message: String!
    var feeds: [Feed]!
}

extension GetFeedResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
       
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
        feeds <- map["result"]
    }
    
}

 struct Feed {
    var postNo: Int!
    var userPicture: String?
    var nickName: String!
    var postLocation: String!
    var timeAgo: String!
    var postContents: String!
    var pictureList: [Picture]!
    var heart: Int!
    var comment : String!
}

extension Feed: Mappable {
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        postNo <- map["postNo"]
        userPicture <- map["userPicture"]
        nickName <- map["nickName"]
        timeAgo <- map["timeAgo"]
        postLocation <- map["postLocation"]
        postContents <- map["postContents"]
        pictureList <- map["pictureList"]
        heart <- map["heart"]
        comment <- map["comment"]
    }
 }

struct Picture{
    var postPicture: String?
}

extension Picture : Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        postPicture <- map["postPicture"]
    }
    
}
