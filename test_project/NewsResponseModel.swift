//
//  NewsResponseModel.swift
//  test_project
//
//  Created by Mac Mini 2018 on 05.08.2021.
//

import Foundation
import Moya
import ObjectMapper

struct Info: Decodable {
    var articles: [NewsResponseModel]
}

struct NewsResponseModel: Decodable {
    var title: String?
    var description: String?
    var urlToImage: URL?
}
