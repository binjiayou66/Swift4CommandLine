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













