//
//  Inject.swift
//  DependencyInjection
//
//  Created by Maveric on 16/4/23.
//

import Foundation

@propertyWrapper
class Inject<T> {
    var wrappedValue: T

    init(_ keyPath: KeyPath<Container, T>) {
        self.wrappedValue = Container[keyPath]
    }
}
