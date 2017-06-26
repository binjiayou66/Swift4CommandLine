//
//  Chapter23Generics.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/16.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter23Generics: NSObject {
    static public func run() {
        // Generics
        // (1) The Problem That Generics Solve
        // (2) Generic Functions
        // (3) Type Parameters
        // (4) Naming Type Parameters
        // (5) Generic Types
        // (6) Extending a Generic Type
        // (7) Type Constraints
        // (8) Associated Types
        // (9) Generic Where Clauses
        // (10) Extensions with a Generic Where Clause
        // (11) Associated Types with a Generic Where Clause
        // (12) Generic Subscripts
        
        // Summary:
        // >>1 Generics in functions, like T/U/V and so on.
        // >>2 Generics in types, associatedtype AType.
        // >>3 Generic where clause, add some constraints.
        
        // Generics
        // (1) The Problem That Generics Solve
        // (2) Generic Functions
        // Declare: Written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).
        // Usage: Just like normal types.
        func swapTwoValue<T>(_ a: inout T, _ b: inout T) {
            let tmp = a
            a = b
            b = tmp
        }
        var num1 = 19, num2 = 33
        print("num1 = \(num1), num2 = \(num2)")
        swapTwoValue(&num1, &num2)
        print("num1 = \(num1), num2 = \(num2)")
        
        var str1 = "abc", str2 = "kkk"
        print("str1 = \(str1), str2 = \(str2)")
        swapTwoValue(&str1, &str2)
        print("str1 = \(str1), str2 = \(str2)")
        
        // (3) Type Parameters
        // Declare: Written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).
        // Usage: Just like normal types.
        // You can use it to define the type of a function’s parameters or as the function’s return type, or as a type annotation within the body of the function.
        // In each case, the type parameter is replaced with an actual type whenever the function is called. (In the swapTwoValues(_:_:) example above, T was replaced with Int the first time the function was called, and was replaced with String the second time it was called.)
        // You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.
        func multipleType<T, U>(_ a: T, _ b: U) {
            
        }
        
        // (4) Naming Type Parameters
        
        // (5) Generic Types
        // In addition to generic functions, Swift enables you to define your own generic types. These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.
        
        
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("abc")
        
        // (6) Extending a Generic Type
        // Note that this extension doesn’t define a type parameter list. Instead, the Stack type’s existing type parameter name, Element, is used within the extension to indicate the optional type of the topItem computed property.
        
        
        // (7) Type Constraints
        // it is sometimes useful to enforce certain type constraints on the types that can be used with generic functions and generic types. Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.
        // For example, Swift’s Dictionary type places a limitation on the types that can be used as keys for a dictionary. As described in Dictionaries, the type of a dictionary’s keys must be hashable. That is, it must provide a way to make itself uniquely representable. Dictionary needs its keys to be hashable so that it can check whether it already contains a value for a particular key.
        /*
        func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
             // function body goes here
        }
        */
        func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        
        // (8) Associated Types
        // When defining a protocol, it is sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that is used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.
        
        
        // (9) Generic Where Clauses
        // C1 must conform to the Container protocol (written as C1: Container).
        // C2 must also conform to the Container protocol (written as C2: Container).
        // The Item for C1 must be the same as the Item for C2 (written as C1.Item == C2.Item).
        // The Item for C1 must conform to the Equatable protocol (written as C1.Item: Equatable).
        func allItemsMatch<C1: AnotherContainer, C2: AnotherContainer>
            (_ someContainer: C1, _ anotherContainer: C2) -> Bool
            where C1.AnotherItem == C2.AnotherItem, C1.AnotherItem: Equatable {
                
                // Check that both containers contain the same number of items.
                if someContainer.count != anotherContainer.count {
                    return false
                }
                
                // Check each pair of items to see if they are equivalent.
                for i in 0..<someContainer.count {
                    if someContainer[i] != anotherContainer[i] {
                        return false
                    }
                }
                
                // All items match, so return true.
                return true
        }
        
        
        // (10) Extensions with a Generic Where Clause
        // (11) Associated Types with a Generic Where Clause
        // (12) Generic Subscripts
    }
}

struct IntStack {
    var content = [Int]()
    mutating func push(_ num: Int) {
        content.append(num)
    }
    mutating func pop() -> Int {
        return content.removeLast()
    }
}

struct Stack<Element> {
    var content = [Element]()
    mutating func push(_ element: Element) {
        content.append(element)
    }
    mutating func pop() -> Element {
        return content.removeLast()
    }
}

// (6) Extending a Generic Type
// Note that this extension doesn’t define a type parameter list. Instead, the Stack type’s existing type parameter name, Element, is used within the extension to indicate the optional type of the topItem computed property.
extension Stack {
    var topElement: Element? {
        return content.isEmpty ? nil : content[content.count - 1]
    }
}

// (8) Associated Types
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct DoubleStack: Container {
    // conformance to the Container protocol
    typealias Item = Double
    var items = [Double]()
    mutating func append(_ item: Item) {
        items.append(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Item {
        return items[i]
    }
}

struct FullyStack<Element>: Container {
    var content = [Element]()
    mutating func push(_ element: Element) {
        content.append(element)
    }
    mutating func pop() -> Element {
        return content.removeLast()
    }
    // conformance to the Container protocol
    typealias Item = Element
    var count: Int {
        return content.count
    }
    mutating func append(_ item: Element) {
        content.append(item)
    }
    subscript(i: Int) -> Item {
        return content[i]
    }
}

// Extending an Existing Type to Specify an Associated Type
extension Array: Container {}

// Using Type Annotations to Constrain an Associated Type
protocol AnotherContainer {
    associatedtype AnotherItem: Equatable
    mutating func append(_ item: AnotherItem)
    var count: Int { get }
    subscript(i: Int) -> AnotherItem { get }
}

// Extensions with a Generic Where Clause
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = content.last else {
            return false
        }
        return topItem == item
    }
}

// Associated Types with a Generic Where Clause
protocol AgainContainer {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

// Generic Subscripts
// Subscripts can be generic, and they can include generic where clauses. You write the placeholder type name inside angle brackets after subscript, and you write a generic where clause right before the opening curly brace of the subscript’s body. For example:
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
// The generic parameter Indices in angle brackets has to be some type that conforms to the Sequence protocol from the standard library.
// The subscript takes a single parameter, indices, which is an instance of that Indices type.
// The generic where clause requires that the iterator for the sequence must traverse over elements of type Int. This ensures that the indices in the sequence are the same type as the indices used for a container.

// Taken together, these constraints mean that the value passed for the indices parameter is a sequence of integers.




