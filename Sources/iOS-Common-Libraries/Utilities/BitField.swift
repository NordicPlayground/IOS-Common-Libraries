//
//  BitField.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 22/9/23.
//  Copyright © 2019 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - BitField

/**
 See: `https://devzone.nordicsemi.com/nordic/nordic-blog/b/blog/posts/on-nrf-connect-for-ios-and-its-unnecessary-bitfield-collection-in-swift`
 */
public struct BitField<T: Option>: Hashable, Codable, ExpressibleByArrayLiteral where T.RawValue == RegisterValue {
    
    // MARK: all()
    
    public static func all() -> Self {
        return BitField<T>(T.allCases.map { $0 })
    }
    
    // MARK: Properties
    
    private var bitField: RegisterValue

    // MARK: Init

    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
    
    public init(_ registerValue: RegisterValue) {
        self.bitField = registerValue
    }
    
    public init(_ initialMembers: [T]) {
        self.bitField = initialMembers.reduce(0, { $0 + $1.bitwiseValue })
    }

    // MARK: Codable

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        let decodedValue = try container.decode(RegisterValue.self)
        self.bitField = T.allCases.reduce(0, {
            guard decodedValue & $1.bitwiseValue == $1.bitwiseValue else { return $0 }
            return $0 + $1.bitwiseValue
        })
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(bitField)
    }

    // MARK: API

    public func contains(_ member: T) -> Bool {
        return isBitSet(member.bitwiseValue)
    }
    
    public func contains(allOf list: [T]) -> Bool {
        return list.allSatisfy({ contains($0) })
    }

    public func has(oneOf: [T]) -> Bool {
        return oneOf.first(where: { contains($0) }) != nil
    }
    
    /**
     BitField's value as Data bytes.
     
     Note that the number of bytes to clip the Data to is required. This is because not all BitField(s)
     require the full word-size - they may even know for sure they'll use at most a single byte. It's
     feasable for us to automagically determine the minimum number of bytes needed to represent the
     BitField and set the size ourselves, but then, this might trigger issues down the line if the underlying
     values are expanded. And what fit before in a single byte, now needs two. So instead, to be safe,
     we put this responsability in the programmer (i.e. API user)'s hands.
     
     - parameter clippedTo: the Data will be clipped to the desired byte-size. For a single byte, ´UInt8.self´ should be used. For two bytes, ´UInt16.self´. And so on.
     */
    public func data<S: FixedWidthInteger>(clippedTo outputSize: S.Type) -> Data {
        var clippedValue = S(bitField)
        let capacity = MemoryLayout<S>.size
        // Shamelessly stolen from CBOR's FixedWidthInteger extension
        let bytes = withUnsafePointer(to: &clippedValue) {
            return $0.withMemoryRebound(to: UInt8.self, capacity: capacity) {
                return Array(UnsafeBufferPointer(start: $0, count: capacity))
            }
        }
        return Data(bytes)
    }
    
    // MARK: Mutating API

    public mutating func insert(_ newMember: T) {
        guard !contains(newMember) else { return }
        flip(newMember)
    }

    public mutating func remove(_ member: T) {
        guard contains(member) else { return }
        flip(member)
    }
    
    public mutating func removeAll() {
        bitField = 0
    }
    
    public mutating func union(with items: [T]) {
        let sequenceOptions = BitField(items)
        bitField = T.allCases.reduce(0) {
            guard contains($1) || sequenceOptions.contains($1) else { return $0 }
            return $0 + $1.bitwiseValue
        }
    }
    
    public mutating func flip(_ member: T) {
        precondition(member.rawValue < RegisterValue.bitWidth)
        bitField = bitField ^ member.bitwiseValue
    }
    
    // MARK: Private
    
    private func isBitSet(_ bitwiseValue: RegisterValue) -> Bool {
        return bitField & bitwiseValue == bitwiseValue
    }
    
    private func bitsetMembers() -> [T] {
        T.allCases.filter({ contains($0) })
    }
}

// MARK: - Collection

extension BitField: Collection {
    
    public typealias Element = T
    public struct Index: Comparable {
        
        let offset: Int

        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.offset == rhs.offset
        }

        public static func < (lhs: Self, rhs: Self) -> Bool {
            return lhs.offset < rhs.offset
        }
    }

    public var startIndex: Index { Index(offset: 0) }
    public var endIndex: Index { Index(offset: bitsetMembers().count) }

    public subscript(position: Index) -> Element {
        precondition(indices.contains(position), "out of bounds")
        return bitsetMembers()[position.offset]
    }

    public func index(after i: Index) -> Index {
        let nextIndex = Index(offset: i.offset + 1)
        return nextIndex < endIndex ? nextIndex : endIndex
    }
}

// MARK: - CustomStringConvertible

extension BitField: CustomStringConvertible {
    
    public var description: String {
        let lastUseableBit = Int(Element.allCases.max(by: { $0.bitwiseValue < $1.bitwiseValue })?.rawValue ?? 0)
        let unuseableBits = RegisterValue.bitWidth - lastUseableBit - 1
        var bitView: String
        if unuseableBits > 2 {
            bitView = "MSB | (\(unuseableBits) 0s) "
            for i in stride(from: lastUseableBit, through: 0, by: -1) {
                bitView += isBitSet(1 << i as RegisterValue) ? "1" : "0"
            }
        } else {
            bitView = "MSB | "
            for i in stride(from: Int(RegisterValue.bitWidth) - 1, through: 0, by: -1) {
                bitView += isBitSet(1 << i as RegisterValue) ? "1" : "0"
            }
        }
        return bitView + " | LSB\n" + bitsetMembers().description
    }
}
