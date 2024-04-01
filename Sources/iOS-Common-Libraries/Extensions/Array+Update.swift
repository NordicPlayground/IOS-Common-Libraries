//
//  File.swift
//  
//
//  Created by Nick Kibysh on 07/07/2023.
//

import Foundation

extension Array {
    public func replaceOrAppend(_ newElement: Element, firstWhere closure: (Element) -> Bool) -> [Element] {
        var newArray = self
        
        for e in newArray.enumerated() {
            if closure(e.element) {
                newArray[e.offset] = newElement
                return newArray
            }
        }
        
        newArray.append(newElement)
        return newArray
    }
    
    @discardableResult
    mutating public func replacedOrAppended(_ newElement: Element, firstWhere closure: (Element) -> Bool) -> Bool {
        for e in self.enumerated() {
            if closure(e.element) {
                self[e.offset] = newElement
                return true
            }
        }
        
        self.append(newElement)
        return false
    }
}

extension Array where Element: Equatable {
    public func replaceOrAppend(_ newElement: Element) -> [Element] {
        var newArray = self
        
        for e in newArray.enumerated() {
            if e.element == newElement {
                newArray[e.offset] = newElement
                return newArray
            }
        }
                
        newArray.append(newElement)
        return newArray
    }
    
    @discardableResult
    mutating public func replacedOrAppended(_ newElement: Element) -> Bool {
        for e in self.enumerated() {
            if e.element == newElement {
                self[e.offset] = newElement
                return true
            }
        }
        
        self.append(newElement)
        return false
    }
}

extension Array {
    public func replaceOrAppend<V: Equatable>(_ newElement: Element, compareBy keyPath: KeyPath<Element, V>) -> [Element] {
        var newArray = self
        
        for e in newArray.enumerated() {
            if e.element[keyPath: keyPath] == newElement[keyPath: keyPath] {
                newArray[e.offset] = newElement
                return newArray
            }
        }
                
        newArray.append(newElement)
        return newArray
    }
    
    @discardableResult
    mutating public func replacedOrAppended<V: Equatable>(_ newElement: Element, compareBy keyPath: KeyPath<Element, V>) -> Bool {
        for e in self.enumerated() {
            if e.element[keyPath: keyPath] == newElement[keyPath: keyPath] {
                self[e.offset] = newElement
                return true
            }
        }
        
        self.append(newElement)
        return false
    }
}
