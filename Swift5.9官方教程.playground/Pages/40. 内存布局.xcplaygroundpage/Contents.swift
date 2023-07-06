
import Foundation

// MemoryLayout
// 可以使用MemoryLayout获取数据类型占用的内存大小

MemoryLayout<Int>.size
MemoryLayout<Int>.stride
MemoryLayout<Int>.alignment       // 内存对齐

var age = 10
MemoryLayout.size(ofValue: age)
MemoryLayout.stride(ofValue: age)
MemoryLayout.alignment(ofValue: age)

// 枚举的内存结构
enum Password {
    case number(Int, Int, Int, Int)
    case gesture(String)
}
var pwd = Password.number(3,5,7,9)
MemoryLayout.size(ofValue: pwd)      // 33, 实际用到的空间大小
MemoryLayout.stride(ofValue: pwd)    // 40, 分配占用的空间大小
MemoryLayout.alignment(ofValue: pwd) // 8,  对齐参数
// 存储4个number，用到 3*32个字节；存储gesture，用到1个字节
// 所以实际用到的总字节是33， 但由于”内存对齐“，系统会直接分配到40个字节。

enum Season {
    case spring, summer, autumn, winter
}
enum Season2: Int {
    case spring = 1, summer, autumn, winter
}
var s = Season.summer
var s2 = Season2.summer
MemoryLayout.size(ofValue: s)          // 1
MemoryLayout.stride(ofValue: s)        // 1
MemoryLayout.alignment(ofValue: s)     // 1
MemoryLayout.size(ofValue: s2)         // 1
MemoryLayout.stride(ofValue: s2)       // 1
MemoryLayout.alignment(ofValue: s2)    // 1
// 原始值枚举的内存占用只需1个字节
// 原始值是固定死的，和枚举成员永远绑定在一起的，不允许改变的。
// 关联值，每一个枚举变量允许传值，传的值都要存储在枚举变量中，所以占用内存比原始值大。
// 只有关联值才存储到枚举变量中。原始值是不存储到枚举变量中的。

/*:
 关联值型枚举的内存占用：
 - 1个字节存储成员值（存储哪个case）
 - N个字节存储关联值（N取占用内存最大的关联值）
 - 任何一个case 的关联值都共用这N个字节
 */


// 结构体的内存结构
struct Point {
    var x: Int = 0
    var y: Int = 0
    var origin: Bool = false
}
MemoryLayout<Point>.size        // 17 (8+8+1)
MemoryLayout<Point>.stride      // 24
MemoryLayout<Point>.alignment   // 8


// 类的内存结构
class Size {
    var width = 1
    var height = 2
}
MemoryLayout<Size>.size        // 8, 指针变量，占用8个字节。
MemoryLayout<Size>.stride      // 8
MemoryLayout<Size>.alignment   // 8

let size = Size()
MemoryLayout.size(ofValue: size)      // 8, 指针变量，占用8个字节。
MemoryLayout.stride(ofValue: size)    // 8. 指针变量，而不是指针变量所指向的内容。
MemoryLayout.alignment(ofValue: size)

class Point2 {
    // 存储 存指向类型信息 和 引用计数 占 16 个字节
    var x = 11      // 占 8 个字节
    var y = 22      // 占 8 个字节
    var test = true // 占 1 个字节
    func show() {
        print("x=\(x), y=\(y)")
    }
} // 16+8+8+1=33 实际使用33个字节。内存对齐后占用40个字节。malloc后分配的内容有48个字节。
var p = Point2()
print("p指向的堆内存所占空间为 48 个字节 ")
// 在 Mac/iOS中的malloc函数分配的内存大小总是16的倍数。
/**
 Point2对象本身存储在堆内存中，占用 48 个字节。
 其中，前 8 个字节储存指向类型信息的指针。
 接下来 8 个字节 存储引用计数相关内容。
 接下来 的内存空间存储对象本身的内容，加上内存对齐，16的倍数，共占用 48 个字节。
 */
class_getInstanceSize(Point2.self)  // 40
class_getInstanceSize(type(of: p))  // 40

// 返回指针变量所向内容在堆内存中占用的大小
//let contentSize = malloc_size(&size)    // 32
//print("'size' = \(contentSize)")


// 枚举、结构体、类 都可以定义方法。 方法不占用实例对象的内存空间。
// 那么方法存在哪里？ 方法、函数都存放在代码段中，而不是在实例对象的内存空间里。
func show(self: Point2) {
    print("x=\(self.x), y=\(self.y)")
}
p.show()        // 两个show方法，写到类里和 写到类外面，在内存占用方面没有区别。
show(self: p)

/**
 Mach-0: 内存地址的分配：
 代码段，放在内存前面的，内存地址较小。
 数据段，放在代码段后面，内存地址比代码段大。（全局变量）
 堆空间，放在数据段后面，内存地址比数据段大。
 栈空间，放在堆空间后面，内存地址最大。     （局部变量）
 */
