//
//  Chapter9ClassesAndStructures.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/13.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter9ClassesAndStructures: NSObject {
    static public func run() {
        // Classes and Structures
        
        // Comparing Classes and Structures
        // Classes and structures in Swift have many things in common. Both can:
        // (1) Define properties to store values
        // (2) Define methods to provide functionality
        // (3) Define subscripts to provide access to their values using subscript syntax
        // (4) Define initializers to set up their initial state
        // (5) Be extended to expand their functionality beyond a default implementation
        // (6) Conform to protocols to provide standard functionality of a certain kind
        // For more information, see <<Properties>>, <<Methods>>, <<Subscripts>>, <<Initialization>>, <<Extensions>>, and <<Protocols>>.
        
        // Classes have additional capabilities that structures do not:
        // (1) Inheritance enables one class to inherit the characteristics of another.
        // (2) Type casting enables you to check and interpret the type of a class instance at runtime.
        // (3) Deinitializers enable an instance of a class to free up any resources it has assigned.
        // (4) Reference counting allows more than one reference to a class instance.
        // For more information, see <<Inheritance>>, <<Type Casting>>, <<Deinitialization>>, and <<Automatic Reference Counting>>.
        
        // Structures are always copied when they are passed around in your code, and do not use reference counting.
        
        // Structures and Enumerations Are Value Types
        
        // Classes Are Reference Types
        
        // Choosing Between Classes and Structures
        
        // Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
        
        // Create instances
        // Structures and classes both use initializer syntax for new instances.
        // * Structures is value type. If you create a constant structure, you can not change it's member value.
        // * Classes is reference type. You can modify it's properties, even though you use "let" to create an instance of this class.
        var aResolution = Resolution()
        let aVideoMode = VideoMode()
        // Accessing Properties
        aResolution.width = 100
        print("aResolution.width = \(aResolution.width)")
        aVideoMode.resolution = aResolution
        print("aVideoMode.resolution.width = \(aVideoMode.resolution.width)")
        
        // All structures have an automatically-generated memberwise initializer:
        let _ = Resolution.init(width: 100, height: 100)
        // Unlike structures, class instances do not receive a default memberwise initializer.
        
        // Structures and Enumerations Are Value Types
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd
        cinema.width = 2048
        print("cinema is now \(cinema.width) pixels wide")
        print("hd is still \(hd.width) pixels wide")
        // Classes Are Reference Types
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        print("The frameRate property of alsoTenEighty is now \(alsoTenEighty.frameRate)")
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
        
        // “Identical to” means that two constants or variables of class type refer to exactly the same class instance.
        // “Equal to” means that two instances are considered “equal” or “equivalent” in value, for some appropriate meaning of “equal”, as defined by the type’s designer.
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
        }
        
        // Pointers
        // If you have experience with C, C++, or Objective-C, you may know that these languages use pointers to refer to addresses in memory. A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C, but is not a direct pointer to an address in memory, and does not require you to write an asterisk (*) to indicate that you are creating a reference. Instead, these references are defined like any other constant or variable in Swift.
        
        
        // Choosing Between Classes and Structures
        // You can use both classes and structures to define custom data types to use as the building blocks of your program’s code. However, structure instances are always passed by value, and class instances are always passed by reference. This means that they are suited to different kinds of tasks. As you consider the data constructs and functionality that you need for a project, decide whether each data construct should be defined as a class or as a structure.
        
        // As a general guideline, consider creating a structure when one or more of these conditions apply:
        // (1) The structure’s primary purpose is to encapsulate a few relatively simple data values.
        // (2) It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
        // (3) Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
        // (4) The structure does not need to inherit properties or behavior from another existing type.
        
        // For examples, Size, Range, Point and so on.
        
        // In all other cases, define a class, and create instances of that class to be managed and passed by reference. In practice, this means that most custom data constructs should be classes, not structures.
    }
}

// Definition Syntax
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}













