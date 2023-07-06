// Apple 官方 Swift 教程

/*:
 Swift，数据类型分为
 1. 枚举，结构体（整型，浮点型，字符串，数组，字典, 元组）    - 值类型
 2. 类，函数类型                                      - 引用类型
 3. 协议（抽象接口类型）
 4. 元组（复合类型）

 Swift 常量/变量：
    关键字 let 来声明常量，常量定义之后不能修改。
    关键字 var 来声明变量。
 */

import UIKit

// 声明常量
let maxNumberOfLoginAttempt = 5

// 声明变量
var myVariable: Int = 0
myVariable = 200

struct Point {
    var x: Int
    var y: Int
}
class Size {
    var width: Int
    var height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}
let p = Point(x: 10, y: 20)
//p = Point(x: 11, y: 11)    // error. 不可修改
//p.x = 33                  // error. 不可修改
//p.y = 44                 // error. 不可修改
// p是常量，代表p的内存是不可更改的。
// p是结构体，值类型，占用了16个字节，这16个字节都不可更改。
// p.x = 33 前8个字节不可更改。p.y = 44 后8个字节不可更改。

let s = Size(width: 10, height: 20)
//s = Size(width: 11, height: 22)  // error. 不可修改
s.width = 33
s.height = 44
// s是常量，代表s的内存是不可更改的。
// s是类，引用类型，存储的指向堆内存的内存地址，占用了8个字节，这8个字节不可更改。
// s.width = 33 , s.height = 44, 这两个是修改堆空间的内存，可以修改。

let x = 0, y = 2.0, z = "22", a = false   // 可在单行中声明多个常量或多个变量，用逗号隔开
print("x = \(x), y = \(y), z = \(z), a = \(a)")

let b = UInt8.max, c: UInt16 = UInt16.max
print("UInt8.max = \(b)")
print("UInt16.max = \(c)")         // 16位无符号整型数最大值为 65535

var welcomeMessage: String         // 当声明常量或变量时，可以加上 "类型注解", 用 : 隔开。
welcomeMessage = "Hello"

var red, green, blue: Double

// 自动类型推导
let implicitInteger = 70       // 当不写类型注解（没有显式指定类型）时，编译器可以根据初始值做“类型推导”。
let implicitDouble = 70.0      // 热键 ：option + click ，使用该热键随时查看 变量/常量 的类型。

// 整数字面量
let decimalInteger = 18
let binaryInteger = 0b10010
let octalInteger = 0o22
let hexadecimalInteger = 0x12
let scientificNum = 1.25e2
print("decimalInteger = \(decimalInteger), binaryInteger = \(binaryInteger)")
print("octalInteger = \(octalInteger), hexadecimalInteger = \(hexadecimalInteger)")
print("scientificNum = \(scientificNum)")

// 数据类型转换：不支持隐式转换，必须显式转换
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
let implicitSum = Double(implicitInteger) + implicitDouble
print("widthLabel = \(widthLabel), implicitSum = \(implicitSum)")

// 声明一个类型 别名
typealias AudioSample = UInt8
let sample: AudioSample = 32
print(sample)

typealias Date = (year: Int, month: Int, day: Int)
func printDate(date: Date) {
    print(date.0)
    print(date.month)
}
printDate(date: (2022, 2, 23))

typealias IntFn = (Int, Int) -> Int
func difference(v1: Int, v2: Int) -> Int {
    v1 - v2
}
let fn: IntFn = difference
let result = fn(400, 178)
print(result)

func setFn(_ fn: IntFn) { }
setFn(difference)
func getFn() -> IntFn {
    return difference
}

// 按照Swift标准库的定义，Void就是空元组（）
// public typealias Void = ()

// 元组， 把多个值组合成一个复合值。 元组内的值可以是任意类型，不要求是相同类型。
let http404Error:(Int, String) = (404, "Not Found")  // 一个类型为（Int, String）的元组
let (statusCode, StatusMessage) = http404Error       // 进行元组的分解
print("status code = \(statusCode), status message = \(StatusMessage)")
print("status code = \(http404Error.0)")

let http200Status = (code: 200, description: "OK")
print("http200Status code = \(http200Status.code)")

/*
 当遇到一些相关值的简单分组时，元组是很有用的。元组不适合用来创建复杂的数据结构。
 如果你的数据结构比较复杂，不要使用元组，用类或结构体去建模。
 */


// 错误处理
func canThrowAnError() throws {
    // 这个函数有可能抛出错误
}

do {
    try canThrowAnError()
    // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}

// 断言和先决条件
/**
 断言和先决条件是在运行时所做的检查。 断言仅在调试环境运行，而先决条件则在调试环境和生产环境中运行。
 */
let age = -3
//assert(age >= 0, "A person's age cannot be less than zero")   // 当age为负数时，断言被触发，终止应用

let index = -1
//precondition(index > 0, "Index must be greater than zero")


//: [Next](@next)
