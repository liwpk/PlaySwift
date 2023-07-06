// Apple 官方 Swift 教程

/**
 函数的调用方式的变迁：
    Swift 1.0 ：sum(222, 444),     所有的形参都会省略
    Swift 2.0 ：sum(222, y: 444),  第一个形参省略
    Swift 3.0 ：sum(x: 222, y: 444)
 
 形参只能是 let
 */

import UIKit

// 函数的定义与调用
func about() {                                              // 无参数，无返回值
    print("iPhone Xs Max. about 1")
}
about()

func callPhone(num: String, name: String) -> String {       // 有参数，有返回值
    return "\(name)给\(num)打电话"
}
let str = callPhone(num:"10086", name:"David")
print(str)

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, avarage: Int)? {    // 有多个返回值
    if scores.isEmpty {
        return nil
    }
    
    var currentMin = scores[0]
    var currentMax = scores[0]
    var sum = 0
    for score in scores {
        if score > currentMax {
            currentMax = score
        } else if score < currentMin {
            currentMin = score
        }
        sum += score
    }
    return (currentMin, currentMax, sum / scores.count)
}
if let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9, 22, 45, 89, 1, 12, 30, 55]) {
    print("数列 [5, 3, 100, 3, 9, 22, 45, 89, 1, 12, 30, 55] 当中，")
    print("最小数：",statistics.min)
    // 因为元组的成员值在函数定义中的返回类型部分被命名，所以它们可以通过使用点语法取出最大值和最小值。
    print("最大数：",statistics.max)
    print("平均数：",statistics.2)      // 元组中的元素可以通过名字或者数字调用
}

// 隐式返回的函数 : 如果一个函数的整个函数体是一个单行表达式，这个函数可以隐式地返回这个表达式。
func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}
print(greeting(for: "David Li"))

func goToWork(at time: String) {        // 注意 at / time 的使用 （外参 和 形参）
    print("the time is \(time)")
}
goToWork(at: "10:00")

// 函数参数标签和参数名称 : 默认情况下，函数参数使用参数名称来作为它的参数标签。
func welcome(name: String, from hometown: String) -> Void {
    // 指定参数标签：在提供形式参数名之前可以写一个参数标签，用空格分隔。
    print("welcome \(name), he is from \(hometown)")
}
welcome(name: "David", from: "USA")

// 函数的默认参数
// 给参数设置默认值， 在调用的时候， 可以任意组合参数， 如果不指定的， 就使用默认值。
func sum(num1: Int = 1, num2: Int = 2) -> Int {
    return num1+num2
}
let result2 = sum(num1: 4, num2: 8)
print(result2)

let result3 = sum(num2: 4)
print(result3)

let result5 = sum()
print(result5)

// 函数的外部参数         num1,num2: 外部参数就是在 形参前面加一个名字 。   外部参数不会影响函数内部细节，仅是让外部调用方看起来更加直观。
func sum2(num1 x: Int, num2 y: Int) -> Int {
    return x + y
}
let result6 = sum2(num1: 22, num2: 33)
print(result6)

func sum3(_ x: Int, _ y: Int) -> Int {     // 外部参数如果使用 _ , 在外部调用函数时，会忽略形参的名字
    return x + y
}
let result7 = sum3(44, 33)
print(result7)

// 可变参数
func sum4(nums: Int...) -> Int {           // 通过在变量类型后门加入 ... 的方式来定义可变参数
    var result = 0
    for i in nums {
        result += i
    }
    return result
}
print(sum4(nums: 1,2,3,4))
print(sum4(nums: 1,2,3,4,5))


// 输入输出参数： 如果你想函数能够修改一个形式参数的值，而且想这些改变在函数结束之后依然生效，那么就需要将形式参数定义为输入输出形式参数。
func swapNum(m: inout Int, n: inout Int) {                // inout 关键字， 传入指针
    let tmp = m
    m = n
    n = tmp
}
var m = 20, n = 30
print("m=\(m),n=\(n)")
swapNum(m: &m, n: &n)               // 在传参时候，直接在它前边 添加一个符号 & 来明确可以被函数修改。
print("m=\(m),n=\(n)")


// 函数类型
/**
 Swift中，每个函数都有类型： ()->() , 引用类型，可以很方便地将函数作为参数/返回值来使用。
 函数是一等类型，所以函数本身也可以作为值来 传入、返回， 也能声明一个某个函数类型的变量。
 */

// 声明一个函数变量
var addFunc: (Int, Int) -> Int
// 对函数变量进行赋值
addFunc = { (param1: Int, param2: Int) -> Int in return param1 + param2}
// 调用函数变量
addFunc(2222, 3333)

// 函数类型作为返回值
func makeIncrementer() -> ((Int) -> Int) {      // 函数可以将 另一个函数作为 值 来返回。
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment: (Int) -> Int = makeIncrementer()
print(increment(7))

func addTwoNumber(a: Int, b: Int) -> Int {
    return a+b
}
var mathFunction: (Int, Int) -> Int = addTwoNumber   // 定义变量
print(mathFunction(111,222))


func printMathResult(_ aFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    let result = aFunction(a, b)
    print(result)
}
printMathResult(addTwoNumber, 333, 444)

// 函数类型作为参数
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {     // 函数可以将 另一个函数作为 参数 来传入。
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
let hasMatchs1 = hasAnyMatches(list: numbers, condition: lessThanTen)
let hasMatchs2 = hasAnyMatches(list: numbers) { num in
    return num > 30
}
print(hasMatchs1, hasMatchs2)

let mappedNumbers = numbers.map({                                // 函数其实就是闭包的一种特殊形式：一段可以被随后调用的代码块。
    (number: Int) -> Int in
    let result = 3 * number
    return result
})
print(mappedNumbers)

let mappedNumbers2 = numbers.map({number in 10 * number})   // 当一个闭包作为函数最后一个参数出入时，可以直接跟在圆括号后边。
print(mappedNumbers2)

let sortedNumbers = numbers.sorted{$0 > $1}                 // 如果闭包是函数的唯一参数，你可以去掉圆括号直接写闭包。
print(sortedNumbers)

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)                  // 函数和闭包都是引用类型
print(incrementByTen())
print(incrementByTen())
let incrementByEleven = makeIncrementer(forIncrement: 11)
print(incrementByEleven())
print(incrementByEleven())
print(incrementByTen())
print(incrementByEleven())
let alsoIncrementByTen = incrementByTen
print(alsoIncrementByTen())


/// testtt函数文档文档注释
///
/// 将两个整数相加（更详细的描述）
///
/// - Parameter v1: 第一个参数
/// - Parameter v2: 第二个参数
/// - Returns: 2个整数的和
///
/// - Note: 传入两个整数即可（批注）
///
func testtt(v1: Int, v2: Int) -> Int {
    v1 + v2
}

testtt(v1:  222, v2: 333)  // option键+该函数，会显示上面的函数注释


