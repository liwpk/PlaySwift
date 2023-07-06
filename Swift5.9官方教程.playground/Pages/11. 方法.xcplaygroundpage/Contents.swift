// Apple 官方 Swift 教程
/**
 方法是与某些特定类型相关联的函数。

 类、结构体、枚举都可以定义实例方法。 实例方法为给定类型的实例封装了具体的任务与功能。
 类、结构体、枚举都可以定义类型方法。 类型方法与类型本身相关联。
 */


import UIKit
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()


// 在实例方法中修改值类型
/**
 结构体/枚举是值类型，默认情况下，值类型的属性不能在它的实例方法中被修改。
 但是，如果确定要修改，可以在该方法前面加 可变(mutating)行为，从而允许属性。
 */
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at \(somePoint.x), \(somePoint.y)")

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
print(ovenLight)
ovenLight.next()
print(ovenLight)

// 类型方法 ： 定义在类型本身上调用的方法。 在方法func关键字前加 static 。 类还可以用class指定，从而允许子类重写父类的类方法的实现。
class SomeClass {
    class func someTypeMethod() {
        // 在这里实现类型方法
    }
}
SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unLock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

// 下面，Player 类使用 LevelTracker 来监控和更新每个玩家的发展进度：
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unLock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "David")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Bob")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}


