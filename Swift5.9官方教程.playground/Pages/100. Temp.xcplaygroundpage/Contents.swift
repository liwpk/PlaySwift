// Apple 官方 Swift 教程


/*
    元组， 把多个值合并成单一的复合型的值。元组内的值可以是任何类型，而且可以不必是同一类型。
    它是一种数据结构，在数学中广泛应用。
    类似于数组或者字典，用于定义一组数据，组成元组类型的数据可以称为“元素”。
    在Objective-C中，要实现元组功能，只能定义一个类，添加类的属性。而在Swift中用元组就方便多了。
 */

import UIKit

// 元组的定义
let error = (1, "没有权限")
var error2 = (errCode:1, errMsg: "没有权限")           // 带元素别名的元组
 
print(error)
print(error.0)                                        // 通过 下标 访问元组中的元素
print(error2.errMsg)                                  // 通过 别名 访问元组中的元素
print(error2.errCode)

error2.errCode = 2
error2.errMsg = "权限大大的有"

let (_, errMsg) = error2
print(errMsg)


enum MyEnum {
    case one, two, three
}
class MyClass {
    var num = 0
}
// 声明一个元组常量tuple, 其类型为： (Int, MyEnum, MyClass)
let tuple: (Int, MyEnum, MyClass) = (111, MyEnum.one, MyClass())
print(tuple)

let tuple2 = (1111, (20, 0.5, true), 0)

//


let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)



