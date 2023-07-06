/*:
 可选项（Optional）
 - 可选项，一般也叫可选类型，它允许将值是设置为nil
 - 在类型名称后面加个问号 ？ 来定义一个可选项
 - 可选项是对其他类型的一层包装，可以将它理解为一个盒子
 
 可选类型的取值：
     空值（nil）
     有值（具体某数据类型）

 ??运算符：对于可选型数据，经常会用到 ?? 运算符。 aa??"xx"  表示 aa如果为nil,则用xx替代。
 */

import Foundation

// 可选类型
var serverResponseCode: Int? = 404
serverResponseCode = nil

var age: Int?      // 默认就是 nil
age = 10
age = nil

// 可选绑定
var someOptional: String? = "hello"
if let unwrapped = someOptional {
    print("1: \(unwrapped.count) letters")
}
if let someOptional = someOptional {
    print("2: \(someOptional.count) letters")
}
if let someOptional {
    print("3: \(someOptional.count) letters")
}

enum Season: Int {
    case spring = 1, summer, autumn, winter
}
let s = Season(rawValue: 6)
if var season = s {
    switch season {
    case .spring:
        print("the season is spring")
    default:
        print("the season is not spring")
    }
}else {
    print("no such season")
}


// if-let 多optional值绑定
var obj1: Int? = 1
var obj2: Int? = 2
if let tmp1 = obj1, let tmp2 = obj2, tmp1 < tmp2 {
    print("tmp1 < tmp2")
}
obj1 = nil
if let c = obj1 ?? obj2 {
    print(c)
}

let possibleNumber = "123"
if var actualNumber = Int(possibleNumber) {
    actualNumber = actualNumber + 1
    print("possiblenumber has an integer value of \(actualNumber)")
}else {
    print("possiblenumber value is \(possibleNumber)")
}

// guard 语句
func greet(name: String?) {
    guard let unwrapped = name else {      // 特别适合用来 ”提前退出“
        print("You didn't provide a name!")
        return
    }
    print("Hello, \(unwrapped)")
}
// 当使用guard语句进行可选项绑定时，绑定的常量/变量也能在外层作用域中使用。
// 而 if let 可选项绑定 无法在作用域之外使用。

var name: String?
greet(name: name)
print(name ?? "Anonymous")       // 空合并运算符

name = "David"
greet(name: name)
print(name ?? "Anonymous")

// 强转
let str = "5"
let num = Int(str)      // 强转后是可选类型
print(type(of: num))    // Optional<Int>
let num2 = Int(str)!
print(type(of: num2))   // Int

let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()



//: [Next](@next)
