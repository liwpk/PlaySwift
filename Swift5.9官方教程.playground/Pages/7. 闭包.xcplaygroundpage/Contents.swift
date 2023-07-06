// Apple 官方 Swift 教程

/**
 闭包时自包含的函数代码块，可以在代码中被传递和使用。Swift中的闭包和OC中的blocks 以及其他编程语言中的匿名函数（Lambdas）比较相似。
 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。
 闭包一般采用如下三种形式之一：
 1. 全局函数是一个有名字但不会捕获任何值的闭包。
 2. 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包。
 3. 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包。
 
 * Swift 允许我们像使用变量一样使用函数。 这意味着 可以创建一个函数，然后把它赋值给一个变量。
 * 然后使用这个变量来 执行函数，甚至作为参数传递给其他函数。
 *
 * Block是一组预先准备好代码，在需要的时候执行。通常用于回调，例如网络请求的回调等。
 * 闭包类似于Block，但应用更广。闭包是可以在你的代码中被传递和引用的功能性独立模块。
 * 1. 提前准备好的代码  2. 在需要的时候执行  3. 可以当做参数传递
 * 闭包的应用场景： 1. 异步执行完成回调  2. 控制器间回调  3. 自定义视图回调
 * 回调特点：      1. 以参数回调处理结果  2. 返回值为 void

 > 闭包表达式的一般语法形式：
    { (parameters) -> (return type) in
      statements
    }
 
 > 闭包：  一个函数和它所捕获的变量/常量环境组合起来，称为闭包。
        * 一般指定义在函数内部的函数
        * 一般它捕获的是外层函数的局部变量/常量
 */

import Foundation

let driving = {
    print("I'm driving in my car")
}
driving()

func sum(num1: Int, num2: Int) -> Int {    // sum的类型为 (Int, Int) -> Int
    return num1 + num2
}

// 1 > 定义一个常量 来记录一个函数
let ref = sum                             //  这里 ref 的类型也是  (Int, Int) -> Int

// 2 > 在需要的时候执行
print(ref(20, 30))

/**
  闭包的定义  有参数 有返回值
    闭包中，参数、返回值、实现代码 都写在 { } 中。
    使用关键字 ’in‘ 来分割定义和实现。 {(形参列表) -> (返回值类型) in 实现代码}
 */
let sumClosure = { (x: Int,  y: Int) -> (Int) in
    return x + y
}
var result = sumClosure(22,33)
print(result)

let names = ["Chris","Alex","Ewa","Barry","Daniella"]
print("names: \(names)")
let sortedNames = names.sorted { (s1: String, s2: String) -> Bool in
    return s1 < s2
}
print("sortedNames: \(sortedNames)")
let sortedNames2 = names.sorted(by: {s1, s2 in s1 < s2})
print("sortedNames2: \(sortedNames2)")
let reversedNames = names.sorted(by: {$0 > $1})  // 通过 $0 , $1 , $2 等名字来引用闭包的实际参数值。
print("reversedNames: \(reversedNames)")
let reversedNames2 = names.sorted(by: > )
print("reversedNames2: \(reversedNames2)")

let numCount = names.map { item in
    return item.count
}
print(numCount)

// 闭包的定义  无参数 无返回值
let c1 = {               // c1 的类型是 () -> ()， 如果没有参数，没有返回值，可以省略，连 in 都一起省略
    print("hello closure")
}
c1()                     // 执行闭包

// 闭包表达式的简写
func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
    print(fn(v1, v2))
}
exec(v1: 10, v2: 10, fn: {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
})
exec(v1: 10, v2: 20) { v1, v2 in
    return v1 + v2
}
exec(v1: 10, v2: 30) { v1, v2 in
    v1 + v2
}
exec(v1: 10, v2: 40) {
    $0 + $1
}
exec(v1: 10, v2: 50, fn: + )


// 尾随闭包
/**
 如果你需要将一个很长的闭包表达式作为函数最后一个实参传递给函数，使用尾随闭包将增强函数的可读性。
 尾随闭包是一个被书写在函数形式参数的括号外面（后面）的闭包表达式。
 当闭包非常长以至于不能在一行中进行书写时，尾随闭包变得非常有用。
 */

