/*:
 函数的嵌套
 - 函数可以内嵌，内嵌的函数可以访问外部函数里的变量。
 - 通过使用内嵌函数来组织代码，来避免某个函数太长或者太过复杂。
 */

import Foundation


func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()


func forward(_ forward: Bool) -> (Int) -> Int {
    func next(_ input: Int) -> Int {
        input + 1
    }
    func previous(_ input: Int) -> Int {
        input - 1
    }
    return forward ? next : previous
}
forward(true)(3)     // 这样避免外界直接访问 next/previous 函数
forward(false)(2)

//: [Next](@next)
