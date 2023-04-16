//
//  DependencyInjectionTests.swift
//  DependencyInjectionTests
//
//  Created by Maveric on 10/4/23.
//

import XCTest
@testable import DependencyInjection

extension LoginContainer {
    var mockTestViewModel: LoginViewModel {
        MockTestLoginViewModel()
    }
    
    var mockTestUseCase: LoginUseCase {
        MockTestLoginUseCase()
    }
}

final class DependencyInjectionTests: XCTestCase {
    var sut: LoginUseCase!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        InjectionMapper[\.login.useCase] = \.login.mockTestUseCase
        InjectionMapper[\.login.viewModel] = \.login.mockTestViewModel
        sut = Container[\.login.useCase]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDisplayName() throws {
        let name = sut.getUserDisplayName()
        XCTAssertEqual(name, "Test Mock User")
    }

}

class MockTestLoginViewModel: LoginViewModel {
    @Inject(\.login.useCase) var useCase
    
    func performLogin() -> String {
        print("Using \(self) with \(useCase)")
        return useCase.getUserDisplayName()
    }
}


class MockTestLoginUseCase: LoginUseCase {
    func getUserDisplayName() -> String {
        print("Using \(self)")
        return "Test Mock User"
    }
}
