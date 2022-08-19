//
//  HTTPRequest.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 26/2/21.
//

import Foundation

// MARK: - HTTPRequest

public typealias HTTPRequest = URLRequest

public extension HTTPRequest {
    
    // MARK: - Init
    
    init?<T: HTTPHost>(scheme: HTTPScheme = .https, host: T, path: String, parameters: [String: String]? = nil) {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = String(host)
        components.path = path
        components.queryItems = parameters?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else { return nil }
        self.init(url: url)
    }
    
    // MARK: - API
    
    mutating func setMethod(_ httpMethod: HTTPMethod) {
        self.httpMethod = httpMethod.rawValue
    }
    
    mutating func setHeaders(_ headers: [String : String]) {
        for (field, value) in headers {
            addValue(value, forHTTPHeaderField: field)
        }
    }
    
    mutating func setBody(_ data: Data) {
        httpBody = data
    }
}

// MARK: - Scheme

public enum HTTPScheme: String, RawRepresentable {
    
    case wss, https
}

// MARK: - Host

public protocol HTTPHost: StringProtocol {}

// MARK: - Method

public enum HTTPMethod: String, RawRepresentable {
    
    case GET, POST, DELETE
}
