//
//  DIContainer.swift
//  DependencyInjection
//
//  Created by Maveric on 10/4/23.
//

import Foundation
/// Provides access to injected dependencies.
class Container {
    static var main = Container()
    private init() {}
    
    static subscript<T>(_ keyPath: KeyPath<Container, T>) -> T {
        let key = InjectionMapper[keyPath] ?? keyPath
        return Self.main[keyPath: key]
    }
    
    static subscript<T>(_ keyPath: WritableKeyPath<Container, T>) -> T {
        get {
            let key = InjectionMapper[keyPath] ?? keyPath
            return Self.main[keyPath: key]
        }
        set {
            Self.main[keyPath: keyPath] = newValue
        }
    }
}
