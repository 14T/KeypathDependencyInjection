//
//  InjectionMapper.swift
//  DependencyInjection
//
//  Created by Maveric on 16/4/23.
//

import Foundation
struct InjectionMapper {
    static var keyPathMapping: [AnyHashable: AnyHashable] = [:]

    static subscript<T>(_ keyPath: KeyPath<Container, T>) -> KeyPath<Container, T>? {
        get { keyPathMapping[keyPath] as? KeyPath<Container, T> }
        set {
            keyPathMapping[keyPath] = newValue
        }
    }

    static func map<T>(_ by: KeyPath<Container, T>, to: KeyPath<Container, T>) {
        keyPathMapping[to] = by
    }
    
    static func reset<T>(_ keyPath: KeyPath<Container, T>) {
        keyPathMapping.removeValue(forKey: keyPath)
    }
}
