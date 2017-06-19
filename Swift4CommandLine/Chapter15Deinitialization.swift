//
//  Chapter15Deinitialization.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/16.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter15Deinitialization: NSObject {
    static public func run() {
        // Deinitialization
        // (1) How Deinitialization Works
        // (2) Deinitializers in Action
        
        // Deinitialization
        // A deinitializer is called immediately before a class instance is deallocated. You write deinitializers with the deinit keyword, similar to how initializers are written with the init keyword. Deinitializers are only available on class types.
        // Typically you don’t need to perform manual cleanup when your instances are deallocated. However, when you are working with your own resources, you might need to perform some additional cleanup yourself. For example, if you create a custom class to open a file and write some data to it, you might need to close the file before the class instance is deallocated.
        // At most one deinitializer per class
        /*
        deinit {
            // perform the deinitialization
        }
         */
        // You are not allowed to call a deinitializer yourself. Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation. Superclass deinitializers are always called, even if a subclass does not provide its own deinitializer.
        
        // Deinitializers in Action
        var player: BankPlayer? = BankPlayer(coins: 1000)
        player!.win(coins: 600)
        print("Bank: \(Bank.coinsInBank), Player: \(player!.coinsInPurse)")
        // Bank: 9400, Player: 1600
        
        player = nil
        print("Bank: \(Bank.coinsInBank)")
        // Bank: 11000
    }
}

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class BankPlayer {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = coins
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}
