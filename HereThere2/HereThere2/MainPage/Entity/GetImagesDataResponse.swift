//
//  GetImagesDataResponse.swift
//  HereThere2
//
//  Created by 우소연 on 10/09/2019.
//  Copyright © 2019 Soyeon Woo. All rights reserved.
//


import ObjectMapper
//GetFeedResponse, Feed, Picture
struct GetImagesDataResponse {
    
    var code: Int!
    var isSuccess: Bool!
    var message: String!
    var images: [Images]!
}

extension GetImagesDataResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        isSuccess <- map["isSuccess"]
        code <- map["code"]
        message <- map["message"]
        images <- map["result"]
    }
    
}

struct Images {
    var postPicture: String?
}

extension Images: Mappable {
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        postPicture <- map["postPicture"]
    }
}
