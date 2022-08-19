//
//  Cache.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 7/4/21.
//

import Foundation

/**
 - Source: [Swift by Sundell](https://www.swiftbysundell.com/articles/caching-in-swift/)
 */
final class Cache<Key: Hashable, Value> {
    
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    // MARK: - Subscript API
    
    subscript(key: Key) -> Value? {
        get {
            let wrappedKey = WrappedKey(key)
            return wrapped.object(forKey: wrappedKey)?.value
        }
        set {
            let wrappedKey = WrappedKey(key)
            guard let value = newValue else {
                // If nil was assigned using our subscript,
                // then we remove any value for that key:
                wrapped.removeObject(forKey: wrappedKey)
                return
            }
            wrapped.setObject(Entry(value: value), forKey: wrappedKey)
        }
    }
}

// MARK: - Cache.WrappedKey

fileprivate extension Cache {
    
    final class WrappedKey: NSObject {
        
        let key: Key

        init(_ key: Key) {
            self.key = key
        }

        override var hash: Int {
            key.hashValue
        }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
}

// MARK: - Cache.Entry

fileprivate extension Cache {
    
    final class Entry {
        let value: Value

        init(value: Value) {
            self.value = value
        }
    }
}
