//: [Previous](@previous)

import Foundation

// 被 @objc dynamic 修饰的内容会具有动态性，比如调用方法会走RunTime那套流程

class Dog: NSObject {
    @objc dynamic func test1() {
        print("test1 called")
    }
    func test2() {
        print("test2 called")
    }
}

var d = Dog()
d.test1()
d.test2()

//: [Next](@next)
