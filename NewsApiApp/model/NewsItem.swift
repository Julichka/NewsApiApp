//
//  NewsItem.swift
//  NewsApiApp
//
//  Created by Yuliia Khrupina on 6/12/22.
//

import Foundation
import ObjectMapper

class NewsItem: Mappable {
    var message: String?
    var iconUrl: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["title"]
        iconUrl <- map["urlToImage"]
    }
}
