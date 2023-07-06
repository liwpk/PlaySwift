import Foundation

public typealias Task = () -> Void

public struct Async {
    // 异步
    public static func async(_ task: @escaping Task) {
        _async(task)
    }

    public static func async(_ task: @escaping Task, mainTask: @escaping Task) {
        _async(task, mainTask)
    }

    private static func _async(_ task: @escaping Task, _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    // 异步延时
    public static func asyncDelay(_ seconds: Double, task: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task)
    }
    
    public static func asyncDelay(_ seconds: Double, task: @escaping Task, mainTask: @escaping Task) -> DispatchWorkItem  {
        _asyncDelay(seconds, task, mainTask)
    }

    private static func _asyncDelay(_ seconds: Double, _ task: @escaping Task, _ mainTask: Task? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}
