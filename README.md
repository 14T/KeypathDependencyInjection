# DependencyInjection
 Dependency Injection Example demonstrating my article https://medium.com/@anand.chetan/how-to-inject-dependencies-using-keypath-like-a-pro-3de1312092d0

How To Inject Dependencies using KeyPath Like A Pro!
====================================================

**(For SwiftUI And UIKit)**

> A Simple and Run-Time Safe Dependency Injection with Swift KeyPath and Property Wrappers and it support _Layered dependency Injection_

I spent 10 days exploring various libraries to inject dependencies, but I didn’t want to rely on a library for something that could be done natively.

Then I had this brilliant idea: why not use Swift’s amazing keyPath feature to change the reference of the dependency instead of the dependency itself?

That’s how I created my own Dependency Injection with a simple and powerful technique. I’ll explain that in a while but before that lets discuss

Why I couldn’t opt for any existing solution:
---------------------------------------------

*   Most of the resolver patterns require us to register a dependency before we can use it. If we use it without registering it first, it will crash the application.
*   Most of them provide solutions using shared instances of dependencies.
*   The solutions need too much extra code.

So this is how I solved it:
---------------------------

1.  Created an **Injection Mapper**, using which we can _map_ the dependency we need to inject in place of any existing dependency. I’ll explain it more in a while but this is the line of code we need to write to achieve this:

InjectionMapper\[\\.login.viewModel\] = \\.login.mockTestViewModel

2\. Created a **Container** class that is basically a factory for all the dependencies. I’m using the factory pattern here by using swift computed property to create a new instance every time we need it.

3\. Created a **property wrapper** called **Inject** that offers a concise way to supply dependencies without writing _init_ to any class

> The fundamental difference here, is we are just specifying which object to use at runtime, instead of actually supplying the object instance unlike other libraries do.

Container
=========

First of all, create a dependency as you normally would, but it should be inside the Container or its sub-containers

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
  
// MARK: Mock dependencies  
extension LoginContainer {  
    var mockTestViewModel: LoginViewModel {  
        MockTestLoginViewModel()  
    }  
      
    var mockTestUseCase: LoginUseCase {  
        MockTestLoginUseCase()  
    }  
}

Yes, we do support layered dependencies, i.e., these dependencies can be accessed using the main container

let useCase = Container\[\\.login.useCase\]

That’s Not All, we have a property wrapper **Inject** that can be used anywhere to get the dependencies directly.

Inject Property Wrapper
=======================

@Inject(\\.login.viewModel) var viewModel

> Note: we don’t even need to declare this property with its type. Swift type inference is there at service.

Also we can eliminate _init_ method to supply dependency to any class/struct, very useful in case of initializing ViewController where [instantiateViewController(identifier:creator:)](https://developer.apple.com/documentation/uikit/uistoryboard/3213989-instantiateviewcontroller) is the only option.

Fair enough, but how do we inject the dependencies when we need to change the default implementation to its mock implementation for unit testing or SwiftUI preview? The answer is:

Injection Mapper
================

This is a simple struct which can be used to map one dependency keyPath to another.

struct InjectionMapper {  
    static var keyPathMapping: \[AnyHashable: AnyHashable\] = \[:\]  
  
    static subscript<T>(\_ keyPath: KeyPath<Container, T>) -> KeyPath<Container, T>? {  
        get { keyPathMapping\[keyPath\] as? KeyPath<Container, T> }  
        set {  
            keyPathMapping\[keyPath\] = newValue  
        }  
    }  
  
    static func map<T>(\_ by: KeyPath<Container, T>, to: KeyPath<Container, T>) {  
        keyPathMapping\[to\] = by  
    }  
      
    static func reset<T>(\_ keyPath: KeyPath<Container, T>) {  
        keyPathMapping.removeValue(forKey: keyPath)  
    }  
}

**If you are familiar with SwiftUI the this below syntax would makes sense to you .**

To inject dependency, use it like this:

InjectionMapper\[\\.login.viewModel\] = \\.login.previewViewModel

or use the **map** function of InjectionMapper if you like this syntax more:

InjectionMapper.map(\\.login.previewUseCase, to: \\.login.useCase)

That’s it. With less than 80 lines of code, we addressed all the problems with Dependency Injection, and I hope this will benefit you too.

> Note: We need to inject dependency using InjectionMapper before class/struct instance is created, else the Inject will use the default dependency implementation.

Conclusion
----------

*   We leveraged **Swift’s powerful keyPath** feature to inject dependencies without modifying their implementation.
*   We **avoided runtime crashes** by getting compile-time errors if we forgot to register any dependency.
*   We used a **property wrapper to inject** dependencies with ease and elegance.
*   **Testability is improved** drastically as we can Inject dependencies throughout the application with just one line of code.
*   We implemented dependency injection in a native Swift style without relying on external libraries.

**Thank you for reading and have a wonderful day!**
https://medium.com/@anand.chetan/how-to-inject-dependencies-using-keypath-like-a-pro-3de1312092d0
