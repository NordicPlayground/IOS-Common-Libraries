//
//  Network.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 26/2/21.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import os

// MARK: - Network

public class Network {
    
    // MARK: - Properties
    
    private lazy var logger = Logger(Self.self)
    private lazy var session = URLSession(configuration: .multiPathEnabled)
    
    private var reachability: SCNetworkReachability?
    
    private init(_ host: String) {
        reachability = SCNetworkReachabilityCreateWithName(nil, host)
    }
}

// MARK: - API

public extension Network {
    
    // MARK: - Reachability
    
    func getReachabilityPublisher() -> AnyPublisher<Bool, Error> {
        return CurrentValueSubject<Bool, Error>(isReachable())
            .tryMap { isReachable in
                guard isReachable else {
                    throw URLError(.cannotFindHost)
                }
                return true
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func isReachable() -> Bool {
        guard let reachability = reachability else {
            logger.error("\(#function): Nil reachability property.")
            return false
        }
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)

        let isReachable = flags.contains(.reachable)
        let connectionRequired = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)
        let result = isReachable && (!connectionRequired || canConnectWithoutIntervention)
        logger.debug("\(#function): \(result)")
        return isReachable && (!connectionRequired || canConnectWithoutIntervention)
    }
    
    // MARK: - HTTPRequest
    
    func perform(_ request: HTTPRequest) -> AnyPublisher<Data, Error> {
        let sessionRequestPublisher = session.dataTaskPublisher(for: request)
            .tryMap() { [logger] element -> Data in
                #if DEBUG
                logger.debug("\(element.response)")
                #endif
                
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                if httpResponse.statusCode == 401 {
                    throw URLError(.userAuthenticationRequired)
                }
                
                guard httpResponse.statusCode == 200 else {
                    if let responseDataAsString = String(data: element.data, encoding: .utf8) {
                        #if DEBUG
                        logger.debug("\(request): \(responseDataAsString)")
                        #endif
                        throw URLError(.cannotParseResponse)
                    } else {
                        throw URLError(.badServerResponse)
                    }
                }
                return element.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        return getReachabilityPublisher()
            .flatMap { _ -> AnyPublisher<Data, Error> in
                return sessionRequestPublisher
            }
            .eraseToAnyPublisher()
    }
    
    func perform<T: Codable>(_ request: HTTPRequest, responseType: T.Type = T.self) -> AnyPublisher<T, Error> {
        return perform(request)
            .flatMap { data -> AnyPublisher<T, Error> in
                let decoder = JSONDecoder()
                if let response = try? decoder.decode(T.self, from: data) {
                    return Just(response).setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }

                do {
                    let errorResponse = try decoder.decode(BasicHTTPResponse.self, from: data)
                    return Fail(error: errorResponse)
                        .eraseToAnyPublisher()
                } catch (let error) {
                    guard let stringResponse = String(data: data, encoding: .utf8) else {
                        return Fail(error: error)
                            .eraseToAnyPublisher()
                    }
                    if stringResponse.contains("session expired") {
                        return Fail(error: URLError(.userAuthenticationRequired))
                            .eraseToAnyPublisher()
                    } else  {
                        return Fail(error: BasicHTTPResponse(success: false, error: "Unknown Server Error Received."))
                            .eraseToAnyPublisher()
                    }
                }
            }
            .tryCatch { error -> AnyPublisher<T, Error> in
                if let urlError = error as? URLError, urlError.errorCode == -1200 {
                    return Fail(error: URLError(.appTransportSecurityRequiresSecureConnection))
                        .eraseToAnyPublisher()
                }
                throw error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - BasicHTTPResponse

public struct BasicHTTPResponse: HTTPResponse, LocalizedError {
    
    public let success: Bool
    public let error: String?
    
    public var errorDescription: String? { error }
    public var recoverySuggestion: String? { error }
    public var helpAnchor: String? { "Try Postman or ask Roshee for help." }
}
