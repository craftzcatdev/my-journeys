import Foundation

print("Let's talk about data types.")
print("TOPIC: Int, Double, Float, \"Type of\"")

var a: Int = 10
a = a + 1
print(a)
a += 20
print(a)

var b = 100
var c = 100.0
print("Type of 'b' is \(type(of: b)).")
print("Type of 'c' is \(type(of: c)).")

var d: Float = 100.0
print("Type of 'd' is \(type(of: d)).")

print("Largest interger is \(Int.max).")
print("Smallest interger is \(Int.min).")

print("Largest Double is \(Double.greatestFiniteMagnitude)")
print("Smallest Double is \(Double.leastNormalMagnitude)")

//MARK: - Devision
print("Devision")
print(7 / 2)
print(7.0 / 2)
print(7 / 2.0)
print(7 / Double(2))

let x = 112
let quotient = x / 5
let reminder = x % 5
let _reminder = x.remainderReportingOverflow(dividingBy: 5)

print("\(x) = 5 * \(quotient) + \(reminder)")

for devisor in 1..<10 {
    let reminder = x % devisor
    print("\(x)  = \(devisor) * \(quotient) + \(reminder)")
}


func divisionAlgorithm(x: Int, devisor: Int) -> String {
    let result: String
    let remainder = x % devisor
    let quotient = x / devisor
    
    if remainder == 0 {
        result = "\(x) = \(devisor) * \(quotient)"
    } else {
        result = "\(x) = \(devisor) * \(quotient) + \(remainder)"
    }
    
    return result
}

for devisor in 1..<9 {
    print(divisionAlgorithm(x: 112, devisor: devisor))
}
