//
//  Chapter14Initialization.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/16.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter14Initialization: NSObject {
    static public func run() {
        // Initialization
        // (1) Setting Initial Values for Stored Properties
        // (2) Customizing Initialization
        // (3) Default Initializers
        // (4) Initializer Delegation for Value Types
        // (5) Class Inheritance and Initialization
        // (6) Failable Initializers
        // (7) Required Initializers
        // (8) Setting a Default Property Value with a Closure or Function
        
        // Initialization
        // Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.
        
        // (1) Setting Initial Values for Stored Properties
        // Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state.
        struct Fahrenheit {
            var temperature: Double
            init() {
                temperature = 32.0
            }
        }
        var f = Fahrenheit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
        
        // Preferred
        struct FahrenheitPreferred {
            var temperature = 32.0
            init() {
                
            }
        }
        
        // (2) Customizing Initialization
        struct Celsius {
            var temperatureInCelsius: Double
            init(fromFahrenheit fahrenheit: Double) {
                temperatureInCelsius = (fahrenheit - 32.0) / 1.8
            }
            init(fromKelvin kelvin: Double) {
                temperatureInCelsius = kelvin - 273.15
            }
        }
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        // boilingPointOfWater.temperatureInCelsius is 100.0
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        // freezingPointOfWater.temperatureInCelsius is 0.0
        
        // Optional Property Types
        class SurveyQuestion {
            // Use a constant property rather than a variable property for the text property of the question, to indicate that the question does not change once an instance of SurveyQuestion is created.
            // Even though the text property is now a constant, it can still be set within the class’s initializer
            let text: String
            // The response property is an optional String property, and so it automatically receives a default value of nil
            var response: String?
            init(text: String) {
                self.text = text
            }
            func ask() {
                print(text)
            }
        }
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        // Prints "Do you like cheese?"
        cheeseQuestion.response = "Yes, I do like cheese."
        // The response to a survey question cannot be known until it is asked, and so the response property is declared with a type of String?, or “optional String”.
        
        // (3) Default Initializers
        class ShoppingListItem {
            var name: String?
            var quantity = 1
            var purchased = false
        }
        var item = ShoppingListItem()
        // Memberwise Initializers for Structure Types
        struct Size {
            var width = 0.0, height = 0.0
        }
        let twoByTwo = Size(width: 2.0, height: 2.0)
        
        // (4) Initializer Delegation for Value Types
        struct Rect {
            var origin = Point()
            var size = Size()
            init() {}
            init(origin: Point, size: Size) {
                self.origin = origin
                self.size = size
            }
            init(center: Point, size: Size) {
                let originX = center.x - (size.width / 2)
                let originY = center.y - (size.height / 2)
                self.init(origin: Point(x: originX, y: originY), size: size)
            }
        }
        let _ = Rect()
        let _ = Rect(center: Point(x: 10, y: 10), size: Size(width: 10, height: 10))
        let _ = Rect(origin: Point(x: 10, y: 10), size: Size(width: 10, height: 10))
        
        // (5) Class Inheritance and Initialization
        // Designated Initializers and Convenience Initializers
        /*
         Syntax for Designated and Convenience Initializers
         init(parameters) {
         statements
         }
         
         convenience init(parameters) {
         statements
         }
         */
        // Designated initializers must always delegate up.
        // Convenience initializers must always delegate across.
        
        /*
         --------------------- Superclass --------------------
         |                                                    |
         |    Designated <-- Convenience <-- convenience      |
         |       ^      <--                                    |
         -------|--------|------------------------------------
         |        |
         -------|--------|----- Subclass ---------------------
         |       |        |                                    |
         |    Designated  Designated <-- convenience             |
         |                                                    |
         -----------------------------------------------------
         */
        
        // Two-Phase Initialization
        /*
         Here’s how two-phase initialization plays out, based on the four safety checks above:
         
         Phase 1 Safety Check (https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/twoPhaseInitialization01_2x.png)
         (1) A designated or convenience initializer is called on a class.
         (2) Memory for a new instance of that class is allocated. The memory is not yet initialized.
         (3) A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
         (4) The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
         (5) Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
         
         Phase 2 Customize (https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/twoPhaseInitialization02_2x.png)
         (1) Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
         (2) Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.
         */
        
        // Automatic Initializer Inheritance
        /*
         Rule 1
         If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
         
         Rule 2
         If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.
         */
        
        // Designated and Convenience Initializers in Action
        // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializersExample03_2x.png
        var breakfastList = [
            ShoppingListItemNew(),
            ShoppingListItemNew(name: "Bacon"),
            ShoppingListItemNew(name: "Eggs", quantity: 6),
            ]
        breakfastList[0].name = "Orange juice"
        breakfastList[0].purchased = true
        for item in breakfastList {
            print(item.description)
        }
        
        // (6) Failable Initializers
        // To cope with initialization conditions that can fail, define one or more failable initializers as part of a class, structure, or enumeration definition. You write a failable initializer by placing a question mark after the init keyword (init?). You cannot define a failable and a nonfailable initializer with the same parameter types and names.
        // A failable initializer creates an optional value of the type it initializes. You write return nil within a failable initializer to indicate a point at which initialization failure can be triggered.
        // Strictly speaking, initializers do not return a value. Rather, their role is to ensure that self is fully and correctly initialized by the time that initialization ends. Although you write return nil to trigger an initialization failure, you do not use the return keyword to indicate initialization success.
        struct Animal {
            let species: String
            init?(species: String) {
                if species.isEmpty { return nil }
                self.species = species
            }
        }
        // someCreature is of type Animal?, not Animal
        let someCreature = Animal(species: "Giraffe")
        
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }
        
        // Failable Initializers for Enumerations
        enum TemperatureUnit {
            case kelvin, celsius, fahrenheit
            init?(symbol: Character) {
                switch symbol {
                case "K":
                    self = .kelvin
                case "C":
                    self = .celsius
                case "F":
                    self = .fahrenheit
                default:
                    return nil
                }
            }
        }
        // Failable Initializers for Enumerations with Raw Values
        enum TemperatureUnitNew: Character {
            case kelvin = "K", celsius = "C", fahrenheit = "F"
        }
        let fahrenheitUnit = TemperatureUnitNew(rawValue: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        
        // Propagation of Initialization Failure
        let cartItem1 = CartItem(name: "", quantity: 0)
        if let _ = cartItem1 {
            print("Initialize success. cartItem1")
        }
        let cartItem2 = CartItem(name: "ABC", quantity: 0)
        if let _ = cartItem2 {
            print("Initialize success. cartItem2")
        }
        let cartItem3 = CartItem(name: "ABC", quantity: 10)
        if let _ = cartItem3 {
            print("Initialize success. cartItem3")
        }
        
        // Overriding a Failable Initializer
        // class Document, AutomaticallyNamedDocument, UntitledDocument
        
        // (7) Required Initializers
        // Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:
        /*
         class SomeClass {
         required init() {
         // initializer implementation goes here
         }
         }
         // You must also write the required modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain. You do not write the override modifier when overriding a required designated initializer:
         class SomeSubclass: SomeClass {
         required init() {
         // subclass implementation of the required initializer goes here
         super.init()
         }
         }
         // You do not have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer.
         */
        
        // (8) Setting a Default Property Value with a Closure or Function
        // Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.
        /*
        class SomeClass {
            let someProperty: SomeType = {
                // create a default value for someProperty inside this closure
                // someValue must be of the same type as SomeType
                return someValue
            }()
        }
        */
        // Game board (https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/chessBoard_2x.png)
        struct Chessboard {
            let boardColors: [Bool] = {
                var temporaryBoard = [Bool]()
                var isBlack = false
                for i in 1...8 {
                    for j in 1...8 {
                        temporaryBoard.append(isBlack)
                        isBlack = !isBlack
                    }
                    isBlack = !isBlack
                }
                return temporaryBoard
            }()
            func squareIsBlackAt(row: Int, column: Int) -> Bool {
                return boardColors[(row * 8) + column]
            }
        }
        let board = Chessboard()
        print(board.squareIsBlackAt(row: 0, column: 1))
        
        // If you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit self property, or call any of the instance’s methods.
    }
}

