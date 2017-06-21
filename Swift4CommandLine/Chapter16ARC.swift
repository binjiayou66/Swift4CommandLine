//
//  Chapter16ARC.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/16.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter16ARC: NSObject {
    static public func run() {
        // Automatic Reference Counting
        // (1) How ARC Works
        // (2) ARC in Action
        // (3) Strong Reference Cycles Between Class Instances
        // (4) Resolving Strong Reference Cycles Between Class Instances
        // (5) Strong Reference Cycles for Closures
        // (6) Resolving Strong Reference Cycles for Closures
        
        // Automatic Reference Counting
        // Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage.ARC automatically frees up the memory used by class instances when those instances are no longer needed.
        // Reference counting only applies to instances of classes. Structures and enumerations are value types, not reference types, and are not stored and passed by reference.
        /*
        let dog1 = DogCp16()
        var dog2: DogCp16? = dog1
        print("dog1 retain count = \(CFGetRetainCount(dog1))")
        */
        
        // (1) How ARC Works
        // ... ...
        
        // (2) ARC in Action
        var person1: PersonCp16? = PersonCp16(name: "Anny")
        var person2: PersonCp16? = person1
        person1 = nil
        person2 = nil
        // User broke point to show this example.
        
        // (3) Strong Reference Cycles Between Class Instances
        var person3: PersonCp16ReferenceCycle? = PersonCp16ReferenceCycle(name: "Person Cycle")
        var apartment1: ApartmentCp16ReferenceCycle? = ApartmentCp16ReferenceCycle(unit: "Apartment Cycle")
        person3?.apartment = apartment1
        apartment1?.tenant = person3
        
        person3 = nil
        apartment1 = nil
        
        // (4) Resolving Strong Reference Cycles Between Class Instances
        // >>1 Weak References
        // Weak references are used when two instances are all likely to be optional.
        var person4: PersonCp16WeakReference? = PersonCp16WeakReference(name: "Person Weak")
        var apartment2: ApartmentCp16WeakReference? = ApartmentCp16WeakReference(unit: "Apartment Weak")
        person4?.apartment = apartment2
        apartment2?.tenant = person4
        
        person4 = nil
        apartment2 = nil
        
        // >>2 Unowned References
        // An unowned reference is used when the other instance has the same lifetime or a longer lifetime.
        // An unowned reference is expected to always have a value. As a result, ARC never sets an unowned reference’s value to nil, which means that unowned references are defined using nonoptional types.
        var person5: CustomerCp16Unowned? = CustomerCp16Unowned(name: "Person Unowned")
        var creditCard1: CreditCardCp16Unowned? = CreditCardCp16Unowned(number: 12345678, owner: person5!)
        
        person5 = nil
        creditCard1 = nil
        
        // >>3 Unowned References and Implicitly Unwrapped Optional Properties
        // The examples for weak and unowned references above cover two of the more common scenarios in which it’s necessary to break a strong reference cycle.
        // The Person and Apartment example shows a situation where two properties, both of which are allowed to be nil, have the potential to cause a strong reference cycle. This scenario is best resolved with a weak reference.
        // The Customer and CreditCard example shows a situation where one property that is allowed to be nil and another property that cannot be nil have the potential to cause a strong reference cycle. This scenario is best resolved with an unowned reference.
        // However, there is a third scenario, in which both properties should always have a value, and neither property should ever be nil once initialization is complete. In this scenario, it’s useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.
        
        // The example below defines two classes, Country and City, each of which stores an instance of the other class as a property. In this data model, every country must always have a capital city, and every city must always belong to a country. To represent this, the Country class has a capitalCity property, and the City class has a country property:
        var country: CountryCp16? = CountryCp16(name: "Canada", capitalName: "Ottawa")
        print("\(country!.name)'s capital city is called \(country!.capitalCity.name)")
        country = nil
        
        // (5) Strong Reference Cycles for Closures
        var html1: HTMLElementCp16Cycle? = HTMLElementCp16Cycle(name: "div", text: "I am a div.")
        // If html1's asHTML closure is not be overwrited, html1 will never be dealloc. Because its default asHTML implement has the code "self.name" and so on. That's will take a strong reference to html1. Even though the closure refers to self multiple times, it only captures one strong reference to the HTMLElement instance.
        // html1?.asHTML = {
        //    return "<\(html1!.name)>\(html1?.text ?? "default text.")<\(html1!.name)>"
        // }
        print(html1!.asHTML())
        
        html1 = nil
        // (6) Resolving Strong Reference Cycles for Closures
        // You resolve a strong reference cycle between a closure and a class instance by defining a capture list as part of the closure’s definition. A capture list defines the rules to use when capturing one or more reference types within the closure’s body. As with strong reference cycles between two class instances, you declare each captured reference to be a weak or unowned reference rather than a strong reference. The appropriate choice of weak or unowned depends on the relationships between the different parts of your code.
        // Note: Swift requires you to write self.someProperty or self.someMethod() (rather than just someProperty or someMethod()) whenever you refer to a member of self within a closure. This helps you remember that it’s possible to capture self by accident.
        /*
         lazy var someClosure: () -> String = {
         [unowned self, weak delegate = self.delegate!] in
         // closure body goes here
         }
         
         lazy var someClosure: (Int, String) -> String = {
         [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
         // closure body goes here
         }
         */
        var html2: HTMLElementCp16ResolveCycle? = HTMLElementCp16ResolveCycle(name: "p", text: "I take some text.")
        print(html2!.asHTML())
        html2 = nil
        
        print("End of Chapter 16.")
    }
}

