// Apple 官方 Swift 教程
/**
 Swift 对于结构化的编写异步和并行代码有着原生的支持。
 异步代码可以被挂起并在之后继续执行，同一时间只能有一段代码被执行。
 并行代码指的是多段代码同时执行。比如一个拥有四核处理器的电脑可以同时执行四段代码，每个核心执行其中一项任务。
 
 Swift 中的并发模型是基于线程的，但你不会直接和线程打交道。
 当然你也可以不用 Swift 原生支持去写并发代码，只不过代码的可读性会下降。
 */

import Foundation
import UIKit

// 定义和调用异步函数 ： 异步函数或异步方法是一种能在运行中被挂起的特殊函数或方法。
func listPhotos(inGallery name: String) async throws -> [String] {
    try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
    return ["IMG001", "IMG002", "IMG003"]
}
func downloadPhoto(name imgName: String) async -> UIImage? {
    return nil
}
func show(img: [UIImage?]) {
}
let photoNames = try await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(name: name)
show(img: [photo])
/*
 listPhotos 和 downloadPhoto 函数都需要发起网络请求，需要花费较长时间完成。
 给这两个函数返回箭头前面加上 async 可以将他们定义为异步函数，从而使得这部分代码在等待
 图片的时候让程序其他部分继续运行。
 代码中被 await 标记的悬点表面当前这段代码可能会暂停等待异步方法或函数的返回。这也称为让出线程。
 */

// 异步序列
let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}

// 并行的调用异步方法
async let firstPhoto = downloadPhoto(name: photoNames[0])
async let seccondPhoto = downloadPhoto(name: photoNames[1])
async let thirdPhoto = downloadPhoto(name: photoNames[2])
let photos = await [firstPhoto, seccondPhoto, thirdPhoto]
show(img: photos)

/** 任务与任务组
任务（task）是一项工作，可以作为程序的一部分并发执行。所有的异步代码都属于某个任务。
*/
// 非结构化任务
/*
let newPhoto = ""  // 图片数据
let handle = Task {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result =   await handle.value

// 任务取消
Task.checkCancellation()
Task.isCancelled
*/
// Actors
 /**
  你可以使用任务来将自己的程序分割为孤立、并发的部分。
  任务间相互孤立，这也使得它们能够安全地同时运行。
  但有时你需要在任务间共享信息。Actors 便能够帮助你安全地在并发代码间分享信息。
  */
actor TemperatureLogger {        // actor 是引用类型
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)

// actor 内部代码在访问其属性时不需要添加 await 关键字
extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

// 可发送类型
/**
 在一个任务中，或是在一个 Actor 实例中，程序包含可变状态的部分（如变量和属性）被称为并发域。
 能够在并发域间共享的类型被称为可发送类型。 符合 Sendable协议的某个类型 为可发送类型。
 */
struct TemperatureReading: Sendable {
    var measurement: Int
}
extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}
let logger1 = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await logger1.addReading(from: reading)
