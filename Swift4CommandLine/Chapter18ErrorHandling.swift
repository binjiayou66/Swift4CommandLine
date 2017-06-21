//
//  Chapter18ErrorHandling.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/16.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter18ErrorHandling: NSObject {
    static public func run() {
        // Error Handling
        // (1) Representing and Throwing Errors
        // (2) Handling Errors
        // (3) Specifying Cleanup Actions
        
        // Error Handling
        // Error handling is the process of responding to and recovering from error conditions in your program. Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime.
        // Some operations aren’t guaranteed to always complete execution or produce a useful output. Optionals are used to represent the absence of a value, but when an operation fails, it’s often useful to understand what caused the failure, so that your code can respond accordingly.
        // As an example, consider the task of reading and processing data from a file on disk. There are a number of ways this task can fail, including the <<file not existing>> at the specified path, the file <<not having read permissions>>, or the file <<not being encoded in a compatible format>>. Distinguishing among these different situations allows a program to resolve some errors and to communicate to the user any errors it can’t resolve.
        
        // (1) Representing and Throwing Errors
        // In Swift, errors are represented by values of types that conform to the Error protocol. This empty protocol indicates that a type can be used for error handling.
        /*
         enum SomeError: Error {
             case ErrorA
             case ErrorB
         }
         */
        // Throwing an error lets you indicate that something unexpected happened and the normal flow of execution can’t continue. You use a throw statement to throw an error.
        /*
         throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
         */
        
        // (2) Handling Errors
        // >>1 do try catch
        do {
            try self.canThrowErrors()
        }catch VendingMachineError.insufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        }catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        }catch VendingMachineError.outOfStock {
            print("Out of Stock.")
        }catch {
            
        }
        
        do {
            try self.canThrowErrors()
        }catch {
            switch error {
            case VendingMachineError.insufficientFunds(let coinsNeeded):
                print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
            case VendingMachineError.invalidSelection:
                print("Invalid Selection.")
            case VendingMachineError.outOfStock:
                print("Out of Stock.")
            default:
                print("Other Error.")
            }
        }
        // >>2 Converting Errors to Optional Values
        // result is type of "Int?"
        let result = try? self.anotherThrowsFunc()
        print("result = \(result ?? -99)")
        
        let sameAsResult: Int?
        do {
            sameAsResult = try anotherThrowsFunc()
        }catch {
            sameAsResult = nil
        }
        print("sameAsResult = \(sameAsResult ?? -99)")
        
        // >>3 Disabling Error Propagation
        // Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime. On those occasions, you can write try! before the expression to disable error propagation and wrap the call in a runtime assertion that no error will be thrown. If an error actually is thrown, you’ll get a runtime error.
        let _ = try! noErrorThrowsFunc()
        
        // (3) Specifying Cleanup Actions
        //  This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block of code—whether it leaves because an error was thrown or because of a statement such as return or break.
        defer {
            print("End of Chapter 18.")
        }
        print("Hello, Defer.")
    }
    
    static func canThrowErrors() throws {
        throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
    }
    
    static func anotherThrowsFunc() throws -> Int {
        if arc4random() % 2 == 0 {
            throw VendingMachineError.invalidSelection
        }else {
            return 11
        }
    }
    
    static func noErrorThrowsFunc() throws {
        print("I never throw an error.")
    }
}

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
