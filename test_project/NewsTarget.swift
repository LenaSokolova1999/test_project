//
//  NewsTarget.swift
//  test_project
//
//  Created by Andrey Korotkov on 05.08.2021.
//

import Foundation
import Moya

enum News {
    case readNews(page: Int)
}

extension News: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }
    
    var path: String {
        switch self {
            case .readNews:
                return "/everything"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .readNews:
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            case .readNews(let page):
                return .requestParameters(parameters: ["q"        : "tesla",
                                                       "apiKey"   : "78c804f5becf48e6b2c965a1f1c31f11",
                                                       "pageSize" : "10",
                                                       "page"     : page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
