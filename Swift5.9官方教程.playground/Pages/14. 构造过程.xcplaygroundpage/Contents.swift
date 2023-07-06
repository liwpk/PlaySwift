// Apple 官方 Swift 教程
/**
 构造过程是使用类、结构体或枚举类型的实例之前的准备过程。
 主要任务是保证某种类型的新实例在第一次使用前完成正确的初始化。
 类有2种初始化器：指定初始化器，便捷初始化器 convenience 。
    默认初始化器总是类的指定初始化器。
    类偏向于少量指定初始化器，一个类通常只有一个指定初始化器。
    指定初始化器必须从它的直系父类调用指定初始化器。
    便捷初始化器必须从相同的类里调用另一个初始化器。
    便捷初始化器最终必须调用一个指定初始化器。
 存储属性的初始赋值 ：
    类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
    要么在构造器中为存储属性设置初始值，要么在定义属性时分配默认值。
    设置初始值/默认值时，不会触发任何属性观察者。
 
 Swift与OC不同的是，Swift的子类默认情况下不会继承父类的构造器。
 */

import Foundation

// 构造器
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit." )

// 默认属性值
struct Fahrenheit2 {
    var temperature = 32.0
}

// 自定义构造过程
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {             // 不带实参标签的构造器
        temperatureInCelsius = celsius
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
 
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        self.red = white
        self.green = white
        self.blue = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

// 构造过程中常量的赋值、可选属性类型
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text  // 常量属性只能在构造过程中赋值。不能在子类中修改。
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()

// 默认构造器 ： 如果结构体/类为所有属性提供了默认值，又没提供任何自定义构造器，那么Swift会提供一个默认构造器
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

// 结构体的逐一成员构造器 : 用来初始化结构体新实例里成员属性的快捷方法。
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
let zeroByTwo = Size(height: 2.0)      // 调用逐一成员构造器时，可以省略任何一个有默认值的属性
print(zeroByTwo.width, zeroByTwo.height)
let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)

// 值类型的构造器代理
/**
 值类型（结构体/枚举），由于不支持继承，所以它们只能代理给自己的其他构造器。
 引用类型（类），它可以继承自其它类，这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。
 */
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init(){}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y:originY), size: size)
    }
}
let baseRect = Rect()   // 使用默认值
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

// 类的继承和构造过程
/**
 类中所有的存储型属性（包括继承来的），都必须在构造过程中设置初始值。
 Swift为类类型提供了两种构造器来确保所有存储型属性都能获得初始值：
 1. 指定构造器（主要的），必须是向上代理。
 2. 便利构造器（辅助的），必须是横向代理。
 
 为了简化指定构造器和便利构造器之间的调用关系，Swift构造器之间的代理调遵循如下三条规则：
 规则1：指定构造器必须调用其直接父类的指定构造器。
 规则2：便利构造器必须调用同类中定义的其他构造器。
 规则3：便利构造器最后必须调用指定构造器。
 【使用这一套规则保证了：使用任意构造器，都可以完整地初始化实例】
 
 Swift中类的两段式构造过程：
 阶段1：类中的每个存储型属性赋一个初始值。
 阶段2：它给每个类一次机会，在新实例准备使用之前进一步自定义它们的存储型属性。
 */

// 构造器的继承和重写
class Vehicle {     // 只为存储属性提供默认值，没有提供自定义构造器，因此，它会自动获得一个默认构造器
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init()  在这里被隐式调用
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}
let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")

// 构造器的自动继承
/**
 子类默认情况下不会继承父类的构造器。
 但如果满足条件，父类构造器是可以被自动继承的。
 */
class Food {
    var name: String
    init(name: String) {                // 指定构造器
        self.name = name
    }
    convenience init() {                // 便利构造器，必须调用 指定构造器
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShopppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "✅" : "❌"
        return output
    }
}
var breakfastList = [
    ShopppingListItem(),
    ShopppingListItem(name: "Bacon"),
    ShopppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

// 可失败构造器
let wholeNumber: Double = 12345.0
let pi = 3.1415926
if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}

let valueChanged = Int(exactly: pi)
if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")  // someCreature 的类型是 Animal? ， 而不是 Animal
if let giraffe = someCreature {
    print("An animal was initialized with species of \(giraffe.species)")
}

// 枚举类型的可失败构造器
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let unknowUnit = TemperatureUnit(symbol: "X")
if unknowUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

// 必要构造器
class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}
class SomeSubclass: SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

// 通过闭包或函数设置属性的默认值
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[row * 8 + column]
    }
}
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))