class DogCp16 {
    var name = ""
}

class PersonCp16 {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is initialized.")
    }
    deinit {
        print("\(name) is being deinitialized.")
    }
}

class PersonCp16ReferenceCycle {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is initialized.")
    }
    var apartment: ApartmentCp16ReferenceCycle?
    deinit {
        print("\(name) is being deinitialized.")
    }
}

class ApartmentCp16ReferenceCycle {
    let unit: String
    init(unit: String) {
        print("Apartment \(unit) is initialized")
        self.unit = unit
    }
    var tenant: PersonCp16ReferenceCycle?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

class PersonCp16WeakReference {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is initialized.")
    }
    var apartment: ApartmentCp16WeakReference?
    deinit {
        print("\(name) is being deinitialized.")
    }
}

class ApartmentCp16WeakReference {
    let unit: String
    init(unit: String) {
        print("Apartment \(unit) is initialized")
        self.unit = unit
    }
    weak var tenant: PersonCp16WeakReference?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

class CustomerCp16Unowned {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is initialized.")
    }
    var creditCard: CreditCardCp16Unowned?
    deinit {
        print("\(name) is being deinitialized.")
    }
}

class CreditCardCp16Unowned {
    let number: UInt64
    unowned let owner: CustomerCp16Unowned
    init(number: UInt64, owner: CustomerCp16Unowned) {
        self.number = number
        self.owner = owner
        print("Card #\(number) is initialized.")
    }
    deinit {
        print("Card #\(number) is being deinitialized.")
    }
}

// Unowned References and Implicitly Unwrapped Optional Properties
class CountryCp16 {
    let name: String
    // "CityCp16!" means that the capitalCity property has a default value of nil, like any other optional, but can be accessed without the need to unwrap its value.
    // If you use it when its value is nil, you will get a runtime error.
    var capitalCity: CityCp16!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = CityCp16(name: capitalName, country: self)
        print("\(name) country is initialized.")
    }
    deinit {
        print("\(name) country is being deinitialized.")
    }
}

class CityCp16 {
    let name: String
    unowned let country: CountryCp16
    init(name: String, country: CountryCp16) {
        self.name = name
        self.country = country
        print("\(name) city is initialized.")
    }
    deinit {
        print("\(name) city is being deinitialized.")
    }
}

// Strong Reference Cycle for Closure
class HTMLElementCp16Cycle {
    let name: String
    let text: String?
    lazy var asHTML: ()->String = {
        if let text = self.text {
            return "<\(self.name)>\(text)<\(self.name)>"
        }else {
            return "<\(self.name)><\(self.name)>"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
        print("\(name) HTMLElement is initialized.")
    }
    deinit {
        print("\(name) HTMLElement is being deinitialized.")
    }
}

// Resolve a strong reference cycle between a closure and a class instance
class HTMLElementCp16ResolveCycle {
    let name: String
    let text: String?
    lazy var asHTML: ()->String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)<\(self.name)>"
        }else {
            return "<\(self.name)><\(self.name)>"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
        print("\(name) HTMLElement is initialized.")
    }
    deinit {
        print("\(name) HTMLElement is being deinitialized.")
    }
}

