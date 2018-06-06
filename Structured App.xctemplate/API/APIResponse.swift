//
//  APIResponse.swift
//
//  Copyright © 2018 Apps Cyclone. All rights reserved.


struct ErrorResponse: Decodable {
    var statusCode: Int?
    var statusMessage: String?
}

struct Response<T: Decodable>: Decodable {
    var data: T?
}
