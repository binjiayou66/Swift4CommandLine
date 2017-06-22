//
//  Chapter19TypeCasting.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/16.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter19TypeCasting: NSObject {
    static public func run() {
        // Type Casting
        // (1) Defining a Class Hierarchy for Type Casting
        // (2) Checking Type
        // (3) Downcasting
        // (4) Type Casting for Any and AnyObject
        
        // Type Casting
        // (1) Defining a Class Hierarchy for Type Casting
        let library = [
            MovieCp19(name: "Casablanca", director: "Michael Curtiz"),
            SongCp19(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            MovieCp19(name: "Citizen Kane", director: "Orson Welles"),
            SongCp19(name: "The One And Only", artist: "Chesney Hawkes"),
            SongCp19(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        // The items stored in library are still Movie and Song instances behind the scenes. However, if you iterate over the contents of this array, the items you receive back are typed as MediaItem, and not as Movie or Song. In order to work with them as their native type, you need to check their type, or downcast them to a different type, as described below.
        
        // (2) Checking Type
        // is
        var movieCount = 0, songCount = 0
        for item in library {
            if item is MovieCp19 {
                movieCount += 1
            }else if item is SongCp19 {
                songCount += 1
            }
        }
        
        // (3) Downcasting
        // The conditional form, as?, returns an optional value of the type you are trying to downcast to. This form of the operator will always return an optional value, and the value will be nil if the downcast was not possible.
        // The forced form, as!, attempts the downcast and force-unwraps the result as a single compound action. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
        for item in library {
            // Try to access item as a Movie. If this is successful, set a new temporary constant called movie to the value stored in the returned optional Movie.
            if let movie = item as? MovieCp19 {
                print("Movie: \(movie.name), dir. \(movie.director)")
            } else if let song = item as? SongCp19 {
                print("Song: \(song.name), by \(song.artist)")
            }
        }
        // Note:
        /*
         <<as>>
         >>1 Upcasting, from subclass to superclass
         class Animal {}
         class Cat: Animal {}
         let cat = Cat()
         let animal = cat as Animal
         >>2 Explicit type
         let num1 = 42 as CGFloat
         let num2 = 42 as Int
         let num3 = 42.5 as Int
         let num4 = (42 / 2) as Double
         >>3 switch statement
         switch animal {
         case let cat as Cat:
         print("If it's an instance of Cat, then do something.")
         case let dog as Dog:
         print("If it's an instance of Dog, then do something.")
         default: break
         }
         */
        
        // (4) Type Casting for Any and AnyObject
        // Swift provides two special types for working with nonspecific types:
        // >>1 Any can represent an instance of any type at all, including function types.
        // >>2 AnyObject can represent an instance of any class type.
        
        // Use Any and AnyObject only when you explicitly need the behavior and capabilities they provide. It is always better to be specific about the types you expect to work with in your code.
        var things = [Any]()
        
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        // Tuple
        things.append((3.0, 5.0))
        // Object
        things.append(MovieCp19(name: "Ghostbusters", director: "Ivan Reitman"))
        // Closure
        things.append({ (name: String) -> String in "Hello, \(name)" })
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as MovieCp19:
                print("a movie called \(movie.name), dir. \(movie.director)")
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
        }
        
        
        // Summary:
        // 1. instance is Song, returns true or false
        // 2. instance as? Song, returns optional Song, or "Song?"
        //    instance as! Song, returns Song or casue runtime error
    }
}

class MediaCp19 {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class MovieCp19: MediaCp19 {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class SongCp19: MediaCp19 {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}




