/*:
 函数重载
 - 函数名相同
 - 参数个数不同||参数类型不同||参数标签不同
 
 返回值类型与函数重载无关
 */

import Foundation

func sum(v1: Int, v2: Int) -> Int {
    v1 + v2
}

func sum(v1: Int, v2: Int, v3: Int) -> Int {   // 参数个数不同
    v1 + v2 + v3
}

func sum(v1: Double, v2: Double) -> Double {
    v1 + v2
}

func sum(a: Int, b: Int) -> Int {
    a + b
}

sum(v1: 11, v2: 22)
sum(v1: 11, v2: 22, v3: 33)
sum(v1: 1.1, v2: 2.2)
sum(a: 12, b: 12)


/*:
 内联函数
 - 如果开启了编译器优化（release模式默认会开启优化），编译器会自动将某些函数变成内联函数。
 - 将函数调用展开成函数体。
 */

//: [Next](@next)
