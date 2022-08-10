//
//  Publisher.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 10/8/22.
//

import Foundation
import Combine

// MARK: - sinkToKeyPath

extension Publisher {
    
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

extension Publisher {
    
    func onlyDecode<T: Codable>(type: T.Type) -> Publishers.OnlyDecode<Self, T> {
        return .init(upstream: self)
    }
}

extension Publishers {
    
    struct OnlyDecode<Upstream: Publisher, DecodedOutput: Codable>: Publisher where Upstream.Output == Data {
        
        typealias Output = DecodedOutput
        typealias Failure = Upstream.Failure
        
        private let upstream: Upstream
        private let decoder: JSONDecoder
        
        init(upstream: Upstream) {
            self.upstream = upstream
            self.decoder = JSONDecoder()
        }
        
        func receive<S>(subscriber: S) where S: Subscriber, Upstream.Failure == S.Failure, DecodedOutput == S.Input {
            self.upstream
                .compactMap { try? decoder.decode(DecodedOutput.self, from: $0) }
                .subscribe(subscriber)
        }
    }
}

// MARK: - gatherData

extension Publisher {
    
    func gatherData<T: Codable>(ofType type: T.Type) -> Publishers.GatherData<Self, T> {
        return .init(upstream: self)
    }
}

extension Publishers {
    
    struct GatherData<Upstream: Publisher, DecodedOutput: Codable>: Publisher where Upstream.Output == Data {
        
        typealias Output = DecodedOutput
        typealias Failure = Upstream.Failure
        
        private let upstream: Upstream
        private let decoder: JSONDecoder
        
        init(upstream: Upstream) {
            self.upstream = upstream
            self.decoder = JSONDecoder()
        }
        
        func receive<S>(subscriber: S) where S: Subscriber, Upstream.Failure == S.Failure, DecodedOutput == S.Input {
            self.upstream
                .scan(Data(), { $0 + $1 })
                .compactMap { try? decoder.decode(DecodedOutput.self, from: $0) }
                .subscribe(subscriber)
        }
    }
}

// MARK: - justDoIt()

extension Publisher {
    
    func justDoIt(_ action: @escaping (Self.Output) -> Void) -> Publishers.JustDoIt<Self> {
        return .init(action: action, upstream: self)
    }
}

extension Publishers {
    
    struct JustDoIt<Upstream: Publisher>: Publisher {
        typealias Output = Upstream.Output
        typealias Failure = Upstream.Failure
        
        let action: (Output) -> Void
        let upstream: Upstream
        
        func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input {
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

extension Publisher {
    
    func eraseToAnyVoidPublisher() -> AnyPublisher<Void, Self.Failure> {
        self
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
