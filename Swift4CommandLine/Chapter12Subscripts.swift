//
//  Chapter12Subscripts.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/15.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter12Subscripts: NSObject {
    static public func run() {
        // Subscripts
        // Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence. You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval. For example, you access elements in an Array instance as someArray[index] and elements in a Dictionary instance as someDictionary[key].
        // You can define multiple subscripts for a single type, and the appropriate subscript overload to use is selected based on the type of index value you pass to the subscript. Subscripts are not limited to a single dimension, and you can define subscripts with multiple input parameters to suit your custom type’s needs.
        
        // Subscript Syntax
        /*
        subscript(index: Int) -> Int {
            get {
                // return an appropriate subscript value here
            }
            set(newValue) {
                // perform a suitable setting action here
            }
        }
         */
        
        // Subscript Usage
        // Subscripts can use variadic parameters, but they can’t use in-out parameters or provide default parameter values.
        var matrix = Matrix.init(rows: 4, columns: 4)
        matrix[3, 3] = 10
        matrix[0, 0] = 1
        
        print("0.0 = \(matrix[0, 0]), 3.3 = \(matrix[3, 3])")
    }
}

struct Matrix {
    var rows: Int
    var columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Array.init(repeating: 0.0, count: rows * columns)
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
}




