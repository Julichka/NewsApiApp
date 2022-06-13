//
//  NewsListRestObject.swift
//  NewsApiApp
//
//  Created by Yuliia Khrupina on 6/12/22.
//

import Foundation
import ObjectMapper

class NewsListRestObjects: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        articles <- map["articles"]
    }
    
    var articles: Array<NewsItem>?
    
}