// Designated Initializers and Convenience Initializers
class TestA {
    var pro1 = 0
    var pro2: String?
    var pro3: Int
    
    init(pro3: Int) {
        self.pro3 = pro3
    }
    
    init(pro3: Int, pro2: String) {
        self.pro3 = pro3
        self.pro2 = pro2
    }
    
    convenience init(pro2: String) {
        // You can code like this without any compile error. But it will cause circular call at running time.
        // self.init()
        
        self.init(pro3: 10)
        
        self.pro1 = 11
    }
}

class TestB: TestA {
    var pro4 = true
    var pro5: Double
    
    init(pro5: Double) {
        // Subclass properties that waiting for initialization must be initialized before the Superclass is initialized
        self.pro5 = pro5
        // Attributes inherited from the Superclass must be used after the initialization of the Superclass
        // Compile Error: Use of 'Self' in property access 'pro3' before super.init initializes self
        // self.pro3 = 11
        super.init(pro3: 10)
        
        // Valid
        // self.pro3 = 11
    }
    
    // You must write the override modifier before the subclass’s initializer definition.
    override init(pro3: Int) {
        self.pro5 = 0.0
        
        super.init(pro3: pro3)
    }
    
    // Superclass convenience initializer can never be called directly by your subclass. Therefore, your subclass is not providing an override of the superclass initializer.
    // Invalid: Initializer does not override a designated initializer from its superclass
    // override init(pro2: String) { }
    
    // A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.
    convenience override init(pro3: Int, pro2: String) {
        self.init(pro5: 10.0)
    }
}

// Designated and Convenience Initializers in Action
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItemNew: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

// Propagation of Initialization Failure
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

// Overriding a Failable Initializer
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
// The AutomaticallyNamedDocument overrides its superclass’s failable init?(name:) initializer with a nonfailable init(name:) initializer. Because AutomaticallyNamedDocument copes with the empty string case in a different way than its superclass, its initializer does not need to fail, and so it provides a nonfailable version of the initializer instead.
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
// In this case, if the init(name:) initializer of the superclass were ever called with an empty string as the name, the forced unwrapping operation would result in a runtime error. However, because it’s called with a string constant, you can see that the initializer won’t fail, so no runtime error can occur in this case.
class UntitledDocument: Document {
    override init() {
        // Forced unwrapping
        super.init(name: "[Untitled]")!
    }
}

// Required Initializers
// Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer
// In practice, required keyword only effects default init() function.
class TestC {
    var name: String
    //    required init() {
    //        self.name = ""
    //    }
    required init(name: String) {
        self.name = name
    }
}

class TestD: TestC {
    //    required init() {
    //        super.init()
    //    }
    required init(name: String) {
        super.init(name: name)
    }
}
