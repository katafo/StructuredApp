//
//  APIMethod.swift
//
//  Copyright © 2018 Apps Cyclone. All rights reserved.

import Alamofire

enum APIManager {
    
    case login
    
}

extension APIManager {
        
    var baseURL: String { return "" }
    
    //MARK: - URL
    
    var url: String {
        
        var path = ""
        
        switch self {
        case .login: path = ""
            
        }
        return baseURL + path
        
    }
    
    //MARK: - METHOD
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .get
        }
    }
    
    //MARK: - HEADER
    
    var header: [String : String]? {
        switch self{
        default:
            return nil
        }
    }
    
    //MARK: - ENCODING
    
    var encoding: ParameterEncoding {
        
        switch self {
        default:
            return URLEncoding.default
        }
        
    }
}
