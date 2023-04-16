//
//  DependencyInjectionApp.swift
//  DependencyInjection
//
//  Created by Maveric on 10/4/23.
//

import SwiftUI

@main
struct DependencyInjectionApp: App {
    
    init() {
//        Need to do injection before creating class instance, in this case before creating ContentView()
        
//        InjectionMapper.map(\.login.previewUseCase, to: \.login.useCase)
//        InjectionMapper[\.login.viewModel] = \.login.previewViewModel
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
