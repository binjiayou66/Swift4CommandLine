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
        
        
        // (6) Failable Initializers
        // (7) Required Initializers
        // (8) Setting a Default Property Value with a Closure or Function
    }
}



