//
//  ContentView.swift
//  DependencyInjection
//
//  Created by Maveric on 10/4/23.
//

import SwiftUI

struct ContentView: View {
    @Inject(\.login.viewModel) var viewModel
    @State var display: String = "Hello, world!"

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(display)
        }
        .padding()
        .onAppear{
            display = viewModel.performLogin()
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InjectionMapper[\.login.useCase] = \.login.previewUseCase
        InjectionMapper[\.login.viewModel] = \.login.previewViewModel
        return ContentView()
    }
}
