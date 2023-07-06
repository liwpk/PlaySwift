// Apple 官方 Swift 教程

import Foundation

/**
 内存访问的冲突会发生在你的代码尝试同时访问同一个存储地址的时候。
 */

// In-Out参数的访问冲突
var stepSize = 1
func increment(_ number: inout Int) {
    number += stepSize
}
//increment(&stepSize)     // 错误： stepSize 访问冲突（读访问和写访问冲突了）

// 解决这个冲突的一种方式，是显式拷贝一份 stepSize
var copyStepSize = stepSize
increment(&copyStepSize)
stepSize = copyStepSize    // 更新原来的值

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)     // 正常
//balance(&playerOneScore, &playerOneScore)     // 错误：访问冲突


// 方法里 self 的访问冲突
struct Player {
    var name: String
    var health: Int
    var energy: Int
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}
var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // 正常
//oscar.shareHealth(with: &oscar)   // 错误，访问冲突

// 属性的访问冲突
var playerInformation = (health: 10, energy: 20)
//balance(&playerInformation.health, &playerInformation.energy) // 错误，属性访问冲突
