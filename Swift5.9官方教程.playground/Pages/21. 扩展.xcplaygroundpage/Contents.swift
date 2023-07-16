// Apple 官方 Swift 教程
/**
    扩展, 可以给一个现有的数据类型（类、结构体、枚举、协议）追加新的功能。 但是不能重写已经存在的功能。
    它还拥有不需要访问被扩展类型源代码就能完成扩展的能力（即逆向建模）。
 */

import UIKit
// 计算型属性 ： 扩展可以给现有类型添加计算型实例属性和计算型类属性。
extension Double {
    var km: Double { return self * 1000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
/**
    扩展添加新的 计算属性 ，但是它们 不能添加存储属性，或向现有的属性添加属性观察器。
 */



struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
// 因为 Rect 结构体所有的属性都提供了默认值，所以它自动获得了一个默认构造器和一个成员构造器：
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

// 扩展添加构造器
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - size.width/2
        let originY = center.y - size.height/2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

// 扩展添加方法
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let num = 5
print(5.squared())

extension Int {
    func isEven() -> Bool {
        return self % 2 == 0
    }
}

// 扩展添加下标
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self/decimalBase) % 10
    }
}
print(234234534[0])
print(234234534[1])
print(234234534[4])

// 扩展添加协议：使用扩展让某个类遵守一个协议
protocol MyProtocol {
    func myFunc();
}
extension Int: MyProtocol {   // 如果使用扩展使某个数据类型遵守了一个协议，那么在此扩展中就需要实现该协议中的方法
    func myFunc() {
        print("myFunc")
    }
}
var iii = 333;
iii.myFunc()

// 嵌套类型
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

// Protocol extensions

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        for name in self {
            print(name)
        }
    }
}
pythons.summarize()
beatles.summarize()


// Protocol-oriented programming

protocol Identifiable {
    var id: String { get set }
    func identify()
}
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}
struct User: Identifiable {
    var id: String
}
let twoStraws = User(id: "twostraws")
twoStraws.identify()


protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}


extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 7
    }
}

let i = 100.simpleDescription
print(i)


/**
 默认情况下，扩展是无法添加存储属性的。因为存储属性涉及到类的内存分配，扩展是无法修改类的内存分配的。
 但是，可以通过关联对象给类扩展添加存储属性。
 */
class Person {}
extension Person {
    private static var AGE_KEY: Void?
    var age: Int {
        get {
            objc_getAssociatedObject(self, &Self.AGE_KEY) as! Int
        }
        set {
            objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
var p1 = Person()
p1.age = 10
var p2 = Person()
p2.age = 20
print(p1.age, p2.age)
