//
//  LoginUseCase.swift
//  DependencyInjection
//
//  Created by Maveric on 16/4/23.
//

import Foundation

protocol LoginUseCase {
    func getUserDisplayName() -> String
}

class DefaultLoginUseCase: LoginUseCase {
    func getUserDisplayName() -> String {
        print("Using \(self)")
        return "Default User"
    }
}

class MockLoginUseCase: LoginUseCase {
    func getUserDisplayName() -> String {
        print("Using \(self)")
        return "Mock User"
    }
}

