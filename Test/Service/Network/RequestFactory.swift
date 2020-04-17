//
//  RequestFactory.swift
//  Test
//
//  Created by Nirav on 17/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import Foundation

final class RequestFactory {

    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }

    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
