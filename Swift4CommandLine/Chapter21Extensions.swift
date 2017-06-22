//
//  Chapter21Extensions.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/16.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter21Extensions: NSObject {
    static public func run() {
        // Extensions
        // (1) Extension Syntax
        // (2) Computed Properties
        // (3) Initializers
        // (4) Methods
        // (5) Subscripts
        // (6) Nested Types
        
        // Extensions
        // Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as retroactive modeling). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)
        // Extensions in Swift can:
        // >>1 Add computed instance properties and computed type properties
        // >>2 Define instance methods and type methods
        // >>3 Provide new initializers
        // >>4 Define subscripts
        // >>5 Define and use new nested types
        // >>6 Make an existing type conform to a protocol
        // Note Properties: Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties.
        // Note Initializer: Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.
        // Note Function: Extensions can add new functionality to a type, but they cannot override existing functionality.
        
        // (1) Extension Syntax
        /*
         extension SomeType {
            
         }
         extension SomeType: SomeProtocol, AnotherProtocol {
         
         }
        */
        // Adding protocol conformance in this way is described in Adding Protocol Conformance with an Extension.
        // An extension can be used to extend an existing generic type, as described in Extending a Generic Type. You can also extend a generic type to conditionally add functionality, as described in Extensions with a Generic Where Clause.
        
        // (2) Computed Properties
        let aMarathon = 42.km + 195.m
        print("A marathon is \(aMarathon) meters long")
        
        // (3) Initializers
        let rect = RectCp21(center: PointCp21(x: 10, y: 10), size: SizeCp21(width: 10, height: 10))
        print(rect.description)
        
        // (4) Methods
        3.repetitions {
            print("Hello, Extension.")
        }
        var threeSquare = 3
        threeSquare.square()
        print("square 3 is \(threeSquare)")
        
        // (5) Subscripts
        let number1 = 9876543210[11]
        print("number1 = \(number1 ?? -99)")
        
        // (6) Nested Types
        // Extensions can add new nested types to existing classes, structures, and enumerations.
        let number2 = -3
        print(number2.kind)
        
        func printIntegerKinds(_ numbers: [Int]) {
            for number in numbers {
                switch number.kind {
                case .negative:
                    print("- ", terminator: "")
                case .zero:
                    print("0 ", terminator: "")
                case .positive:
                    print("+ ", terminator: "")
                }
            }
            print("")
        }
        printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
        
        print("End of Chapter 21.")
    }
}

// (2) Computed Properties
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
}

// (3) Initializers
struct PointCp21 {
    var x: Double, y: Double
}

struct SizeCp21 {
    var width = 0.0, height = 0.0
}

struct RectCp21 {
    var origin: PointCp21
    var size: SizeCp21
    var description: String {
        return "origin: (\(origin.x), \(origin.y), size: (\(size.width), \(size.height))"
    }
}

extension RectCp21 {
    init(center: PointCp21, size: SizeCp21) {
        self.origin = PointCp21(x: center.x - size.width / 2, y: center.y - size.height / 2)
        self.size = size
    }
}

// Class Type,
class RectCp21Class {
    var origin: PointCp21
    var size: SizeCp21
    var description: String {
        return "origin: (\(origin.x), \(origin.y), size: (\(size.width), \(size.height))"
    }
    init(origin: PointCp21, size: SizeCp21) {
        self.origin = origin
        self.size = size
    }
}

extension RectCp21Class {
    // Designated initializer cannot be declared in an extension of 'RectCp21Class'; did you mean this to be a convenience initializer?
    /*
    init(center: PointCp21, size: SizeCp21) {
        self.origin = PointCp21(x: center.x - size.width / 2, y: center.y - size.height / 2)
        self.size = size
    }
     */
    
    // Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.
    convenience init(center: PointCp21, size: SizeCp21) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: PointCp21(x: originX, y: originY), size: size)
    }
}

// (4) Methods
extension Int {
    func repetitions(task: () -> Void) {
        // There should not have space before "self"
        for _ in 0..<self {
            task()
        }
    }
    mutating func square() {
        self *= self
    }
}

// (5) Subscript
extension Int {
    subscript(index: Int) -> Int? {
        var base = 1
        for _ in 0..<index {
            base *= 10
        }
        if Double(self) / Double(base) < 1 {
            return nil
        }else {
            return (self / base) % 10
        }
    }
}

// (6) Nested Types
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x < 0:
            return .negative
        default:
            return .positive
        }
    }
}
