//
//  main.swift
//  Compound Assigment
//
//  Created by Hai Ng. on 29/3/26.
//

import Foundation

print("Compound operators")
//
//var x = 2
//print(x)
//
//// x = x + 1
//x += 1
//print(x)
//
//// x = x - 1
//x -= 1
//print(x)

// Exmaple:
// 1. Calculate the n-th element of an arithmetric progression.
// 2. Calculate the n-th element of an geomatric progression.
// 3. Calculate the sum of the elements a1, ... , an of an arithmetric progression.
// 4. Calculate the sum of the elements a1, ... , an of an gromatric progression.

/// Compute the n-th element in the sequnce: a1, a1 + d, a1 + 2d, a1 + 3d, ...
/// For example: The third element in the sequence
/// 1,4,7,10,13,...
/// is the number 7
/// - Parameters:
///     - a1: The first element in the sequence/progression
///     - d: Difference/distance between consecutive elements
///     - n: Position
/// - Returns: The n-th element of the arithmetic prgression

func arithmeticProgression(a1: Double, d: Double, n: Int) -> Double {
    a1 + Double((n - 1)) * d
}

for n in 1...10 {
    print(arithmeticProgression(a1: 0.5, d: -0.75, n: n))
}

// Calculate 1+4+7+10 = (if n=4, a1=1, d=3)
func sumArithmeticProgression(a1: Double, d: Double, n: Int) -> Double? {
    if n < 0 {
        return nil
    }
    
    var sum: Double = 0
    
    for i in 1...n {
        sum +=  arithmeticProgression(a1: a1, d: d, n: i)
    }
    
    return sum
}

print("Sum testing func 'sumArithmticProgression'")

func printSumArithmeticProgression(a1: Double, d: Double, n: Int) {
    if let sum = sumArithmeticProgression(a1: a1, d: d, n: n) {
        print(sum)
    } else {
        print("Invalid argument, n must be positive.")
    }
}

printSumArithmeticProgression(a1: 1, d: 3, n: 4)
printSumArithmeticProgression(a1: 1, d: 3, n: -1)

// a1, a1*q, a1*q^2, a1*q^3,...
//3, 3/2,3/4,3/8,3/16,...
func geometricProgression(a1: Double, q: Double, n: Int) -> Double {
    a1 * pow(q, Double(n - 1))
}

func sumGeometricProgression(a1: Double, q: Double, n: Int) -> Double? {
    if n <= 0 {
        return nil
    }
    var sum: Double = 0
    
    for i in 1...n {
        sum += geometricProgression(a1: a1, q: q, n: i)
    }
    
    return sum
}

print(sumGeometricProgression(a1: 1, q: 3, n: 4) ?? 4)


func evenProduct(n: Int) -> Int? {
    if n <= 0 {
        return nil
    }
    
    var product = 1
    
    for i in 1...n {
        product *= 2 * i
    }
    
    return product
}

if let product = evenProduct(n: 0) {
    print(evenProduct(n: 0) ?? 1)
} else {
    print("Invalid input, n must be positive.")
}
