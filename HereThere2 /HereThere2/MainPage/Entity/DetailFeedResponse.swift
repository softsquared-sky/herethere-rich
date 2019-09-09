//
//  DetailFeedResponse.swift
//  HereThere2
//
//  Created by 우소연 on 08/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//


import ObjectMapper
//GetFeedResponse, Feed, Picture
struct DetailFeedResponse {
    
    var code: Int!
    var isSuccess: Bool!
    var message: String!
    var feeds: [Feed2]!
}

extension DetailFeedResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
        feeds <- map["result"]
    }
    
}

struct Feed2 {
    var userPicture: String?
    var nickName: String!
    var postLocation: String!
    var timeAgo: String!
    var postContents: String!
    var pictureList: [Picture2]!
    var heart: Int!
    var comment : String!
}

extension Feed2: Mappable {
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
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

struct Picture2{
    var postPicture: String?
}

extension Picture2 : Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        postPicture <- map["postPicture"]
    }
    
}
