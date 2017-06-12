//
//  Chapter5ControlFlow.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/12.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter5ControlFlow: NSObject {
    static public func run() {
        // For-In Loops
        // Arrays
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names {
            print("Hello, \(name)!")
        }
        // Dictionaries
        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animalName, legCount) in numberOfLegs {
            print("\(animalName)s have \(legCount) legs")
        }
        // Range
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        // Ignore index
        for _ in 1..<6 {
            print("Hello.")
        }
        // Custom Interval
        for second in stride(from: 0, to: 20, by: 5) {
            print("second: \(second)")
        }
        
        // While Loops
        var today = 1
        while today < 7 {
            print("Today is \(today)th day in a week.")
            today += 1
        }
        print("Finish. Today = \(today)")
        // Repeat-While Loops perform a single pass through the loop block first, before considering the loop’s condition.
        today = 8
        repeat {
            print("Today is \(today)th day in a week.")
            today += 1
        } while today < 7
        print("Finish. Today = \(today)")
        
        // Conditional Statements
        // If
        /*
        if conditionA {
            print("agree with conditionA.")
        }else if conditionB {
            print("agree with conditionB.")
        }else {
            print("neither agree with conditionA nor conditionB.")
        }
         */
        
        // Switch
        /*
         switch some value to consider {
         case value 1:
             respond to value 1
         case value 2, value 3:
             respond to value 2 or 3
         default:
             otherwise, do something else
         }
         */
        let someCharacter: Character = "z"
        switch someCharacter {
        case "a":
            print("The first letter of the alphabet")
        case "z":
            print("The last letter of the alphabet")
        default:
            print("Some other character")
        }
        
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        // Interval Matching
        let approximateCount = 4
        let naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) moons orbiting Saturn.")
        // Tuples Matching
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("\(somePoint) is at the origin")
        case (_, 0):
            print("\(somePoint) is on the x-axis")
        case (0, _):
            print("\(somePoint) is on the y-axis")
        case (-2...2, -2...2):
            print("\(somePoint) is inside the box")
        default:
            print("\(somePoint) is outside of the box")
        }
        // Value Bindings
        // The values are bound to temporary constants or variables within the case’s body.
        // If you modify the temporary values will not affect origin values.
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (var x, 0):
            x = 999
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        print("\(anotherPoint)")
        // Where
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        
        // Control Transfer Statements
        /* Control transfer statements change the order in which your code is executed, by transferring control from one piece of code to another. Swift has five control transfer statements:
         
             continue
             break
             fallthrough
             return
             throw
         */
        // continue and break usage is the same as C
        // In Swift, switch statements don’t fall through the bottom of each case and into the next one. That is, the entire switch statement completes its execution as soon as the first matching case is completed. If you need C-style fallthrough behavior, you can opt in to this behavior on a case-by-case basis with the fallthrough keyword.
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough
        default:
            description += " an integer."
        }
        print(description)
        // Labeled Statements
        // If you have multiple nested loops, Labeled Statements can be useful to be explicit about which loop the continue statement should affect.
        var loopNum1 = 0
        var loopNum2 = 0
        while loopNum1 < 100 {
            for _ in 0..<50 {
                loopNum1 += 1
                loopNum2 += 2
                if loopNum1 == 60 {
                    break
                }
            }
        }
        print("loopNum1 = \(loopNum1), loopNum2 = \(loopNum2)")
        
        var loopNum3 = 0
        var loopNum4 = 0
        whileLabel: while loopNum3 < 100 {
            for _ in 0..<50 {
                loopNum3 += 1
                loopNum4 += 2
                if loopNum3 == 60 {
                    break whileLabel
                }
            }
        }
        print("loopNum3 = \(loopNum3), loopNum4 = \(loopNum4)")
        
        // Checking API Availability
        /*
         if #available(platform name version, ..., *) {
             statements to execute if the APIs are available
         } else {
             fallback statements to execute if the APIs are unavailable
         }
         */
        if #available(iOS 10, macOS 10.12, *) {
            // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
        } else {
            // Fall back to earlier iOS and macOS APIs
        }
    }
}
