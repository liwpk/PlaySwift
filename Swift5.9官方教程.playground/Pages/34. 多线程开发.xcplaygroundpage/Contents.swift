//: [Previous](@previous)

import Foundation

// =========== 多线程开发 - 异步 ===========

// 在主线程执行代码
DispatchQueue.main.async {
    print(Thread.current, " ----- run in main thread")
}

// 在子线程执行代码
DispatchQueue.global().async {
    print(Thread.current, " ----- run in other thread")
}


let item = DispatchWorkItem {
    print(Thread.current, " ----- 1")
}
DispatchQueue.global().async(execute: item)


// =========== 多线程开发 - 延迟 ===========

let time = DispatchTime.now() + 2
DispatchQueue.main.asyncAfter(deadline: time, execute: item)


// =========== 封装起来，方便使用 ===========
Async.async {
    print(Thread.current, " ----- Async.async 1")
} mainTask: {
    print(Thread.current, " ----- Async.async 2")
}

let workItem: DispatchWorkItem = Async.asyncDelay(3) {
    print(Thread.current, " ----- Async.asyncDelay 1")
} mainTask: {
    print(Thread.current, " ----- Async.asyncDelay 2")
}
// 拿到 workItem 有什么用？ 中途可取消。 workItem.cancel()


// =========== 多线程开发 - once ===========
class Person {
    static var age: Int = getAge()
    static func getAge() -> Int {     // 默认自带 lazy + dispatch_once 效果
        print("this code only run once.")
        return 0
    }
    
    func test() {
        let _ = Self.age
    }
}
let p = Person()
p.test()
p.test()
p.test()


// =========== 多线程开发 - 线程安全 - 加锁 ===========

public struct Cache {
    private static var data = [String: Any]()
//    private static var lock = DispatchSemaphore(value: 1) // 同时只能有 1 条线程访问
//    private static var lock = NSLock()
    private static var lock = NSRecursiveLock()         // 递归锁。防止递归调用时死锁。
    
    public static func get(_ key: String) -> Any? {
        data[key]
    }
    public static func set(_ key: String, _ value: Any) {
//        lock.wait()
//        difer { lock.signal() }

        lock.lock()
        defer { lock.unlock() }
        
        data[key] = value
    }
}
// 对于 全局变量，只有一份内存。如果有多条线程同时调用Cache写入操作，是很危险的。
