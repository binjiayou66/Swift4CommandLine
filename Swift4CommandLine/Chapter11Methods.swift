//
//  Chapter11Methods.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/14.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter11Methods: NSObject {
    static public func run() {
        // Methods
        // 1. Instance Methods
        // 2. Type Methods
        
        // Methods
        // Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define type methods, which are associated with the type itself.
        
        // Instance Methods
        // Instance methods are functions that belong to instances of a particular class, structure, or enumeration. They support the functionality of those instances, either by providing ways to <<access and modify instance properties>>, or by providing <<functionality related to the instance’s purpose>>.
        // An instance method has implicit access to all other instance methods and properties of that type.
        let counter = Counter()
        counter.increment()
        print("counter.count = \(counter.count)")
        counter.increment(by: 99)
        print("counter.count = \(counter.count)")
        counter.reset()
        print("counter.count = \(counter.count)")
        
        // Even though properties of PointMethod are variable, when you create a constant instance of PointMethod, you can not change its properties.
        // let point = PointMethod.init(x: 10.0, y: 10.0)
        var point = PointMethod.init(x: 10.0, y: 10.0)
        point.moveBy(x: 6.0, y: 6.0)
        print("point = (\(point.x), \(point.y))")
        
        var blackWhite = BlackOrWhite.black
        print("blackWhite = \(blackWhite)")
        blackWhite.selfSwitch()
        print("blackWhite = \(blackWhite)")
        // Mutating method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.
        
        // Type Methods
        // Instance methods, as described above, are methods that are called on an instance of a particular type. You can also define methods that are called on the type itself. These kinds of methods are called type methods. You indicate type methods by writing the static keyword before the method’s func keyword. Classes may also use the class keyword to allow subclasses to override the superclass’s implementation of that method.
        // Within the body of a type method, the implicit self property refers to the type itself, rather than an instance of that type.
        let player = Player(name: "Lee")
        player.complete(level: 1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
        if player.tracker.advance(level: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
    }
}

// Instance Methods
class Counter {
    var count = 0
    func increment() {
        // Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.
        self.count += 1
    }
    func increment(by amount: Int) {
        // In practice, you don’t need to write self in your code very often. If you don’t explicitly write self, Swift assumes that you are referring to a property or method of the current instance.
        count += amount
    }
    func reset(by count: Int = 0) {
        // When a parameter name for an instance method has the same name as a property of that instance, you should use the self property to distinguish between the parameter name and the property name.
        self.count = count
    }
}

// Value Types
struct PointMethod {
    var x = 0.0, y = 0.0
    // Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods.
    // If we don't place mutating keyword before the func keyword, the error below will show:
    // Left side of mutating operator isn't mutable: 'self' is immutable
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

enum BlackOrWhite {
    case black, white
    // You can also modify the value of self in mutating functions
    mutating func selfSwitch() {
        switch self {
        case .black:
            self = .white
        case .white:
            self = .black
        }
    }
}

// Type Methods
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(level: Int) {
        highestUnlockedLevel = level > highestUnlockedLevel ? level : highestUnlockedLevel
    }
    
    static func isUnclocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(level: Int) -> Bool {
        if LevelTracker.isUnclocked(level: level) {
            currentLevel = level
            return true
        }else {
            return false
        }
    }
}

class Player {
    // Properties in a type have three states:
    // (1) Declare a property and initialize it
    // (2) Declare a property and initialize it in init function
    // (3) Declare a optional property
    let name: String
    var tracker = LevelTracker()
    
    init(name: String) {
        self.name = name
    }
    
    func complete(level: Int) {
        LevelTracker.unlock(level: level + 1)
        tracker.advance(level: level + 1)
    }
}

