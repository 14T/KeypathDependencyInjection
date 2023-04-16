//
//  LoginContainer.swift
//  DependencyInjection
//
//  Created by Maveric on 16/4/23.
//

import Foundation

//MARK: Add LoginContainer to main container
extension Container {
    var login: LoginContainer {
        LoginContainer()
    }
}

// MARK: Default
struct LoginContainer {
    var viewModel: LoginViewModel {
        DefaultLoginViewModel()
    }
    
    var useCase: LoginUseCase {
        DefaultLoginUseCase()
    }
}


// MARK: Mock
extension LoginContainer {
    var previewViewModel: LoginViewModel {
        MockLoginViewModel()
    }
    
    var previewUseCase: LoginUseCase {
        MockLoginUseCase()
    }
}
