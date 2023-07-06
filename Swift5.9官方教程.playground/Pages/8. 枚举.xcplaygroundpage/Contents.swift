// Apple 官方 Swift 教程

/*:
 ## 枚举
 - 枚举为一组相关值定义了一个通用类型，从而可以让你在代码中类型安全地操作这些值。
 - 不像 C 和 Objective-C 那样，Swift 的枚举成员在被创建时不会分配一个默认的整数值。
 
 关键词：原始值、隐式原始值、关联值
 */

enum CompassPoint {
    case north
    case south
    case east
    case west
}
var directionToHead = CompassPoint.north
directionToHead = .west                // 这里 directionToHead 可以类型推断，为已知类型，所以赋值时可以简写。

func myFunc(direction: CompassPoint) {
    switch direction {
    case .north:
        print("Lots of planets have a north")
    case .south:
        print("Watch out for penguins")
    case .east:
        print("Where the sun rises")
    case .west:
        print("Where the skies are blue")
    }
}
myFunc(direction: directionToHead)

// 枚举成员的遍历
enum Beverage: CaseIterable {      // 通过在枚举名字后面写 : CaseIterable 来允许枚举被遍历。
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
for item in Beverage.allCases {
    print(item)
}

// 原始值 (Raw Value)
// 枚举成员可以使用相同类型的默认值预先关联，这个默认值叫做：原始值
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// 隐式原始值（Implicitly Assigned Raw Values）
// 如果枚举的原始值类型是 Int、String， Swift会自动分配原始值
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)     // 使用 rawValue 属性来访问枚举成员的原始值
        }
    }
}

if let convertedRank = Rank(rawValue: 3) {
    let ss = convertedRank.simpleDescription()
    print(ss)
}

var result = 0
for (idx, num) in [1,2,3,4,5].enumerated() {
    result += num
    if idx == 2 {
        break
    }
}
print(result)

// 关联值（Associated Values）
// 有时会将枚举的成员值跟其他类型的关联存储在一起，会非常有用。

// 定义一个叫做 Barcode的枚举类型，它要么是 (Int, Int, Int, Int)类型的关联值 upc ，要么用 String 类型的关联值 qrCode
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = Barcode.qrCode("ABCDEFGHIGKLMN")

enum Date {
    case digit(year: Int, month: Int, day: Int)
    case string(String)
}
var date = Date.digit(year: 2022, month: 2, day: 22)
date = .string("2023.3.16")
switch date {
case .digit(let year, let month, let day):
    print(year, month, day)
case let .string(value):
    print(value)
}

enum Password {
    case number(Int, Int, Int, Int)
    case gesture(String)
}
var pwd = Password.number(3,5,7,9)
pwd = .gesture("12369")

// 递归枚举
enum AritheticExpression {
    case number(Int)
    indirect case addition(AritheticExpression, AritheticExpression)
    indirect case multiplication(AritheticExpression, AritheticExpression)
}
let five = AritheticExpression.number(5)
let four = AritheticExpression.number(4)
let sum = AritheticExpression.addition(five, four)
let product = AritheticExpression.multiplication(sum, AritheticExpression.number(2))

// 操作递归枚举
func evaluate(_ expression: AritheticExpression) -> Int {
    switch expression {
    case  let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))

enum TriStateSwitch {
    case off, low, middle, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .middle
        case .middle:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()
print(ovenLight)




