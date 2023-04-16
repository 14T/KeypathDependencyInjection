//
//  LoginViewModel.swift
//  DependencyInjection
//
//  Created by Maveric on 16/4/23.
//

import Foundation

protocol LoginViewModel {
    func performLogin() -> String
}

class DefaultLoginViewModel: LoginViewModel {
    @Inject(\.login.useCase) var useCase
    
    func performLogin() -> String {
        print("Using \(self) with \(useCase)")
        return useCase.getUserDisplayName()
    }
}

class MockLoginViewModel: LoginViewModel {
    @Inject(\.login.useCase) var useCase
        
    func performLogin() -> String {
        print("Using \(self) with \(useCase)")
        return useCase.getUserDisplayName()
    }
}
