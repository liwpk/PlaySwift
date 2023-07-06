// Apple 官方 Swift 教程

import Foundation

// 自动引用计数
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
var reference1: Person?
var reference2: Person?
var reference3: Person?
reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil       // 直到这里才会释放

// 类实例之间的循环强引用
class Person2 {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment2?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment2 {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    var tenant: Person2?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john: Person2?
var unit4A: Apartment2?

john = Person2(name: "John Appleseed")
unit4A = Apartment2(unit: "4A")
john!.apartment = unit4A
unit4A!.tenant = john       // 这两个实例关联后会产生一个循环强引用

john = nil
unit4A = nil           //  存在强引用，这两个对象无法释放（没有任何一个析构函数被调用）

// 解决 实例之间的循环强引用 ： 1.弱引用， 2.无主引用

/**
 弱引用： 不会保持所引用的实例。即使引用存在，实例也有可能被销毁。
 ARC 会在引用的实例被销毁后自动将其弱引用赋值为 nil.
 当 ARC 设置弱引用为 nil 时，属性观察器不会被触发。
 */
class Person3 {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment3?
    deinit {
        print("\(name) is being deinitialized")
    }
}
class Apartment3 {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    weak var tenant: Person3?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}
var john3 = Person3(name: "John Appleseed")
var unit4A2 = Apartment3(unit: "4A2")
john3.apartment = unit4A2
unit4A2.tenant = john3
john = nil
//unit4A2 = nil       // 由于没有循环强引用，这里会调用两个实例的析构器。

// 无主引用 ： 比弱引用有更长的声明周期 。 关键字 unowned
class Customer {
    let name: String
    var card: CreditCard?   // 一个客户可能有或者没有信用卡
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer // 一张信用卡总是关联着一个客户
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}
var tim = Customer(name: "Tim Appleseed")
tim.card = CreditCard(number: 123456788, customer: tim)
//tim = nil

// 无主可选引用
class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

let department = Department(name: "Horticulture")
let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)
intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]

// 无主引用和隐式解包可选值属性
class Country {
    let name: String
    var captitalCity: City!  // 在类型后加上感叹号，将属性声明为隐式解包可选值类型的属性
    init(name: String, capitalName: String) {
        self.name =  name
        self.captitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
 
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.captitalCity.name)")

// 闭包的循环强引用
class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)/<\(self.name)>"
        }else {
            return "<\(self.name)>"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
 
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil

// 解决闭包的循环强引用
lazy var someClosure = {
    [unowned self, weak delegate = self.delegate]
    (index: Int, stringToProcess: String) -> String in
    // 这里是闭包的函数体
}

// 弱引用和无主引用
class HTMLElement2 {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)/<\(self.name)>"
        }else {
            return "<\(self.name)>"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraph2: HTMLElement2? = HTMLElement2(name: "p", text: "hello david")
print(paragraph2!.asHTML())
paragraph2 = nil


