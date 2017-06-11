//
//  Chapter2BasicOperators.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/10.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter2BasicOperators: NSObject {
    static public func run() {
        // An operator is a special symbol or phrase that you use to check, change
        // This chapter describes the common operators in Swift. Advanced Operators covers Swift’s advanced operators, and describes how to define your own custom operators and implement the standard operators for your own custom types.
        
        // Terminology
        // Operators are unary, binary, or ternary:
        // Unary operators operate on a single target (such as -a). Unary prefix operators appear immediately before their target (such as !b), and unary postfix operators appear immediately after their target (such as c!).
        // Binary operators operate on two targets (such as 2 + 3) and are infix because they appear in between their two targets.
        // Ternary operators operate on three targets. Like C, Swift has only one ternary operator, the ternary conditional operator (a ? b : c).
        // The values that operators affect are operands. In the expression 1 + 2, the + symbol is a binary operator and its two operands are the values 1 and 2.
        
        // Assignment Operator
        // The assignment operator (a = b) initializes or updates the value of a with the value of b:
        let a = 10
        var b: Int?
        b = a
        print("a = \(a), b = \(b)")
        // Tuple
        let (x, y) = (10, 80)
        // The following statement is not valid. Because the assignment operator in Swift does not itself return a value.
        // if x = y {  }
        
        // Arithmetic Operators
        // Addition (+)
        // Subtraction (-)
        // Multiplication (*)
        // Division (/)
        let ao1 = 1 + 2
        // invalid
        let ao2 = 1.5
        let ao3 = 3
        // let ao4 = ao2 + ao3
        // The addition operator is also supported for String concatenation:
        let ao5 = "Hello" + "World! \(ao1)"
        
        // Compound Assignment Operators
        var num = 10
        num += 10
        
        // Comparison Operators
        // ==, !=, >, <, >=, <=
        (1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared
        (3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
        (4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
        
        // Ternary Conditional Operator
        var nickName: String?
        nickName = "Lee"
        let name = nickName == nil ? "Default Name" : nickName!
        print("name = \(name)")
        
        // Nil-Coalescing Operator
        // shorthand code for `let name1 = nickName == nil ? "Default Name 1" : nickName!`
        let name1 = nickName ?? "Default Name 1"
        print("name1 = \(name1)")
        
        // Range Operators
        // ...
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        // ..<
        let names = ["Anna", "Alex", "Brian", "Jack"]
        let count = names.count
        for i in 0..<count {
            print("Person \(i + 1) is called \(names[i])")
        }
        // One-Sided Ranges
        for name in names[2...] {
            print(name)
        }
        // Brian
        // Jack
        
        for name in names[..<2] {
            print(name)
        }
        // Anna
        // Alex
        
        // create a range
        let range = ...5
        print("range = \(range)")
        
        // Logical Operators
        // Logical NOT (!a)
        // Logical AND (a && b)
        // Logical OR (a || b)
        let enteredDoorCode = true
        let passedRetinaScan = true
        let hasDoorKey = true
        let knowsOverridePassword = true
        if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        // don't do like this. it's ok, but we don't advice to do like this.
        if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword { }
    }
}
