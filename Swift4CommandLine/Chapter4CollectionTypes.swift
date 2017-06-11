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
        
    }
}
