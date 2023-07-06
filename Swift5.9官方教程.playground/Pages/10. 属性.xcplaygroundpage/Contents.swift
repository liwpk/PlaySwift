// Apple 官方 Swift 教程

/** 属性，将值与特定的类、结构体或枚举关联。
     存储属性：作为结构体/类实例的一部分，用于存储常量和变量。 可以提供默认值，也可以在初始化方法中对其进行初始化。
     计算属性：通过计算得到的属性。计算属性可用于类、结构体和枚举。存储属性只用于类和结构体。
     类型属性：直接与类型本身关联的属性称为类型属性。 存储属性/计算属性与特定类型的实例关联。
 
 必须使用 var 声明计算属性，包括只读属性，因为它们的值是不固定的。 let 只用来声明常量属性，表示初始化后再也无法修改的值。
 
 对于继承的属性，你可以在子类中通过重写属性的方式为它添加属性观察器。
 对于自定义的计算属性来说，使用它的setter监控和响应值的变化，而不是尝试创建观察器。
 */

import UIKit

// 存储属性 : 存储在特定类或结构体实例里的一个常量或变量
struct FixLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixLengthRange(firstValue: 0, length: 3)  // 常量属性必须在构造时初始化值
rangeOfThreeItems.firstValue = 6

// 常量结构体实例的存储属性
let rangeOfFourItems = FixLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue =  6   // 值类型的实例被声明为常量后，它的所有属性也变成了常量。
// 引用类型的类则不一样：把一个引用类型的实例赋给一个常量后，依然可以修改该实例的可变属性。

// 延时加载存储属性 : 避免复杂类中不必要的初始化工作。
class DataImporter {
    var fileName = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
}
let manager = DataManager()
manager.data.append("some data")
manager.data.append("some more data")
print(manager.importer.fileName)
// 由于使用了 lazy， importer 属性只有在第一次被访问的时候才被创建


// 计算属性
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + size.width/2
            let centerY = origin.y + size.height/2
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - size.width/2
            origin.y = newCenter.y - size.height/2
        }
    }
}
var square = Rect(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
let squareCenter = square.center
print("square.origin.x = \(square.origin.x), square.origin.y = \(square.origin.y)")
square.center = Point(x: 15, y: 15)   // 给计算属性赋值，相当于调用计算属性的set方法
print("After Change. square.origin.x = \(square.origin.x), square.origin.y = \(square.origin.y)")

// 简化 Setter 声明 （默认使用名称 newValue）
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + size.width/2
            let centerY = origin.y + size.height/2
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - size.width/2
            origin.y = newValue.y - size.height/2
        }
    }
}

// 简化 Getter 声明
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + size.width/2, y: origin.y + size.height/2)
        }
        set {
            origin.x = newValue.x - size.width/2
            origin.y = newValue.y - size.height/2
        }
    }
}

// 只读计算属性 （只有 getter, 没有 setter）,可以省略 get 关键字和花括号。
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

// 属性观察器 ： 监控和响应属性值的变化
class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("即将设 totalSteps 的值为 \(newValue)")
        }
        didSet {
            if totalSteps > oldValue {
                print("增加了 \(totalSteps - oldValue) 步")
            }
        }
    }
    init() {
        self.totalSteps = 100;
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 361
stepCounter.totalSteps = 562

// 属性包装器 : 属性包装器在管理属性如何存储和定义属性的代码之前添加了一个分隔层。
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get {
            return number
        }
        set {             // 确保新值小于或等于12， 而且返回被存储的值。
            number = min(newValue, 12)
        }
    }
}
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}
var rectangle = SmallRectangle()
print("rectangle.height = \(rectangle.height)")
rectangle.height = 10
print("rectangle.height = \(rectangle.height)")
rectangle.height = 20
print("rectangle.height = \(rectangle.height)")

// 这个版本将其属性明确地包装在 TwelveOrLess 结构体中，而不是把 @TwelveOrLess 作为特性写下来。
struct Smallrectangle2 {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get {
            return _height.wrappedValue
        }
        set {
            _height.wrappedValue = newValue
        }
    }
    var width: Int {
        get {
            return _width.wrappedValue
        }
        set {
            _width.wrappedValue = newValue
        }
    }
}

// 设置被包装属性的初始值
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
    
    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}
var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}
var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}
var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}
var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)             // 打印"1"
mixedRectangle.height = 20
print(mixedRectangle.height)             // 打印"12"

// 属性包装器中呈现一个值
@propertyWrapper
struct SmallNumber2 {
    private var number: Int
    private(set) var projectedValue: Bool
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    init() {
        self.number = 0
        self.projectedValue = false
    }
}
struct SomeStructure {
    @SmallNumber2 var someNumber: Int
}
var someStructure = SomeStructure()
someStructure.someNumber = 4
print(someStructure.$someNumber)
someStructure.someNumber = 55
print(someStructure.$someNumber)

func someFunction() {
    @SmallNumber var myNumber: Int = 0
    myNumber = 10    // 这时 myNumber 是 10
    myNumber = 100   // 这时 myNumber 是 12
}

// 类型属性 ： 用于定义某个类型所有实例共享的数据
struct DemoStructure {
    static var storedtypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 1
    }
}
struct DemoEnumeration {
    static var storedtypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 6
    }
}
class DemoClass {
    static var storedtypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

// 获取和设置类型属性的值
print(DemoStructure.storedtypeProperty)
DemoStructure.storedtypeProperty = "another value"
print(DemoStructure.storedtypeProperty)
print(DemoEnumeration.computedTypeProperty)
print(DemoClass.computedTypeProperty)
