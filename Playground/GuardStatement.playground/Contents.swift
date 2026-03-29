import UIKit

let x1: Bool = true
let x2: Bool = false

func guardExample(expr: Bool, str: String) {
    print("Welcome")
    guard (expr) else {
        /// execute this closure if expr == false
        print("We are here because the expression \(str) was false. \n")
        return
    }
    print("Have a nice day. \n")
}

guardExample(expr: x1, str: "x1") /// true
guardExample(expr: x2, str: "x2")
guardExample(expr: 1 + 1 == 3, str: "1 + 1 == 3")
guardExample(expr: 1 + 1 == 2, str: "1 + 1 == 2") /// true

print("\n\nIn other words guard..else only executes the else block if the first expression is false.")

