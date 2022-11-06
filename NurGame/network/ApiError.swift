//
//  ApiError.swift
//  NurGame
//
//  Created by Iqbal Nur Haq on 06/11/22.
//

import Foundation

enum ApiError: Error {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .badURL, .parsing, .unknown:
            return "Something went wrong"
        case .badResponse(_):
            return "Connection failed"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }

}
