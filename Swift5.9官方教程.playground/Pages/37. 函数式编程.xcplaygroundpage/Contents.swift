//: [Previous](@previous)

import Foundation

/**
 函数式编程（Functional Programming, 简称 FP）
    是一种编程范式，也就是如何编写程序的方法论
    主要思想：把计算过程尽量分解成一系列可复用函数的调用
    主要特征：函数是“第一等公民”
            即，函数与其他数据类型一样的地位，可以赋值给其他变量，也可以作为函数参数、函数返回值
 
 函数编程中几个常用的概念：
    Higher-Order Function （高阶函数）
    Function Currying  （函数柯里化）
    Functor  （函子）
    Applicative Functor  （适用函子）
    Monad   （单子）
 */


// ================ 传统写法 （不使用函数式编程） ================

// 假设要实现以下功能： [(num + 3) * 5 - 1] % 10 / 2
var num = 1

func add(_ a: Int, _ b: Int) -> Int { a + b }
func sub(_ a: Int, _ b: Int) -> Int { a - b }
func multiple(_ a: Int, _ b: Int) -> Int { a * b }
func divide(_ a: Int, _ b: Int) -> Int { a / b }
func mod(_ a: Int, _ b: Int) -> Int { a % b }

var result = divide(mod(sub(multiple(add(num, 3), 5), 1), 10), 2)
print("result = \(result)")


// ================ 函数式写法 ================
func add(_ a: Int) -> (Int) -> Int {    // 改为只接收 1 个参数 , 返回一个函数（ 柯里化 ）
    return {
        $0 + a
    }
}
result = add(3)(num)   // 函数式写法：先接收1个参数，再接收1个参数；传统写法：一次接收2个参数
print(result);

let fn = add(3)
print(fn(5), fn(7), fn(10))    // 思想：把计算过程尽量分解成一系列可复用函数的调用

// 同理，可以把接收 3 个参数的函数，转成接收 1 个参数的函数。（ 柯里化 ）
func sum(_ a: Int, _ b: Int, _ c: Int) -> Int { a + b + c }
result = sum(1, 2, 3)
print("传统写法，sum2 = \(result)")

func sum(_ a: Int) -> (Int) -> (Int) -> Int {
    return { x in
        let tmp = a + x
        return { y in
            tmp + y
        }
    }
}
result = sum(1)(2)(3)
print("函数式写法，sum = \(result)")

func sub(_ a: Int) -> (Int) -> Int { {$0 - a} }
func multiple(_ a: Int) -> (Int) -> Int { {$0 * a} }
func divide(_ a: Int) -> (Int) -> Int { {$0 / a} }
func mod(_ a: Int) -> (Int) -> Int { {$0 % a} }
// 函数式写法，实现功能： [(num + 3) * 5 - 1] % 10 / 2
let fn1 = add(3)
let fn2 = multiple(5)
let fn3 = sub(1)
let fn4 = mod(10)
let fn5 = divide(2)
result = fn5(fn4(fn3(fn2(fn1(num)))))
print("result = \(result)")

// 函数合成
func composite(_ f1: @escaping (Int) -> Int, _ f2: @escaping (Int) -> Int) -> (Int) -> Int {
    return { x in
        f2(f1(x))
    }
}
let comFn = composite(fn1, fn2)
print("comFn(num) = \(comFn(num))")

// 更直观的办法：定义一个运算符 >>>
infix operator >>> : AdditionPrecedence
func >>> <A, B, C>(_ f1: @escaping (A) -> B, _ f2: @escaping (B) -> C) -> (A) -> C {
    return { f2(f1($0)) }
}

let compositeFn = add(3) >>> multiple(5) >>> sub(1) >>> mod(10) >>> divide(2)
result = compositeFn(num)
print("compositeFn result = \(result)")


// ================ 高阶函数 ================
/**
 高阶函数是至少满足一下一个条件的函数：
    接受一个或多个函数作为输入
    返回一个函数
 函数式编程，到处都是高阶函数。
 
 什么是柯里化（Currying）？
    将一个接受 多参数的函数 变换为一系列只接受 单个参数的函数。
 */

// 将下面函数柯里化
func calculate(_ a: Int, _ b: Int, operator oper: String) -> Int {
    switch oper {
    case "+":
        return a + b
    case "-":
        return a - b
    case "*":
        return a * b
    case "/":
        return a / b
    default:
        return 0
    }
}
print(calculate(22, 33, operator: "+"))
print(calculate(44, 33, operator: "-"))

func calculate(operator oper: String) -> (Int) -> (Int) -> Int {
    return { a in
        return { b in
            switch oper {
            case "+":
                return a + b
            case "-":
                return a - b
            case "*":
                return a * b
            case "/":
                return a / b
            default:
                return 0
            }
        }
    }
}
let addFn = calculate(operator: "+")
print(addFn(10)(20))
let mulFn = calculate(operator: "*")
print(mulFn(10)(20))
let mulTenFn = mulFn(10)
print(mulTenFn(30))
let subFn = calculate(operator: "-")
print(subFn(30)(20))


// 自动柯里化函数
func currying<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
    return { b in
        return { a in
            return fn(a, b)
        }
    }
}
func currying<A, B, C, D>(_ fn: @escaping (A, B, C) -> D) -> (C) -> (B) -> (A) -> D {
    { c in { b in { a in fn(a, b, c) } } }
}

prefix func ~<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
    { b in { a in fn(a, b) } }
}
prefix func ~<A, B, C, D>(_ fn: @escaping (A, B, C) -> D) -> (C) -> (B) -> (A) -> D {
    { c in { b in { a in fn(a, b, c) } } }
}

let curry_add = currying(add(_:_:))
print(curry_add(111)(222))

let curry_calculate = currying(calculate)
let addFunction = curry_calculate("+")
print(addFunction(112)(222))
let subFunction = curry_calculate("-")
print(subFunction(112)(222))

// 函数式写法，实现功能： [(num + 3) * 5 - 1] % 10 / 2
var number = 1
var function = (~add)(3) >>> (~multiple)(5) >>> (~sub)(1) >>> (~mod)(10) >>> (~divide)(2)
print("function = \(function(1))")

// ================ 函子（Functor） ================
/**
 像 Array, Optional 这样支持map运算的类型，称为函子。
 怎么样的Type才能称之为函子？
    拥有map这样的运算。
    Array<Element>
    public func map<T>(_ transform: (Element) -> T) -> Array(T)
    Optional<Wrapped>
    public func map<U>(_ transform: (Wrapped) -> U) -> Optional(U)
 */

/*
class Person<T> {
    var age: Int = 0
    func map<T>(_ fn: (Int) -> T) -> Person<T> {
        
    }
}
*/


// ================ 适用函子（Applicative Functor） ================
/**
 对于任意一个函子F，如果能支持以下运算，则该函子就是一个适用函子。
    func pure<A>(_ value: A) -> F<A>
    func <*><A, B>(fn: F<(A) -> B>, value: F(A>) -> F<B>
 */


// ================ 单子（Monad） ================
/**
 对于任意一个类型F，如果能支持以下运算，那么久可以称为是一个单子。
    func pure<A>(_ value: A) -> F<A>
    func flatMap<A, B>(_ value: F<(A), _ Fn: F<B>) -> F<B>
 */