func travel(action: ()->Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

// 以下是不使用尾随闭包进行函数调用
travel(action: {
    print("I'm driving my audi");
})

// 以下是使用尾随闭包进行函数调用
travel {
    print("I'm driving my volvo");
}


let reversedNames3 = names.sorted {
    $0 > $1
}
print("reversedNames3: \(reversedNames3)")

let mapNames = names.map { (name: String) -> String in
    return "maped+\(name)"
}
print("mapNames: \(mapNames)")


// 接受多个闭包的函数
func loadPicture(from server: String, completion:()->Void, failure:()->()) {
    // ...
}

loadPicture(from: "SomeServer") {
    // completion closure
} failure: {
    // fail closure
}


// 值捕获
/**
 闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
 Swift中，可以捕获值的闭包的最简单形式时嵌套函数。也就是定义在其他函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
 */
func makeIncrementer(amount: Int) -> () -> Int {
    var total = 0
    func incrementer() -> Int {     // 嵌套函数incrementer() 从上下文中捕获了两个值： total 和 amount
        total += amount
        return total
    }
    return incrementer
}
let incrementByTen = makeIncrementer(amount: 10)    // 闭包是引用类型
print(incrementByTen())
print(incrementByTen())
print(incrementByTen())

let incrementByEleven = makeIncrementer(amount: 7)
print(incrementByEleven())
print(incrementByEleven())

// 再举个例子：
typealias Fn = (Int) -> Int

func getFn() -> Fn {
    var num = 0
    func plus(_ i: Int) -> Int {
        num += i
        return num
    }
    return plus
}  // 返回的plus和num形成了闭包

var fn = getFn()     // fn 相当于是 plus函数 + num变量
print(fn(1))
print(fn(2))
print(fn(3))
print(fn(4))
/**
 fn 存放着什么？
    1. 如果plus函数内部 不访问外部变量，则 fn 存放着plus函数地址。
    2. 若 plus函数内部 访问了外部的 num变量， 则 num 将被放入堆空间，从而延长了 num的生命周期。
       调用一次getFun()，就 alloc 一块堆空间。
       所以这种情况下，fun 存放的是 plus函数地址 + 堆空间地址。
    3. fn 占用16个字节：
        前8个字节放plus函数的地址；后8个字节放堆空间的地址。如果没有堆空间，则后8个字节是0。
 闭包：
    可以把闭包想象成一个类的实例。
    内存在堆空间。
    捕获的局部变量/常量就是对象的成员属性。
    组成闭包的函数就是类内部定义的方法。
 */

// 逃逸闭包
/**
 * 当一个闭包作为参数传递到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。
 * 当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
 *
 */

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)        // 接收一个闭包作为实际参数并且添加它到声明在函数外部的数组里
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomeThing() {
        someFunctionWithEscapingClosure {
            self.x = 100              // 让闭包 @escaping 意味着你必须在闭包中显式地引用 self
        }
        someFunctionWithNonescapingClosure {
            x = 200                   // 非逃逸闭包，可以隐式地引用 self 。
        }
    }
}
let instance = SomeClass()
instance.doSomeThing()
print(instance.x)
completionHandlers.first?()
print(instance.x)


// 自动闭包
/**
 * 自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。
 * 这种闭包不接受任何实际参数，并且当它被调用时，它会返回内部打包的表达式的值。
 * 这个语法的好处在于 能够省略闭包的花括号，用一个普通的表达式来替代显式的闭包。
 * 自动闭包允许你延迟处理，因此闭包内部的代码直到你调用它的时候才会运行。对于有副作用或占用资源的代码来说很有用。
 * @autoclosure 只支持 () -> T 格式，无参数，有返回值。
 * 空合并运算符 使用了 autoclosure 技术。
 */

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
let customerProvider = {
    customersInLine.remove(at: 0)
}
print(customersInLine.count)
print("Now serving \(customerProvider())!")
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )

// 另一个版本： 不使用明确的闭包而是通过 @autoclosure 标志标记它的形式参数使用了自动闭包。
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve2(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve2(customer: customersInLine.remove(at: 0))         // 实际参数自动地转换为闭包


// 自动逃逸闭包:  让一个自动闭包“逃逸”
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print(customersInLine.count)


var functions: [() -> Int] = []
for i in 1...3 {
    func myFunc() -> Int {
        return i
    }
    functions.append(myFunc)
//    functions.append { i }      // 也可以这样简写
}
for f in functions {
    print("\(f())")
}
