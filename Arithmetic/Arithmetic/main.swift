//
//  main.swift
//  Arithmetic
//
//  Created by Hai Ng. on 29/3/26.
//

import Foundation

func add(x: Int, y: Int) -> String {
    return "\(x) + \(y) = \(x+y)"
}

func subtract(x: Int, y: Int) -> String {
     "\(x) - \(y) = \(x-y)"
}

func multiply(x: Int, y: Int) -> String {
    return "\(x) * \(y) = \(x*y)"
}

func divide(x: Int, y: Int) -> String? {
    if y == 0 {
        return "Divide by zero error."
    } else {
        return "\(x) / \(y) = \(x/y)"
    }
}


func modulo(x: Int, y: Int) -> String? {
    if y == 0 {
        return nil
    } else {
        return "\(x) % \(y) = \(x%y)"
    }
}


func division(x: Int, y: Int) -> String? {
    let q = x / y
    let r = x % y
    
    if y == 0 {
        return nil
    } else {
        return "\(x) = \(q) * \(y) + \(r)"
    }
}

print("Arithmetic Demo")

print(add(x: 10, y: 32))
print(subtract(x: 43, y: 78))
print(multiply(x: 75, y: 43))
print(divide(x: 79, y: 29))
print(modulo(x: 92, y: 48))

print(division(x: 17, y: 3))
