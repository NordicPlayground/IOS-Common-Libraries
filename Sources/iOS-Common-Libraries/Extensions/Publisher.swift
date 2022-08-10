//
//  Publisher.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 10/8/22.
//

import Foundation
import Combine

// MARK: - sinkToKeyPath

public extension Publisher {
    
    func sink<Root>(to keyPath: ReferenceWritableKeyPath<Root, Output>, in root: Root, assigningInCaseOfError errorValue: Output) -> AnyCancellable {
        self.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(_):
                root[keyPath: keyPath] = errorValue
            default:
                break
            }
        }) { result in
            root[keyPath: keyPath] = result
        }
    }
}

// MARK: - onlyDecode

public extension Publisher {
    
    func onlyDecode<T: Codable>(type: T.Type) -> Publishers.OnlyDecode<Self, T> {
        return .init(upstream: self)
    }
}

public extension Publishers {
    
    struct OnlyDecode<Upstream: Publisher, DecodedOutput: Codable>: Publisher where Upstream.Output == Data {
        
        public typealias Output = DecodedOutput
        public typealias Failure = Upstream.Failure
        
        private let upstream: Upstream
        private let decoder: JSONDecoder
        
        init(upstream: Upstream) {
            self.upstream = upstream
            self.decoder = JSONDecoder()
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Upstream.Failure == S.Failure, DecodedOutput == S.Input {
            self.upstream
                .compactMap { try? decoder.decode(DecodedOutput.self, from: $0) }
                .subscribe(subscriber)
        }
    }
}

// MARK: - gatherData

public extension Publisher {
    
    func gatherData<T: Codable>(ofType type: T.Type) -> Publishers.GatherData<Self, T> {
        return .init(upstream: self)
    }
}

public extension Publishers {
    
    struct GatherData<Upstream: Publisher, DecodedOutput: Codable>: Publisher where Upstream.Output == Data {
        
        public typealias Output = DecodedOutput
        public typealias Failure = Upstream.Failure
        
        private let upstream: Upstream
        private let decoder: JSONDecoder
        
        init(upstream: Upstream) {
            self.upstream = upstream
            self.decoder = JSONDecoder()
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Upstream.Failure == S.Failure, DecodedOutput == S.Input {
            self.upstream
                .scan(Data(), { $0 + $1 })
                .compactMap { try? decoder.decode(DecodedOutput.self, from: $0) }
                .subscribe(subscriber)
        }
    }
}

// MARK: - justDoIt()

public extension Publisher {
    
    func justDoIt(_ action: @escaping (Self.Output) -> Void) -> Publishers.JustDoIt<Self> {
        return .init(action: action, upstream: self)
    }
}

public extension Publishers {
    
    struct JustDoIt<Upstream: Publisher>: Publisher {
        public typealias Output = Upstream.Output
        public typealias Failure = Upstream.Failure
        
        let action: (Output) -> Void
        let upstream: Upstream
        
        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input {
            upstream
                .map { output in
                    action(output)
                    return output
                }
                .subscribe(subscriber)
        }
    }
}

// MARK: eraseToAnyVoidPublisher()

public extension Publisher {
    
    func eraseToAnyVoidPublisher() -> AnyPublisher<Void, Self.Failure> {
        self
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
