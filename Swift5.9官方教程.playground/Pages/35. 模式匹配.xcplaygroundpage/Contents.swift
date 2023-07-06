// 模式代表单个值或者复合值的结构。
/*:
 ## 模式分类
 * 通配符模式， 有一个下划线 ‘_’ 构成，用于匹配并忽略任何值。
 * 标识符模式， 匹配任何值，并将匹配的值和一个变量或常量绑定起来。
 * 值绑定模式， 把匹配到的值 绑定给一个变量或常量。
 * 元组模式，   由逗号分隔的，具有零个或多个模式的列表，并由一对圆括号括起来。
 * 枚举用例模式
 * 可选项模式
 * 类型转换模式, 有两种类型转换模式：is 模式 和 as 模式。is模式只出现在switch语句中的case标签中。
    * is模式 仅当一个值的类型在运行时和 is模式右边的指定类型一致，或是其子类的情况下，才会匹配这个值。
    * as模式 仅当一个值的类型在运行时和 as模式右边的指定类型一致，或是其子类的情况下，才会匹配这个值。
 * 表达式模式, 代表表达式的值，只出现在switch 语句中的 case标签中。
    * 自定义类型默认是无法进行表达式模式匹配的，需要重载 ~= 运算符。
 */

import UIKit

for _ in 1...3 {                                // 通配符模式
    print("hello")
}


let point = (3, 2)
switch point {
case let (x, y):                                // 值绑定模式。 将 point 中的元素绑定到 x 和 y
    print("the point is at (\(x), \(y).")
}


let points = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]
for (x, y) in points where y == 0 {                     // 元组模式
    print("\(x) and \(y)")
}


let someOptional: Int? = 42                             // 可选项模式
if case .some(let x) = someOptional {
    print(x)
}
if case let x? = someOptional {
    print(x)
}


protocol Animal {                                       // 类型转换模式
    var name: String { get }
}
struct Dog: Animal {
    var name: String {
        return "dog"
    }
    var runSpeed: Int
}
struct Bird: Animal {
    var name: String {
        return "bird"
    }
    var flightHeight: Int
}
struct Fish: Animal {
    var name: String {
        return "fish"
    }
    var depth: Int
}

let animals: [Any] = [Dog(runSpeed: 40), Bird(flightHeight: 9000), Fish(depth: 200)]
for animal in animals {
    switch animal {
    case let dog as Dog:
        print("\(dog.name) run at \(dog.runSpeed)")
    case let fish as Fish:
        print("\(fish.name) swim in \(fish.depth)")
    case is Bird:
        print("bird can fly")
    default:
        break
    }
}


struct Employee {                                           // 表达式模式
    var salary: Int
}
func ~= (left: ClosedRange<Int>, right: Employee) -> Bool {
    return left.contains(right.salary)
}


var e: Employee = Employee(salary: 2000)
switch e {
case 0...1000:
    print("吃不饱")
case 1000...5000:
    print("能活下去了")
case 5000...10000:
    print("还不错")
default:
    print("高薪阶层")
}


