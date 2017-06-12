//
//  Chapter7Closures.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/12.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter7Closures: NSObject {
    static public func run() {
        // Closures
        // Closures are self-contained blocks of functionality that can be passed around and used in your code.
        // 1. Closure Expressions
        // 2. Trailing Closures
        // 3. Capturing Values
        // 4. Closures Are Reference Types
        // 5. Escaping Closures
        // 6. Autoclosures
        
        // Global and nested functions, as introduced in Functions, are actually special cases of closures. Closures take one of three forms:
        // (1) Global functions are closures that have a name and do not capture any values.
        // (2) Nested functions are closures that have a name and can capture values from their enclosing function.
        // (3)Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
        
        // 1. Closure Expressions
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        let namesSorted1 = names.sorted(by: backward)
        print("names sorted by backward function: \(namesSorted1)")
        // 1.1 Closure Expression Syntax
        /*
        { (parameters) -> return type in
            statements
        }
         */
        let namesSorted2 = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2
        })
        print("names sorted by closure: \(namesSorted2)")
        // The parameters in closure expression syntax can be in-out parameters, but they can’t have a default value. Variadic parameters can be used if you name the variadic parameter. Tuples can also be used as parameter types and return types.
        // 1.2 Inferring Type From Context
        // Because the sorting closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns.The sorted(by:) method is being called on an array of strings, so its argument must be a function of type (String, String) -> Bool. This means that the (String, String) and Bool types do not need to be written as part of the closure expression’s definition. Because all of the types can be inferred, the return arrow (->) and the parentheses around the names of the parameters can also be omitted:
        let namesSorted3 = names.sorted(by: {
            s1, s2 in return s1 > s2
        })
        print("names sorted by ommitted closure(inferred type): \(namesSorted3)")
        // 1.3 Implicit Returns from Single-Expression Closures
        // <<Single-expression closures>> can implicitly return the result of their single expression by omitting the return keyword from their declaration, as in this version of the previous example:
        let namesSorted4 = names.sorted(by: {s1, s2 in s1 > s2})
        print("names sorted by ommitted closure(omit return): \(namesSorted4)")
        // 1.4 Shorthand Argument Names
        // Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
        // Here, $0 and $1 refer to the closure’s first and second String arguments.
        let namesSorted5 = names.sorted(by: { $0 > $1 })
        print("names sorted by ommitted closure(omit argument names): \(namesSorted5)")
        // 1.5 Operator Methods
        // Swift’s <<String type defines>> its string-specific implementation of the greater-than operator (>) as a method that has two parameters of type String, and returns a value of type Bool. This exactly matches the method type needed by the sorted(by:) method. Therefore, you can simply pass in the greater-than operator, and Swift will infer that you want to use its string-specific implementation:
        let namesSorted6 = names.sorted(by: >)
        print("names sorted by ommitted closure(operator method): \(namesSorted6)")
        
        
        // 2. Trailing Closures
        
        // 3. Capturing Values
        
        // 4. Closures Are Reference Types
        
        // 5. Escaping Closures
        
        // 6. Autoclosures
        
    }
}
