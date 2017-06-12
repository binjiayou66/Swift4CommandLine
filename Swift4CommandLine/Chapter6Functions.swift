//
//  Chapter6Functions.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/12.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter6Functions: NSObject {
    static public func run() {
        // Functions
        // 1. Defining and Calling Functions
        // 2. Function Parameters and Return Values
        // 3. Function Argument Labels and Parameter Names
        // 4. Function Types
        // 5. Nested Functions
        
        // Functions are self-contained chunks of code that perform a specific task.
        // A Function has its name, type and value.
        // Function name is used to "call" it to perform its task.
        // Function type refer to the types of its parameters and return value
        // Function value is the value of return value
        
        // * In my opinion, the name of the function can be regarded as a variable name. The implement of the function is the nature value of that function.
        
        // 1. Defining and Calling Functions
        func greet(person: String) -> String {
            return "Hello, \(person)!"
        }
        let result = greet(person: "Lee")
        print("Function name is \"greet(person:)\"")
        print("Function type is \"(String) -> String\"")
        print("Function value is \"\(result)\"")
        
        // 2. Function Parameters and Return Values
        // Functions Without Parameters
        // Functions With Multiple Parameters
        // Functions Without Return Values
        // Functions with Multiple Return Values (Tuple)
        // Optional Tuple Return Types
        func minMax(array: [Int]) -> (min: Int, max: Int)? {
            if array.isEmpty { return nil }
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin, currentMax)
        }
        if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
            print("min is \(bounds.min) and max is \(bounds.max)")
        }
        
        // 3. Function <<Argument Labels>> and <<Parameter Names>>
        // Each function parameter has both an argument label and a parameter name. The argument label is used when calling the function; each argument is written in the function call with its argument label before it. The parameter name is used in the implementation of the function. <<By default, parameters use their parameter name as their argument label>>.
        // 3.1 Common
        func someFunction(firstParameterName: Int, secondParameterName: Int) {
            // In the function body, firstParameterName and secondParameterName refer to the argument values for the first and second parameters.
        }
        someFunction(firstParameterName: 1, secondParameterName: 2)
        // 3.2 Specifying Argument Labels
        // In this function, "from" is the second argument label, "hometown" is the second parameter name
        func greetPlus(person: String, from hometown: String) -> String {
            return "Hello \(person)!  Glad you could visit from \(hometown)."
        }
        // When you call a function, argument label will show, but parameter name will not be presented.
        let greetPlusResult = greetPlus(person: "Bill", from: "Cupertino")
        print(greetPlusResult)
        // 3.3 Omitting Argument Labels
        // If you don’t want an argument label for a parameter, write an underscore (_) instead of an explicit argument label for that parameter.
        func omittingArgumentLabelFunction(_ firstParameterName: Int, secondParameterName: Int) {
            // In the function body, firstParameterName and secondParameterName refer to the argument values for the first and second parameters.
        }
        omittingArgumentLabelFunction(1, secondParameterName: 2)
        // 3.4 Default Parameter Values
        func addFunc(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) -> Int {
            return parameterWithoutDefault + parameterWithDefault
        }
        print(addFunc(parameterWithoutDefault: 3, parameterWithDefault: 4))
        print(addFunc(parameterWithoutDefault: 9))
        // 3.5 Variadic Parameters
        func avgFunc(numbers: Double...) -> Double {
            var sum = 0.0
            for item in numbers {
                sum += item
            }
            return sum / Double(numbers.count)
        }
        print("Average: \(avgFunc(numbers:1.5, 6.5, 7.0))")
        // 3.6 In-Out Parameters
        // <<Function parameters are constants by default>>. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake. If you want a function to <<modify a parameter’s value>>, and you want those <<changes to persist after the function call has ended>>, define that parameter as an <<in-out parameter>> instead.
        func swapTwoInts(a: inout Int, b: inout Int) {
            let temp = a
            a = b
            b = temp
        }
        var num1 = 11
        var num2 = 99
        print("num1 = \(num1), num2 = \(num2)")
        swapTwoInts(a: &num1, b: &num2)
        print("num1 = \(num1), num2 = \(num2)")
        
        // 4. Function Types
        // 4.1 Every function has a specific function type, made up of the parameter types and the return type of the function.
        func addTwoInts(_ a: Int, _ b: Int) -> Int {
            return a + b
        }
        func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
            return a * b
        }
        // The type of both of these functions is (Int, Int) -> Int. This can be read as:
        // “A function that has two parameters, both of type Int, and that returns a value of type Int.”
        // Using Function Types
        var mathFunction: (Int, Int) -> Int = addTwoInts
        // If we regard function names as variable name (detail at line 26), the code above can be read as:
        // "Define a variable called mathFunction, which has a type of '(Int, Int) -> Int', and its nature value is the implement of function addTwoInts"
        let mathFuncResult = mathFunction(9, 8)
        print("mathFuncResult = \(mathFuncResult)")
        // A different function with the same matching type can be assigned to the same variable, in the same way as for non-function types:
        mathFunction = multiplyTwoInts
        print("Result: \(mathFunction(2, 3))")
        // If we regard function names as variable name (detail at line 26), the code above is easy understood. It is similar to code "var a = 10; a = 99;". It just change a varable's value, not type. That is legal.
        // 4.2 Function Types as Parameter Types
        func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
            print("Result: \(mathFunction(a, b))")
        }
        printMathResult(addTwoInts, 3, 5)
        printMathResult(multiplyTwoInts, 3, 5)
        // 4.3 Function Types as Return Types
        func stepForward(_ input: Int) -> Int {
            return input + 1
        }
        func stepBackward(_ input: Int) -> Int {
            return input - 1
        }
        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            return backward ? stepBackward : stepForward
        }
        var currentValue = 3
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
        print("Counting to zero:")
        // Counting to zero:
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearerToZero(currentValue)
        }
        print("zero!")
        
        // 5. Nested Functions
        // All of the functions you have encountered so far in this chapter have been examples of global functions, which are defined at a global scope. You can also define functions inside the bodies of other functions, known as nested functions.
        // Nested functions are hidden from the outside world by default, but can still be called and used by their enclosing function. An enclosing function can also <<return one of its nested functions>> to allow the nested function to <<be used in another scope>>.
        func chooseStepFunctionNest(backward: Bool) -> (Int) -> Int {
            func stepForward(input: Int) -> Int { return input + 1 }
            func stepBackward(input: Int) -> Int { return input - 1 }
            return backward ? stepBackward : stepForward
        }
        var currentValueNest = -4
        let moveNearerToZeroNest = chooseStepFunctionNest(backward: currentValue > 0)
        // moveNearerToZero now refers to the nested stepForward() function
        while currentValueNest != 0 {
            print("\(currentValueNest)... ")
            currentValueNest = moveNearerToZeroNest(currentValueNest)
        }
        print("zero!")
    }
}
