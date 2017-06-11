//
//  Chapter1Basics.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/10.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter1Basics: NSObject {
    static public func run() {
        // ******** Constants and Variable ********
        // This code can be read as:
        //“Declare a new constant called qqCode, and give it a value of 10. Then, declare a new variable called nickName, and give it an <<initial>> value of "Lucy".”
        let qqCode = 10
        var nickName = "Boom"
        nickName = "Big Boom"
        print("qqCode = \(qqCode), nickName = \(nickName)")
        
        // you can declare multiple constants or variables on a single line
        let originX = 0.0, originY = 0.0, originZ = 0.0
        
        // type annotations
        var message: String
        message = "Hello, Motto."
        let red, green, blue: Double
        
        // support unicode characters
        let 最喜欢的动漫😊 = "海贼王"
        print("最喜欢的动漫: \(最喜欢的动漫😊)")
        
        // Integers: Int UInt...
        // Floating-Point Numbers: Float Double...
        
        // Type Safety and Type Inference
        // Specify Type or Make Type can be Infered
        // Note: you can not change a constant's value, you can change the value of a variable, but you can not change the type of a variable.
        
        // Numeric Literals
        let dicimalInteger = 17
        let binaryInteger = 0b10001
        let octalInteger = 0o21
        let hexadecimalInteger = 0x11
        
        // Type Conversion
        let pi = Double.pi
        let one = 1
        let piAddOne = pi + Double(one)
        
        // Type Aliases
        typealias MyInt = UInt8
        let myIntNumber: MyInt = 19
        
        // Boolean
        let orangesAreOrange: Bool = true
        if orangesAreOrange {
            print("Yes, you are right")
        }
        
        // Tuples
        let http404Error = (404, "Not Found")
        print("http404Error: \(http404Error.0), \(http404Error.1)")
        
        let http200Status = (code: 200, message: "It's OK")
        print("http200Status: \(http200Status.code), \(http200Status.message)")
        
        var http300Status: (code: Int, message: String)
        http300Status = (300, "300 Status")
        print("http300Status: \(http300Status.code), \(http300Status.message)")
        
        // Optionals
        // You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.
        // Example: Swift’s Int type has an initializer which tries to convert a String value into an Int value. However, not every string can be converted into an integer. The string "123" can be converted into the numeric value 123, but the string "hello, world" does not have an obvious numeric value to convert to.
        let possibleNumber1 = "123"
        let convertedNumber1 = Int(possibleNumber1)
        print("convertedNumber1 = \(convertedNumber1)")
        // If Statements and Forced Unwrapping
        let possibleNumber2 = "456"
        let convertedNumber2 = Int(possibleNumber2)
        if convertedNumber2 != nil {
            print("Convert Success: \(convertedNumber2!)")
        } else {
            print("Convert Failed")
        }
        // Optional Binding
        // You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable. Optional binding can be used with if and while statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action.
        let possibleNumber3 = "456"
        // This code can be read as: “If the optional Int returned by Int(possibleNumber3) contains a value, set a new constant called actualNumber to the value contained in the optional.”
        if let actualNumber = Int(possibleNumber3) {
            print("Optional Binding: \(actualNumber)")
        } else {
            print("Convert Failed")
        }
        
        // You can include as many optional bindings and Boolean conditions in a single if statement as you need to, separated by commas.
        if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
        
        if let firstNumber = Int("4") {
            if let secondNumber = Int("42") {
                if firstNumber < secondNumber && secondNumber < 100 {
                    print("\(firstNumber) < \(secondNumber) < 100")
                }
            }
        }
        
        // Implicitly Unwrapped Optionals
        
        // As described above, optionals indicate that a constant or variable is allowed to have “no value”. Optionals can be checked with an if statement to see if a value exists, and can be conditionally unwrapped with optional binding to access the optional’s value if it does exist.
        // Sometimes it is clear from a program’s structure that an optional will always have a value, after that value is first set. In these cases, it is useful to remove the need to check and unwrap the optional’s value every time it is accessed, because it can be safely assumed to have a value all of the time.
        // These kinds of optionals are defined as implicitly unwrapped optionals. You write an implicitly unwrapped optional by placing an exclamation mark (String!) rather than a question mark (String?) after the type that you want to make optional.
        // Implicitly unwrapped optionals are useful when an optional’s value is confirmed to exist immediately after the optional is first defined and can definitely be assumed to exist at every point thereafter. The primary use of implicitly unwrapped optionals in Swift is during class initialization, as described in Unowned References and Implicitly Unwrapped Optional Properties.
        // An implicitly unwrapped optional is a normal optional behind the scenes, but can also be used like a nonoptional value, without the need to unwrap the optional value each time it is accessed. The following example shows the difference in behavior between an optional string and an implicitly unwrapped optional string when accessing their wrapped value as an explicit String:
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // requires an exclamation mark
        
        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString // no need for an exclamation mark
        // You can think of an implicitly unwrapped optional as giving permission for the optional to be unwrapped automatically whenever it is used. Rather than placing an exclamation mark after the optional’s name each time you use it, you place an exclamation mark after the optional’s type when you declare it.
        
        // Error Handling
        func canThrowAnError() throws {
            // this function may or may not throw an error
        }
        do {
            // no error was thrown
            try canThrowAnError()
        } catch {
            // an error was thrown
        }
        
        // Assertions and Preconditions
        // Assertions and preconditions are checks that happen at runtime. You use them to make sure an essential condition is satisfied before executing any further code. If the Boolean condition in the assertion or precondition evaluates to true, code execution continues as usual. If the condition evaluates to false, the current state of the program is invalid; code execution ends, and your app is terminated.
        
        let age = 3
        // In this example, code execution continues if age >= 0 evaluates to true, that is, if the value of age is positive. If the value of age is negative, as in the code above, then age >= 0 evaluates to false, and the assertion fails, terminating the application. The message will show.
        assert(age >= 0, "A person's age can't be less than zero.")
        // If the code already checks the condition, you use the assertionFailure(_:file:line:) function to indicate that an assertion has failed. For example:
        if age > 10 {
            print("You can ride the roller-coaster or the ferris wheel.")
        } else if age > 0 {
            print("You can ride the ferris wheel.")
        } else {
            assertionFailure("A person's age can't be less than zero.")
        }
        
        // The difference between assertions and preconditions is in when they are checked: Assertions are checked only in debug builds, but preconditions are checked in both debug and production builds. In production builds, the condition inside an assertion isn’t evaluated. This means you can use as many assertions as you want during your development process, without impacting the performance in production.
        let myIndex = 10
        // In the implementation of a subscript...
        precondition(myIndex > 0, "Index must be greater than zero.")
    }
}
