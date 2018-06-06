//
//  APIController.swift
//
//  Copyright © 2018 Apps Cyclone. All rights reserved.

import Foundation
import Alamofire

typealias ErrorResponseBlock = (_ error: String?) -> Void
typealias ResponseBlock<T: Decodable> = (String?, T?) -> Void

struct DataInfo {
    
    var withName: String
    var fileName: String
    var mimeType: String

}

struct APIController {
    
    //MARK: - DEFAULT REQUEST

    static func request<T: Decodable>(responseType: T.Type, manager: APIManager, params: Parameters? = nil, completion: @escaping ResponseBlock<T>){
        
        Logger.log(message: "URL: \(manager.url)", event: .info)
        
        Alamofire.request(manager.url, method: manager.method, parameters: params, encoding: manager.encoding, headers: manager.header).validate().responseData { (responseData) in
            
            switch responseData.result{
            case .success(let data):
                JSONDecoder.decode(responseType, from: data, completion: { (error, response) in
                    completion(error, response)
                })
            case .failure(let error):
                if let data = responseData.data {
                    JSONDecoder.decode(ErrorResponse.self, from: data, completion: { (error, response) in
                        if let message = response?.statusMessage {
                            completion(message, nil)
                            return
                        }
                        completion(error, nil)
                    })
                    return
                }
                completion(error.localizedDescription, nil)
            }
            
        }
    }

    //MARK: - MULTIPART UPLOAD
    
    static func upload(manager: APIManager, params: [String: AnyObject]?, data: Data?, info: DataInfo, result: @escaping ErrorResponseBlock){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = data{
                multipartFormData.append(data, withName: info.withName, fileName: info.fileName, mimeType: info.mimeType)
            }
            
            if let params = params {
                for (key,value) in params{
                    multipartFormData.append(value.data!(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
        }, to: manager.url, headers: manager.header) { (resultUpload) in
            switch resultUpload{
            case .success(let upload,_,_):
                upload.responseJSON { response in
                    if let value = response.result.value {
                        print("JSON: \(value)")
                        
                        // Handle data reponse
                        result(nil)
                    }
                }
            case .failure(let error):
                result(error.localizedDescription)
            }
        }
    }
    
}
