//
//  Chapter3StringsAndCharacters.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/10.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter3StringsAndCharacters: NSObject {
    static public func run() {
        // Swift String
        // Fast, Unicode
        // Struct
        
        // String Literals
        let someString = "Some string literal value"
        
        // If you need a string that spans several lines, use a multiline string literal. A multiline string literal is a sequence of characters surrounded by three double quotes:
        let quotation =
"""
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.
 
"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
        print(quotation)
        
        let quotation1 = "Hello \nWorld \n!"
        print(quotation1)
        
        // Initializing an Empty String
        // these two strings are both empty, and are equivalent to each other
        var emptyString = ""               // empty string literal
        var anotherEmptyString = String()  // initializer syntax
        
        if emptyString.isEmpty {
            print("This string is empty.")
        }
        
        // that's OK
        emptyString += "I am not empty now."
        // that isn't OK
        // quotation1 += "I am an constant string."
        
        // <<Strings Are Value Types>>
        // Swift’s String type is a value type. If you create a new String value, that String value is copied when it is passed to a function or method, or when it is assigned to a constant or variable. In each case, a new copy of the existing String value is created, and the new copy is passed or assigned, not the original version. Value types are described in <<Structures and Enumerations Are Value Types>>.
        // Swift’s copy-by-default String behavior ensures that when a function or method passes you a String value, it is clear that you own that exact String value, regardless of where it came from. You can be confident that the string you are passed will not be modified unless you modify it yourself.
        
        // Character
        for chara in "Dog🐶" {
            print(chara)
        }
        let character: Character = "V"
        let characters: [Character] = ["a", ",", "b", ",", "c"]
        let charaStr = String(characters)
        print("character: \(character), charaStr: \(charaStr)")
        
        // String
        // Concatenating String
        var myString = ""
        myString += "aaa"
        myString.append(character)
        myString.append("another string")
        // Counting Characters
        print("\(myString) has \(myString.count) characters.")
        
        // Inserting and Removing
        var welcome = "hello"
        welcome.insert("!", at: welcome.endIndex)
        // welcome now equals "hello!"
        print(welcome)
        welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
        // welcome now equals "hello there!"
        print(welcome)
        
        welcome.remove(at: welcome.index(before: welcome.endIndex))
        // welcome now equals "hello there"
        let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)
        // welcome now equals "hello"
        
        // Substrings
        // When you get a substring from a string—for example, using a subscript or a method like prefix(_:)—the result is an instance of Substring, not another string. Substrings in Swift have most of the same methods as strings, which means you can work with substrings like strings. Unlike strings, you use substrings for only a short amount of time while performing actions on a string. When you’re ready to store the result for a <<longer time>>, you convert the substring to an instance of String.
        let greeting = "Hello, world!"
        let index = greeting.index(of: ",") ?? greeting.endIndex
        let beginning = greeting[..<index]
        // beginning is "Hello"
        
        // Convert the result to a String for long-term storage.
        let newString = String(beginning)
        
        // In the example above, greeting is a string, which means it has a region of memory where the characters that make up the string are stored. Because beginning is a substring of greeting, it re-uses the memory that greeting uses. In contrast, newString is a string—when it’s created from the substring, it has its own storage. The figure below shows these relationships:
        //  Type                Storage
        //  [String] -->  -->   (Hello),World!
        //  [Substring] --||
        //
        //  [String] -->        Hello
        
        // Comparing Strings
        // str1: String == str2: String
        
        // Prefix and Suffix
        let hasAAAPrefix = someString.hasPrefix("aaa")
        let hasBBBSuffix = someString.hasSuffix("bbb")
        
        var variableStr = "I am a variable string"
        variableStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        variableStr.appendingFormat("feafewaf%d", 4)
        variableStr.localizedCapitalized
        let splitResult = variableStr.split(separator: " ")
        print("splitResult == \(splitResult)")
        
    }
}
