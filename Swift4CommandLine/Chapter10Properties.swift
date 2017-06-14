//
//  Chapter10Properties.swift
//  Swift4CommandLine
//
//  Created by 123 on 2017/6/14.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter10Properties: NSObject {
    static public func run() {
        // Properties
        // (1) Stored Properties
        // (2) Lazy Stored Properties
        // (3) Computed Properties
        // (4) Read-Only Computed Properties
        // (5) Property Observers
        // (6) Global and Local Variables
        // (7) Type Properties
        
        // Stored Properties
        struct FixedLengthRange {
            var firstValue: Int
            let length: Int
        }
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        rangeOfThreeItems.firstValue = 6
        
        // Lazy Stored Properties
        // A lazy stored property is a property whose initial value is not calculated until the first time it is used. You indicate a lazy stored property by writing the lazy modifier before its declaration.
        // Lazy properties are useful when the initial value for a property is dependent on outside factors whose values are not known until after an instance’s initialization is complete. Lazy properties are also useful when the initial value for a property requires complex or computationally expensive setup that should not be performed unless or until it is needed.
        let manager = DataManager()
        print("DataManager created an instance.")
        manager.data.append("Some data")
        manager.data.append("Some more data")
        // Because it is marked with the lazy modifier, the DataImporter instance for the importer property is only created when the importer property is first accessed
        print(manager.importer.fileName)
        
        // Stored Properties and Instance Variables
        // If you have experience with Objective-C, you may know that it provides two ways to store values and references as part of a class instance. In addition to properties, you can use instance variables as a backing store for the values stored in a property.
        // Swift unifies these concepts into a single property declaration. A Swift property does not have a corresponding instance variable, and the backing store for a property is not accessed directly. This approach avoids confusion about how the value is accessed in different contexts and simplifies the property’s declaration into a single, definitive statement. All information about the property—including its name, type, and memory management characteristics—is defined in a single location as part of the type’s definition.
        
        // Computed Properties
        // In addition to stored properties, classes, structures, and enumerations can define computed properties, which <<do not actually store a value>>. Instead, they provide <<a getter and an optional setter>> to <<retrieve and set other properties>> and values <<indirectly>>.
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        print("square.center is now at (\(square.center.x), \(square.center.y))")
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        
        // Property Observers
        // Property observers <<observe and respond>> to changes in a property’s value. Property observers are called <<every time a property’s value is set>>, even if the new value is the same as the property’s current value.
        // You can add property observers to any stored properties you define, except for lazy stored properties. You can also add property observers to any inherited property (whether stored or computed) by overriding the property within a subclass. You don’t need to define property observers for nonoverridden computed properties, because you can observe and respond to changes to their value in the computed property’s setter.
        let counter = StepCounter()
        counter.totalSteps = 100
        counter.totalSteps = 160
        counter.totalSteps = 160
        
        // Global and Local Variables
        // The capabilities described above for computing and observing properties are also available to global variables and local variables. Global variables are variables that are defined outside of any function, method, closure, or type context. Local variables are variables that are defined within a function, method, or closure context.
        func localComputedVariable() {
            var local: Int {
                get {
                    print("localComputedVariable")
                    return 19
                }
                set {
                    print("new value = \(newValue)")
                }
            }
            
            local = 1000
            print("local = \(local)")
        }
        localComputedVariable()
        // Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables do not need to be marked with the lazy modifier.
        // Local constants and variables are never computed lazily.
        
        // Type Properties
        // Instance properties are properties that belong to an instance of a particular type. Every time you create a new instance of that type, it has its own set of property values, separate from any other instance.
        // You can also define properties that belong to the type itself, not to any one instance of that type. There will only ever be one copy of these properties, no matter how many instances of that type you create. These kinds of properties are called type properties.
        // Type properties are useful for defining values that are universal to all instances of a particular type, such as a constant property that all instances can use (like a static constant in C), or a variable property that stores a value that is global to all instances of that type (like a static variable in C).
        // Stored type properties can be variables or constants. Computed type properties are always declared as variable properties, in the same way as computed instance properties.
        // Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself does not have an initializer that can assign a value to a stored type property at initialization time.
        // Stored type properties are lazily initialized on their first access. They are guaranteed to be initialized only once, even when accessed by multiple threads simultaneously, and they do not need to be marked with the lazy modifier.
        print(SomeStructure.storedTypeProperty)
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        print(SomeEnumeration.computedTypeProperty)
        SomeClass.computedTypeProperty = 111
        print(SomeClass.computedTypeProperty)
    }
}

// Lazy Properties Case
class DataImporter {
    var fileName = "data.txt"
    init() {
        print("DataImporter is creating an instance.")
    }
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    init() {
        print("DataManager is creating an instance.")
    }
}

// Computed Properties Case
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        // getter
        get {
            return Point.init(x: origin.x + size.width / 2, y: origin.y + size.height / 2)
        }
        // setter
        // set(newCenter) {
        //     origin.x = newCenter.x - (size.width / 2)
        //     origin.y = newCenter.y - (size.height / 2)
        // }
        // or setter
        // If a computed property’s setter does not define a name for the new value to be set, a default name of newValue is used.
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// Read-Only Computed Properties
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

// Property Observers
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            // newTotalSteps or default newValue
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            // oldValue
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

// Type Properties
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        get {
            return 27
        }
        set {
            print("newValue = \(newValue)")
        }
    }
    // For computed type properties for class types, you can use the class keyword instead to allow subclasses to override the superclass’s implementation.
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
