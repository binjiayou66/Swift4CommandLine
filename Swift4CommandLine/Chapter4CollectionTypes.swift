//
//  Chapter4CollectionTypes.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/10.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter4CollectionTypes: NSObject {
    static public func run() {
        // Value Type and Reference Type
        var a = [1, 2, 3]
        var b = a
        var c = a
        
        print("a[1] == \(a[1])")
        print("b[1] == \(b[1])")
        print("c[1] == \(c[1])")
        
        a[1] = 122
        
        print("a[1] == \(a[1])")
        print("b[1] == \(b[1])")
        print("c[1] == \(c[1])")
        
        let arr1 = NSMutableArray.init(array: a)
        let arr2 = arr1
        let arr3 = arr1
        
        print("arr1[1] == \(arr1[1])")
        print("arr2[1] == \(arr2[1])")
        print("arr3[1] == \(arr3[1])")
        
        arr1.replaceObject(at: 1, with: 9)
        
        print("arr1[1] == \(arr1[1])")
        print("arr2[1] == \(arr2[1])")
        print("arr3[1] == \(arr3[1])")
        
        // Collection Types
        // Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values. Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations.
        // Arrays, sets, and dictionaries in Swift are always <<clear about the types of values and keys>> that they can store. This means that you cannot insert a value of the wrong type into a collection by mistake. It also means you can be confident about the type of values you will retrieve from a collection. Swift’s array, set, and dictionary types are implemented as <<generic collections>>.
        // immutable array
        let array1 = ["a", "b"]
        // mutable array
        var array2 = ["c", "d"]
        // It is good practice to create immutable collections in all cases where the collection does not need to change. Doing so makes it easier for you to reason about your code and enables the Swift compiler to optimize the performance of the collections you create.
        
        // Array
        // The type of a Swift array is written in full as <<Array<Element>,>> where Element is the type of values the array is allowed to store. You can also write the type of an array in shorthand form as <<[Element]>>. Although the two forms are functionally identical, the shorthand form is preferred and is used throughout this guide when referring to the type of an array.
        let eptArr1: Array<Int> = []
        let eptArr2: [Int] = []
        let eptArr3: [Int] = Array()
        // Preferred Form
        let eptArr4 = [Int]()
        
        // Type can be inferred
        var mainArr = [6, 7]
        // Add
        mainArr.append(5)
        for item in mainArr {
            print("mainArr item: \(item)")
        }
        // Add another array
        let subArr = [1, 2, 3, 4]
        mainArr += subArr
        // Access an array
        print("We can access an array's item by its index.")
        for i in 0..<mainArr.count {
            print("The \(i)th item is: \(mainArr[i])")
        }
        // Modify an array
        mainArr[1] = 8  // index can be only used for modifing or reading, not for adding a new item
        // Modify range items
        mainArr[3...6] = [9,9,9]
        for item in mainArr {
            print("mainArr item: \(item)")
        }
        // Insert
        mainArr.insert(999, at: 0)
        mainArr.remove(at: mainArr.count - 1)
        mainArr.removeFirst()
        mainArr.removeLast()
        // mainArr.removeAll()
        
        // Iterating
        for (index, value) in mainArr.enumerated() {
            print("Item \(index + 1): \(value)")
        }
        
        // Sets
        // A set stores <<distinct values>> of the <<same type>> in a collection with <<no defined ordering>>. You can use a set instead of an array when the order of items is not important, or when you need to ensure that an item only appears once.
        // A type must be <<hashable>> in order to be stored in a set.
        // A set type cannot be inferred from an array literal alone, so the type Set must be explicitly declared.
        let emptySet1 = Set<String>()
        let emptySet2: Set<String> = []
        // Functions Show
        var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
        // count
        print("favoriteGenres has \(favoriteGenres.count) items.")
        // isEmpty
        if favoriteGenres.isEmpty {
            print("favoriteGenres is empty.")
        }
        // contains
        if favoriteGenres.contains("Rock") {
            print("I like Rock.")
        }
        // insert
        let insertResult = favoriteGenres.insert("Jazz")
        if insertResult.inserted {
            print("\(insertResult.inserted), \(insertResult.memberAfterInsert)")
        }
        // remove
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        }else {
            print("I never much cared for that.")
        }
        // Iterating
        for genre in favoriteGenres {
            print("\(genre)")
        }
        // function sorted returns the set’s elements as an array sorted using the < operator.
        for genre in favoriteGenres.sorted() {
            print("\(genre)")
        }
        // Performing Set Operations
        // Here's a picture that might help you understand.(https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/setVennDiagram_2x.png)
        let setA: Set = [1, 2, 3, 4, 5]
        let setB: Set = [4, 5, 6, 7, 8]
        // intersection
        let abResult1 = setA.intersection(setB)
        // symmetricDifference
        let abResult2 = setA.symmetricDifference(setB)
        // union
        let abResult3 = setA.union(setB)
        // subtracting
        let abResult4 = setA.subtracting(setB)
        // sub
        let abResult5 = setA.isSubset(of: setB)
        // super
        let abResult6 = setA.isSuperset(of: setB)
        // disjoint
        let abResult7 = setA.isDisjoint(with: setB)
        
        // Dictionaries
        // A dictionary stores associations between <<keys of the same type>> and <<values of the same type>> in a collection with <<no defined ordering>>. Each value is associated with a <<unique key>>, which acts as an identifier for that value within the dictionary. Unlike items in an array, items in a dictionary do not have a specified order. You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used to look up the definition for a particular word.
        // A dictionary Key type must conform to the Hashable protocol, like a set’s value type.
        let emptyDic1 = Dictionary<String, String>()
        // Preferred
        let emptyDic2 = [String: String]()
        let emptyDic3: Dictionary<String, String> = [:]
        let emptyDic4: [String: String] = [:]
        // inferred type
        var mainDic = [1:"one", 2:"two"]
        
        // Accessing and Modifying a Dictionary
        // count
        print("mainDic contains \(mainDic.count) items.")
        // isEmpty
        // add
        mainDic[3] = "three"
        // change
        mainDic[2] = "new two"
        // or change like this
        if let oldValue = mainDic.updateValue("update three", forKey: 3) {
            print("The old value for 3 was \(oldValue).")
        }
        // read
        if let value = mainDic[3] {
            print("Value is \(value).")
        } else {
            print("There is not value with that key.")
        }
        // delete
        mainDic[3] = nil
        // or delete like this
        if let removedValue = mainDic.removeValue(forKey: 2) {
            print("removedValue: \(removedValue).")
        } else {
            print("The mainDic dictionary does not contain a value for 2.")
        }
        // Iterating
        for (key, value) in mainDic {
            print("\(key): \(value)")
        }
        for key in mainDic.keys {
            print("\(key): \(mainDic[key] ?? "Default Value")")
        }
        for value in mainDic.values {
            print("value: \(value)")
        }
    }
}
