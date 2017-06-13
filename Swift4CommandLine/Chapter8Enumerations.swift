//
//  Chapter8Enumerations.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/13.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter8Enumerations: NSObject {
    static public func run() {
        // Enumerations
        // An enumeration defines <<a common type>> for a group of <<related values>> and enables you to work with those values in a <<type-safe>> way within your code.
        
        // Enumerations in Swift are first-class types in their own right. They adopt many features traditionally supported only by classes, such as:
        // (1) Computed properties to provide additional information about the enumeration’s current value
        // (2) Instance methods to provide functionality related to the values the enumeration represents.
        // (3) Define initializers to provide an initial case value
        // (4) Be extended to expand their functionality beyond their original implementation
        // (5) Conform to protocols to provide standard functionality
        
        // Enumeration Syntax
        enum CompassPoint {
            case north
            case south
            case east
            case west
        }
        // Unlike C and Objective-C, Swift enumeration cases are not assigned a default integer value when they are created. In the CompassPoint example above, north, south, east and west do not implicitly equal 0, 1, 2 and 3. Instead, the different enumeration cases are fully-fledged values in their own right, with an explicitly-defined type of CompassPoint.
        
        // Multiple cases can appear on a single line, separated by commas:
        enum Planet {
            case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        // Each enumeration definition defines a brand new type, like other types in Swift.
        
        var directionToHead = CompassPoint.west
        // The type of directionToHead is inferred when it is initialized with one of the possible values of CompassPoint. Once directionToHead is declared as a CompassPoint, you can set it to a different CompassPoint value using a shorter dot syntax:
        directionToHead = .east
        // let directionToTail: CompassPoint = .north
        switch directionToHead {
        case .north:
            print("Lots of planets have a north")
        case .south:
            print("Watch out for penguins")
        case .east:
            print("Where the sun rises")
        case .west:
            print("Where the skies are blue")
        }
        
        // Associated Values
        // You can define Swift enumerations to store associated values of any given type, and the value types can be different for each case of the enumeration if needed.
        // Demo with upc, 1D barcodes; QR code, 2D barcodes
        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrcode(String)
        }
        // This can be read as:
        // “Define an enumeration type called Barcode, which can take either a value of upc with an associated value of type (Int, Int, Int, Int), or a value of qrCode with an associated value of type String.”
        // This definition <<does not provide any actual Int or String values>>—it just <<defines the type of associated values>> that Barcode constants and variables can store when they are equal to Barcode.upc or Barcode.qrCode.
        
        // Usage
        var productBarcode = Barcode.upc(8, 100, 4111, 5)
        productBarcode = .qrcode("ABCDEFG")
        // Matching enumeration values
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrcode(let productCode):
            print("QR code: \(productCode).")
        }
        // or
        switch productBarcode {
        case let .upc(numberSystem, manufacturer, product, check):
            print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .qrcode(productCode):
            print("QR code: \(productCode).")
        }
        
        // Raw Values
        // The barcode example in Associated Values shows how cases of an enumeration can declare that they store associated values of different types. As an alternative to associated values, enumeration cases can come prepopulated with default values (called raw values), which are all of the same type.
        // Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is <<always the same>>. Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so.
        enum ASCIIControlCharacter: Character {
            case tab = "\t"
            case lineFeed = "\n"
            case carriageReturn = "\r"
        }
        print("tab = \(ASCIIControlCharacter.lineFeed.rawValue)")
        
        enum PlanetInt: Int {
            case mercury = 2, venus = 7, earth, mars, jupiter, saturn, uranus, neptune
        }
        // If the first case doesn’t have a value set, its value is 0.
        print("venus = \(PlanetInt.mars.rawValue)")
        
        enum CompassPointString: String {
            case north, south = "Hello South", east, west
        }
        print("south = \(CompassPointString.south.rawValue)")
        
        // Initializing from a Raw Value
        // The raw value initializer is a failable initializer, because not every raw value will return an enumeration case.
        // If you try to find a planet with a position of 99, the optional Planet value returned by the raw value initializer will be nil:
        let possiblePlanet = PlanetInt.init(rawValue: 7)
        let positionToFind = 99
        if let somePlanet = PlanetInt.init(rawValue: positionToFind) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            case .mars:
                print("You are brave.")
            default:
                print("Other planet.")
            }
        }else {
            print("There is not a planet at position \(positionToFind)")
        }
        
        // Recursive Enumerations
        enum ArithmeticExpression {
            case number(Int)
            indirect case addition(ArithmeticExpression, ArithmeticExpression)
            indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        // or
        indirect enum ArithmeticExpression2 {
            case number(Int)
            case addition(ArithmeticExpression, ArithmeticExpression)
            case multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        
        print("product = \(product)")
        
        func evaluate(_ expression: ArithmeticExpression) -> Int {
            switch expression {
            case .number(let value):
                return value
            case .addition(let left, let right):
                return evaluate(left) + evaluate(right)
            case .multiplication(let left, let right):
                return evaluate(left) * evaluate(right)
            }
        }
        
        let result = evaluate(product)
        
        print("result = \(result)")
    }
}
