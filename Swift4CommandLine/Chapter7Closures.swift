//
//  Chapter7Closures.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/12.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter7Closures: NSObject {
    static public func run() {
        // Closures
        // Closures are self-contained blocks of functionality that can be passed around and used in your code.
        // 1. Closure Expressions
        // 2. Trailing Closures
        // 3. Capturing Values
        // 4. Closures Are Reference Types
        // 5. Escaping Closures
        // 6. Autoclosures
        
        // Global and nested functions, as introduced in Functions, are actually special cases of closures. Closures take one of three forms:
        // (1) Global functions are closures that have a name and do not capture any values.
        // (2) Nested functions are closures that have a name and can capture values from their enclosing function.
        // (3)Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
        
        // 1. Closure Expressions
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        let namesSorted1 = names.sorted(by: backward)
        print("names sorted by backward function: \(namesSorted1)")
        // 1.1 Closure Expression Syntax
        /*
        { (parameters) -> return type in
            statements
        }
         */
        let namesSorted2 = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2
        })
        print("names sorted by closure: \(namesSorted2)")
        // The parameters in closure expression syntax can be in-out parameters, but they can’t have a default value. Variadic parameters can be used if you name the variadic parameter. Tuples can also be used as parameter types and return types.
        // 1.2 Inferring Type From Context
        // Because the sorting closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns.The sorted(by:) method is being called on an array of strings, so its argument must be a function of type (String, String) -> Bool. This means that the (String, String) and Bool types do not need to be written as part of the closure expression’s definition. Because all of the types can be inferred, the return arrow (->) and the parentheses around the names of the parameters can also be omitted:
        let namesSorted3 = names.sorted(by: {
            s1, s2 in return s1 > s2
        })
        print("names sorted by ommitted closure(inferred type): \(namesSorted3)")
        // 1.3 Implicit Returns from Single-Expression Closures
        // <<Single-expression closures>> can implicitly return the result of their single expression by omitting the return keyword from their declaration, as in this version of the previous example:
        let namesSorted4 = names.sorted(by: {s1, s2 in s1 > s2})
        print("names sorted by ommitted closure(omit return): \(namesSorted4)")
        // 1.4 Shorthand Argument Names
        // Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
        // Here, $0 and $1 refer to the closure’s first and second String arguments.
        let namesSorted5 = names.sorted(by: { $0 > $1 })
        print("names sorted by ommitted closure(omit argument names): \(namesSorted5)")
        // 1.5 Operator Methods
        // Swift’s <<String type defines>> its string-specific implementation of the greater-than operator (>) as a method that has two parameters of type String, and returns a value of type Bool. This exactly matches the method type needed by the sorted(by:) method. Therefore, you can simply pass in the greater-than operator, and Swift will infer that you want to use its string-specific implementation:
        let namesSorted6 = names.sorted(by: >)
        print("names sorted by ommitted closure(operator method): \(namesSorted6)")
        
        // 2. Trailing Closures
        // If you need to <<pass a closure expression to a function as the function’s final argument>> and the closure expression is long, it can be useful to write it as a trailing closure instead.
        // A trailing closure is written after the function call’s parentheses, even though it is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the closure as part of the function call.
        // Usage scene of Trailing Closures
        // 1. call a function
        // 2. closure is the function's final argument
        func someFunctionThatTakesAClosure(closure: ()->Void) {
            closure()
            print("Here is function's body.")
        }
        // Here's how you call this function without using a trailing closure:
        someFunctionThatTakesAClosure(closure: {
            print("Here is closure's body.")
        })
        // Here's how you call this function with a trailing closure instead:
        someFunctionThatTakesAClosure() {
            print("Here is trailing closure's body.")
        }
        // When a closure is is the function's only argument, you can code like this:
        someFunctionThatTakesAClosure {
            print("Another.")
        }
        // Little Demo
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        let strings = numbers.map {
            (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number%10]! + output
                number /= 10
            } while number > 0
            return output
        }
        print("map result = \(strings)")
        
        // 3. Capturing Values
        // Three times for important things: Capture reference, Capture reference, Capture reference
        // Capturing by reference ensures that runningTotal and amount do not disappear when the call to makeIncrementer ends, and also ensures that runningTotal is available the next time the incrementer function is called.
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        
        let incrementByTen = makeIncrementer(forIncrement: 10)
        let firstIncrement = incrementByTen()
        print("firstIncrement = \(firstIncrement)")
        let secondIncrement = incrementByTen()
        print("secondIncrement = \(secondIncrement)")
        // If you create a second incrementer, it will have its own stored reference to a new, separate runningTotal variable:
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        let anotherIncrement = incrementBySeven()
        print("anotherIncrement = \(anotherIncrement)")
        // Calling the original incrementer (incrementer) again continues to increment its own runningTotal variable, and does not affect the variable captured by anotherIncrementer:
        let thirdIncrement = incrementByTen()
        print("thirdIncrement = \(thirdIncrement)")
        
        // 4. Closures Are Reference Types
        // In the example above, incrementBySeven and incrementByTen are constants, but the closures these constants refer to are still able to increment the runningTotal variables that they have captured. This is because functions and closures are reference types.
        // 注：在上面的例子中，我们把incrementBySeven和incrementByTen声明为了常量，但是这两个常量指向的两个闭包可以使它们捕获的runningTotal变量们增量，这是因为闭包和函数是引用类型
        // Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure. In the example above, it is the choice of closure that incrementByTen refers to that is constant, and not the contents of the closure itself.
        // 注：不论你把一个函数/闭包声明为常量还是变量，其实，你是把这个常量或者变量指向了这个闭包/函数，这个常量或者变量为该函数/闭包的引用。在上面的例子当中，incrementByTen这个闭包的引用是一个常量，但闭包本身并不是常量。
        // This also means that if you assign a closure to two different constants or variables, both of those constants or variables will refer to the same closure:
        // 这也就意味着，如果你把同一个闭包赋给两个不同的常量或变量，这两个常量或变量其实指向的是同一个闭包
        let alsoIncrementByTen = incrementByTen
        // illegal, alsoIncrementByTen is a constant reference. Value of alsoIncrementByTen can not be modified.
        // alsoIncrementByTen = incrementBySeven
        let forthIncrement = alsoIncrementByTen()
        print("forthIncrement = \(forthIncrement)")
        
        // 小结：
        // (1) 闭包可以捕获包裹它的函数域内声明的常量/变量，并且可以持有它们的引用以保证及时包裹它的函数return之后，它所捕获的常量/变量也并不会被释放
        // (2) 闭包是引用类型。闭包的引用声明为常量或者变量，对闭包本身没有影响。多个引用（常量/变量）可以指向同一个闭包。
        
        // 5. Escaping Closures
        // A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.
        // Marking a closure with @escaping means you have to refer to self explicitly within the closure. In contrast, nonescaping closure can refer to self implicitly.
        let cp7 = Chapter7Closures()
        cp7.run()
        
        // 6. Autoclosures
        // An autoclosure is a closure that is automatically created to wrap an expression that’s being passed as an argument to a function. It <<doesn’t take any arguments>>, and when it’s called, it <<returns the value of the expression that’s wrapped inside of it>>.
        // Official case
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)  // 5
        // * In my opinion, that is a closure which contains no argument, omits return type and has a name.
        // According to the official statement,
        let customerProvider = { customersInLine.remove(at: 0) }
        // Remove operation is not operated at here.
        print(customersInLine.count) // 5
        // Remove operation is operated when the closure is called.
        let customer1 = customerProvider()
        print(customersInLine.count) // 4
        
        func collectCustomerProviders(customerProvider: @autoclosure () -> String) {
            print("In function collectCustomerProviders")
            print(customersInLine.count)
            
            let _ = customerProvider()
            print("Call it in function")
            print(customersInLine.count)
        }
        // When we call function collectCustomerProviders, compiler don't prompt us that argument type is expected to be "@autoclosure () -> String". Argument type is just "String".
        // collectCustomerProviders(customerProvider: <#T##String#>)
        // Even though, "customerProvider()", that statment looks like "customerProvider" has been executed. But "{ customersInLine.remove(at: 0) }" will not be executed unless we call it in the function.
        collectCustomerProviders(customerProvider: customerProvider())
        
        // Test
        // * I want to code an autoclosure with argument. It all ok when I am coding. But a compile error shows when I compile that code. The error is "Command failed due to signal: Abort trap: 6".
        // So, autoclosure doesn’t take any arguments.
        var aNumber = 10
        let changeNumber = {
            (number: Int) -> Int in
            print("changeNumber has been executed.")
            return number + 10
        }
        func changeNumberFunc(changeNumber: @autoclosure (Int) -> Int) {
            print("In function changeNumberFunc")
        }
        // Compile error shows at here.
        // changeNumberFunc(changeNumber: changeNumber(aNumber))
        
        // Internet case
        func scanFinger() -> Bool {
            // Assume scan finger is faster than scan face.
            //sleep(1)
            return true
        }
        func scanFace() -> Bool {
            //sleep(5)
            return true
        }
        func openDoor() {
            print("The door is opened.")
        }
        func callGuard() {
            print("Verify failed.")
        }
        func verifyPerson(scanFinger: Bool, scanFace: Bool) {
            if scanFinger {
                openDoor()
            }else if scanFace {
                openDoor()
            }else {
                callGuard()
            }
        }
        // If we code like this, we need to wait for 6 seconds for each authentication. Actually, that is not necessary. If scanFinger returns true, we can open the door without executing scanFace function. So we improve our program below.
        verifyPerson(scanFinger: scanFinger(), scanFace: scanFace())
        
        // The improvement of program based on we can control if we need to excute scanFace function.
        func verifyPersonNew(scanFinger: Bool, scanFace: () -> Bool) {
            if scanFinger {
                openDoor()
            }else if scanFace(){
                openDoor()
            }else {
                callGuard()
            }
        }
        verifyPersonNew(scanFinger: scanFinger(), scanFace: {
            scanFace()
        })
        
        // Using autoclosure can make our program more concise
        func verifyPersonNewPlus(scanFinger: Bool, scanFace: @autoclosure () -> Bool) {
            if scanFinger {
                openDoor()
            }else if scanFace(){
                openDoor()
            }else {
                callGuard()
            }
        }
        // verifyPersonNew(scanFinger: <#T##Bool#>, scanFace: <#T##() -> Bool#>)
        // verifyPersonNewPlus(scanFinger: <#T##Bool#>, scanFace: <#T##Bool#>)
        verifyPersonNewPlus(scanFinger: scanFinger(), scanFace: scanFace())
    }
    
    public func run() {
        self.doSomething()
        print("my x = \(self.x)")
        
        completionHandlers.first?()
        print("my x = \(self.x)")
    }
    
    var completionHandlers: [() -> Void] = []
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandler()
        completionHandlers.append(completionHandler)
    }
    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        closure()
    }
    
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}


