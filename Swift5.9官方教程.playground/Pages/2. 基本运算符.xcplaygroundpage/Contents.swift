// Apple 官方 Swift 教程

import UIKit

let (m, n) = (5, 2)
print(m + n)
print(m - n)
print(m * n)
print(m / n)
print(m % n)      // 求余运算符 。 对负数求余时，符号会被忽略。
print(pow(5.0 , n))

// 组合运算符
var mm = 1
mm += 2
print(mm)

// 比较运算符
let b1 = (1, "zebra") < (2, "apple")
let b2 = (3, "apple") < (3, "bird")
print(b1, b2)
/**
 Swift标准库只能比较七个以内元素的元组比较函数。
 如果你的元组元素超过7个时，需要自己实现比较运算符。
 */

// 三元运算符
let str = b1 ? "这是真的" : "这是假的";
print(str)


// 空合运算符   （a ?? b) 对可选类型a 进行空判断。
// 如果 a 包含一个值就进行解包，否则就返回一个默认值 b
var str1: String?
let str2 = str1 ?? "默认值"
print(str2)

// 区间运算符
/*
    半开区间：a..<b, 表示a~b，不包括b
    闭区间：  a...b，表示a~b
 */
let range = 0...5
for i in range.reversed() {
    print(i)
}
let names = ["aa", "bb", "cc", "dd", "ee"]
for name in names[..<3] {
    print(name)
}
for name in names[...3] {
    print(name)
}

// \0到~囊括了所有可能用到的ASCII字符
let characterRange: ClosedRange<Character> = "\0"..."~"
let hasSome = characterRange.contains("G")
print("has'G'? \(hasSome)")

// 逻辑运算符
let enteredDoorCode = true
let passedRetinaScan = false
let r1 = !enteredDoorCode
let r2 = enteredDoorCode&&passedRetinaScan
let r3 = enteredDoorCode||passedRetinaScan
print(r1,r2,r3)


//: [Next](@next)
