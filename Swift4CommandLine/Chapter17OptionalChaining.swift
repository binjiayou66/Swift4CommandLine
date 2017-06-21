//
//  Chapter17OptionalChaining.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/16.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter17OptionalChaining: NSObject {
    static public func run() {
        // Optional Chaining
        // (1) Optional Chaining as an Alternative to Forced Unwrapping
        // (2) Defining Model Classes for Optional Chaining
        // (3) Accessing Properties Through Optional Chaining
        // (4) Calling Methods Through Optional Chaining
        // (5) Accessing Subscripts Through Optional Chaining
        // (6) Linking Multiple Levels of Chaining
        // (7) Chaining on Methods with Optional Return Values
        
        // Optional Chaining
        // Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil. If the optional contains a value, the property, method, or subscript call succeeds; if the optional is nil, the property, method, or subscript call returns nil. Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.
        
        // (1) Optional Chaining as an Alternative to Forced Unwrapping
        // You specify optional chaining by placing a question mark (?) after the optional value on which you wish to call a property, method or subscript if the optional is non-nil. This is very similar to placing an exclamation mark (!) after an optional value to force the unwrapping of its value. The main difference is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil.
        let person1 = PersonCp17()
        // this triggers a runtime error
        // let roomCount = person1.residence!.numberOfRooms
        if let roomCount = person1.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        }else {
            print("Unable to retrieve the number of rooms.")
        }
        
        // (2) Defining Model Classes for Optional Chaining
        // (3) Accessing Properties Through Optional Chaining
        let john = PersonCp17()
        
        let someAddress = AddressCp17()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        // In this example, the attempt to set the address property of john.residence will fail, because john.residence is currently nil. But you will not get any errors here.
        john.residence?.address = someAddress
        
        func createAddress() -> AddressCp17 {
            print("Function was called.")
            
            let someAddress = AddressCp17()
            someAddress.buildingNumber = "29"
            someAddress.street = "Acacia Road"
            
            return someAddress
        }
        // "Function was called." was not printed which means the function createAddress was not called.
        john.residence?.address = createAddress()
        
        // (4) Calling Methods Through Optional Chaining
        // You can use optional chaining to call a method on an optional value, and to check whether that method call is successful. You can do this even if that method does not define a return value.
        // This method does not specify a return type. However, functions and methods with no return type have an implicit return type of Void, as described in Functions Without Return Values. This means that they return a value of (), or an empty tuple.If you call this method on an optional value with optional chaining, the method’s return type will be Void?, not Void, because return values are always of an optional type when called through optional chaining.
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
        // Prints "It was not possible to print the number of rooms."
        
        // The same is true if you attempt to set a property through optional chaining. The example above in Accessing Properties Through Optional Chaining attempts to set an address value for john.residence, even though the residence property is nil. Any attempt to set a property through optional chaining returns a value of type Void?, which enables you to compare against nil to see if the property was set successfully:
        if (john.residence?.address = someAddress) != nil {
            print("It was possible to set the address.")
        } else {
            print("It was not possible to set the address.")
        }
        // Prints "It was not possible to set the address."
        
        // (5) Accessing Subscripts Through Optional Chaining
        let johnsHouse = ResidenceCp17()
        johnsHouse.rooms.append(RoomCp17(name: "Living Room"))
        johnsHouse.rooms.append(RoomCp17(name: "Kitchen"))
        john.residence = johnsHouse
        
        if let firstRoomName = john.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        // Prints "The first room name is Living Room."
        
        // (6) Linking Multiple Levels of Chaining
        // >>1 If you try to retrieve an Int value through optional chaining, an Int? is always returned, because of the optional chaining and no matter how many levels of chaining are used.
        // >>2 Similarly, if you try to retrieve an Int? value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.
        let johnsAddress = AddressCp17()
        johnsAddress.buildingName = "The Larches"
        johnsAddress.street = "Laurel Street"
        john.residence?.address = johnsAddress
        
        if let johnsStreet = john.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
        // Prints "John's street name is Laurel Street."
        
        // (7) Chaining on Methods with Optional Return Values
        // buildingIdentifier is type of 'String?'
        let buildingIdentifier = john.residence?.address?.buildingIdentifier()
        
        if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
            print("John's building identifier is \(buildingIdentifier).")
        }
        // Prints "John's building identifier is The Larches."
        
        if let beginsWithThe =
            john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
            if beginsWithThe {
                print("John's building identifier begins with \"The\".")
            } else {
                print("John's building identifier does not begin with \"The\".")
            }
        }
        // Prints "John's building identifier begins with "The"."
        
        print("End of Chapter17.")
    }
}

class PersonCp17 {
    var residence: ResidenceCp17?
}

class ResidenceCp17 {
    var rooms = [RoomCp17]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(index: Int) -> RoomCp17 {
        get {
            return rooms[index]
        }
        set {
            rooms[index] = newValue
        }
    }
    var address: AddressCp17?
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
}

class RoomCp17 {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class AddressCp17 {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

