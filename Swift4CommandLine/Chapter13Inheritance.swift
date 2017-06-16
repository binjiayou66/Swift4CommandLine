//
//  Chapter13Inheritance.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/15.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter13Inheritance: NSObject {
    static public func run() {
        // Inheritance
        // (1) Defining a Base Class
        // (2) Subclassing
        // (3) Overriding
        // (4) Preventing Overrides
        
        // Inheritance
        // A class can inherit methods, properties, and other characteristics from another class. When one class inherits from another, the inheriting class is known as a subclass, and the class it inherits from is known as its superclass. Inheritance is a fundamental behavior that differentiates classes from other types in Swift.
        // Classes in Swift can call and access methods, properties, and subscripts belonging to their superclass and can provide their own overriding versions of those methods, properties, and subscripts to refine or modify their behavior.
        
        // Defining a Base Class
        // Any class that does not inherit from another class is known as a base class.
        let vehicle = Vehicle()
        vehicle.currentSpeed = 70
        print(vehicle.description)
        
        // Subclassing
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 16
        print(bicycle.description)
        
        // Overriding
        // A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.
        let car = Car()
        car.gear = 3
        print(car.description)
        
        // Overriding Property Observers
        let autoCar = AutomaticCar()
        autoCar.currentSpeed = 100
        print(autoCar.description)
        
        // Preventing Overrides
        // <<final>> keyword
        // You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript).
        // Any attempt to override a final method, property, or subscript in a subclass is reported as a compile-time error. Methods, properties, or subscripts that you add to a class in an extension can also be marked as final within the extension’s definition.
        // You can mark an entire class as final by writing the final modifier before the class keyword in its class definition (final class). Any attempt to subclass a final class is reported as a compile-time error.
    }
}

// Defining a Base Class
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        print("Wong, Wong...")
    }
}

// Subclasses
class Bicycle: Vehicle {
    var hasBasket = false
}

// Override and Super keyword
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

// Overriding Property Observers
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}


