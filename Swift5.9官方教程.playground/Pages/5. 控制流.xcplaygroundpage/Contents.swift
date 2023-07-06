// Apple 官方 Swift 教程

/* 【if语句】
 1. 条件不需要圆括号（）， 语句必须有大括号 {}
 2. 判断语句不再有非0、nil即真，判断语句必须有明确的真假（true、false）
 3. guard守卫 swift2.0新增的。和if非常类似
 
 guard 条件表达式 else {
    //条件表达式为false，会执行这里的代码。 否则执行下面的语句组。
    break
}
 语句组

 */

import UIKit

// For-In 循环
for i in 0..<3 {                        //  注意： 传统的for循环在 Swift3.0 被取消。  i++/ ++i 在 Swift3.0 被取消。
    print("开区间："+String(i))
}

for i in 0...3 {
    print("闭区间："+String(i))
}

for _ in 0..<3 {                            // i 从来没有被用到， 建议使用 _ 替代， 相当于 忽略 每一项。
    print("hello world")
}

for i in stride(from:0, to:100, by:12) {
    print(i)
}

let range1 = 0..<3                      //  [0, 3)
let range2 = 0...3                      //  [0, 3]


let test = "helLo"
let interval = "a"..."z"
for c in test {
    if !interval.contains(String(c)) {
        print("\(c) 不是小写字母")
    }
}

let range3 = 0.0...3.0
if range3.contains(2.9) {
    print("2.9 in range3")
}

for i in range2.reversed() {                 // 反序遍历 ， reversed()
    print("反序遍历："+String(i))
}

// While 循环
var a = 3
while a>0 {
    print("while循环："+String(a))
    a = a-1
}

// swift中，do-while 要写成 repeat-while
repeat {
    print("do while循环："+String(a))
    a = a+1
} while a<3

// 条件语句 if
let score = 93
if score<60 {
    print("不及格")
}else {
    print("哎哟，不错哦")
}

let m = 20
let n = 30
let big = m>n ? m : n
print(big)

func online(age: Int) -> String {
    guard age>=18 else {                    // guard 语句，类似于 if 语句，基于布尔值表达式来执行语句。
        return "年龄太小，不可以上网"             // guard 的 else 分句里的代码会在条件不为真的时候执行。
    }
    return "可以上网"
}
print("20岁了，" + online(age: 20))
print("14岁了，" + online(age: 14))

// if let
func demo2() {
    let name: String? = "David"
    let age: Int? = 28
    // if let 可以设置数值，进入分支后，可以保证一定有值。 注意 if let 语句中不能使用 && || 条件
    if let name = name, let age = age {
        print("Mr "+name+" is "+String(age))
    }
}
demo2()

// guard ,  是和 if let 相反的指令
func demo3() {
    let name: String? = "TOM"
    let age: Int? = 38
    guard let t1 = name else {
        print("name is nil")
        return
    }
    guard let t2 = age else {
        print("age is nil")
        return
    }
    print("Mr "+t1+" is "+String(t2))               // 使用 guard 会让嵌套层次少一层。
}
demo3()

// 条件语句 switch
/* 【switch语句】
 1. switch 可以针对任意类型的值进行分支，不再局限在整数。（OC 的 switch 只能判断整数）
 2. switch 没有隐式贯穿，也就是不需要写 break。
    默认自动break。想要贯穿到下一case判断语句，使用 fallthrough。
 3. switch语句必须是完备的。必须保证能够处理所有情况。
 
 Swift 的 switch语句 支持：区间匹配、元祖匹配、值绑定、where子句
 */
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":                  // 多值匹配，使用 ','来分割。
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}


let score2 = 93
switch score2 {
case 0..<60:                                // 区间匹配
    print("不及格")
case 60..<80, 80..<90:
    print("及格 或者 良好")
case 90...100:
    print("哎哟，不错哟")
default:
    print("什么鬼？")
}


let point = CGPoint(x: 10, y: 10)
switch point {
case let p where p.x == 0 && p.y == 0:      // case内的where语法
    print("原点")
case let p where p.x == 0:
    print("Y轴")
case let p where p.y == 0:
    print("X轴")
case let p where abs(p.x) == abs(p.y):
    print("对角线")
default:
    print("其他")
}

let somePoint = (1, 1)   // 元组的匹配。 使用下划线 _ 来表明匹配所有可能的值。
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    // 值绑定。 将匹配到的值临时绑定为一个常量或者变量，来给情况的函数体使用。
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    // case let (x,y) ，声明了一个带有两个占位符常量的元组，它可以匹配所有的值。
    print("somewhere else at (\(x), \(y))")
}

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    // 使用 where 分句来检查额外的约束。只有 where 分句为 true 时才会匹配这个值。
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

// 控制转移语句： continue, break, fallthrough, return, throw

// 检查API可用性
if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}
