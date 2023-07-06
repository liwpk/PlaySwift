import UIKit

// 位运算符：可以操作数据结构中每个独立的比特位。通常被用于底层开发中，比如图形编程和创建设备驱动。
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits      // ～ 按位取反运算符

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits  // & 按位与运算符

let someBits: Int8 = 0b10110010
let moreBits: Int8 = 0b01011110
let combinedBits = someBits | moreBits        // | 按位或运算符

let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits        // ^ 按位异或运算符

let shiftBits: UInt8 = 4
shiftBits << 1
shiftBits >> 2

let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent 是 0xCC
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent 是 0x66
let blueCpmponent = (pink & 0x0000FF)         // blueCpmponent 是 0x99

// 溢出运算符 ： &+ ， &- ， &*
var unsignedOverflow = UInt8.max             // unsignedOverflow  255
unsignedOverflow = unsignedOverflow &+ 1     // unsignedOverflow  0

unsignedOverflow = UInt8.min
unsignedOverflow = unsignedOverflow &- 1     // unsignedOverflow 255

// 运算符函数 : 类和结构体可以为现有的运算符提供自定义的实现。这通常被称为运算符重载。
struct Vector2D {
    var x = 0.0, y = 0.0
}
extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}
extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
let negativeVector = -vector

// 等价运算符： 自定义的类和结构体没有对等价运算符进行默认实现。需要提供自定义实现，并遵循Equatable协议
extension Vector2D: Equatable {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
}
if vector == anotherVector {
    print("These two vectors are equivalent.")
} else {
    print("These two vectors are NOT equivalent.")
}

// 结果构造器



class Animal {}
class Fish: Animal { }
class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
let pets = [Fish(), Dog(), Fish(), Dog()]
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

// Swift 默认情况下不允许在数值运算中出现溢出情况。但你可以使用Swift的溢出运算符来实现溢出运算。

/*
 溢出运算符
    通常情况下，当向一个整数赋超过它容量的值时，Swift会报错（而不是生成一个无效的数），给我们操作过大/过小的数时候提供了额外的安全性。
    同时，swift提供了三个溢出运算符来让系统支持整数溢出运算：
        溢出加法   &+
        溢出减法   &-
        溢出乘法   &*
 */
var x: UInt8 = 255
x = x &+ 1
print(x)            // 0

var y: UInt8 = 0
y = y &- 1
print(y)            // 255

var i: Int8 = -128
i = i &- 1
print(i)            // 127


/*
 位运算符
    取反运算符 ~
    与运算符 &
    或运算符 |
    异或运算符 ^
    位左移运算符 <<
    位右移运算符 >>
 */
let a: UInt8 = 6
let b: UInt8 = 1
print(~b)
print(a & b)
print(a | b)
print(a ^ b)
print(a << 1)                       //  位左移/右移具有给整数乘以/除以2 的效果。 具体的，左移1位，相当于乘以2； 右移1位，相当于除以2
print(b << 3)

/*
 有符号整数的位移操作
    有符号整数使用它的第一位（也就是符号位）来表示这个整数是整数还是负数。符号位为 0 表示整数， 1 表示负数。 其余的位数（也就是数值位）存储了实际的值。
    负数的存储方式略有不同：它存储的是2的n次方减去它的绝对值。这里的n为数值位的位数。即补码表示。
 */
// 应用1：不使用第三个变量，交换两个变量的值
var num1 = 10, num2 = 8
num1 = num1 ^ num2
num2 = num1 ^ num2
num1 = num1 ^ num2
print(num1, num2)

// 应用2：求无符号整数二进制中1的个数（算法尽可能高效）
func countOfOne(n: UInt) -> UInt {
    var count: UInt = 0
    var temp = n
    while temp > 0 {
        count = count + temp & 1
        temp = temp >> 1
    }
    return count
}
print(countOfOne(n: 7))
print(countOfOne(n: 16))

// 应用2引申问题：如何判断一个整数为2的整数次幂
func isPowerOfTwo(num: UInt) -> Bool  {
    return (num & (num - 1)) == 0
}
print(isPowerOfTwo(num: 256))
print(isPowerOfTwo(num: 1023))


// 自定义运算符
