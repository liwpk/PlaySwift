import Foundation

/**
 面向协议编程（Protocol Oriented Programming, 简称POP）
    是Swift的一种编程范式，Apple于2015年WWDC提出
    在Swift的标准库中，能见到大量POP的影子
 
 同时，Swift 也是一门面向对象的编程语言（OOP）
 在 Swift 开发中，OOP和POP是相辅相成的。 POP能弥补OOP一些设计上的不足
 
 面向协议编程的注意点：
    优先考虑创建协议，而不是父类（基类）
    优先考虑值类型（struct, enum），而不是引用类型（class）
    巧用协议的扩展功能
    不要为了面向协议而使用协议
 */


// 利用协议实现前缀效果
var string = "1234test1234"

func numberCount(_ str: String) -> Int {
    var count = 0
    for c in str {
        if ("0"..."9").contains(c) {
            count += 1
        }
    }
    return count
}
print("方法1 ： numberCount(string) = \(numberCount(string))")

extension String {
    var numberCount: Int {
        var count = 0
        for c in self where ("0"..."9").contains(c)  {
            count += 1
        }
        return count
    }
}
print("方法2 ： strong.numberCount = \(string.numberCount)")
// string.numberCount 直接扩充有可能和系统自带的成员名称冲突。

// 能否把自己扩充的成员，统一加个前缀，调用时类似这样： string.mj.numberCount
struct MJ {
    var string: String
    init(_ string: String) {
        self.string = string
    }
    var numberCount: Int {
        var count = 0
        for c in string where ("0"..."9").contains(c)  {
            count += 1
        }
        return count
    }
}
extension String {
    var mj: MJ { return MJ(self) }
}
print("方法3 ： strong.mj.numberCount = \(string.mj.numberCount)")

// 上面结构体 MJ 非常不通用，只能给字符串做扩充。
// 能否给其他类型也加上前缀进行扩充？ 能！定义结构体 MJX 泛型。
struct MJX<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol MJCompatible { }
extension MJCompatible {
    var mjx: MJX<Self> { return MJX(self) }
    static var mjx: MJX<Self>.Type { return MJX<Self>.self }
}
extension String: MJCompatible { }

// 扩展
extension MJX where Base == String {
    var numberCount: Int {
        var count = 0
        for c in base where ("0"..."9").contains(c)  {
            count += 1
        }
        return count
    }
    
    static func test() {
    }
}
print("方法4 ： string.mjx.numberCount = \(string.mjx.numberCount)")

// 如何能扩展一个类属性？ 例如 String.mjx.numberCount
// 在 String 扩展中，添加 static 属性
String.mjx.test()

/**
 总结，你想给某个类扩展一个功能：
    1. 写一个前缀结构体类型  struct MJX<Base>
    2. 定义一个协议 MJXCompatible
    3. 给协议添加扩展 前缀属性
    4. 谁想扩展功能，就让该类型 遵守 MJXCompatible 协议
    5. 给前缀结构体添加扩展，where子句为相应的类型
 */



func isArray(_ value: Any) -> Bool {
//    return value is Array<Any>
    return value is [Any]
}
isArray( [1, 2] )
isArray( ["1", 2] as [Any] )
isArray( NSArray() )
isArray( NSMutableArray() )
isArray( "112233" )

// 利用协议实现类型判断
protocol ArrayType {}
extension Array: ArrayType {}
extension NSArray: ArrayType {}
func isArrayType(_ value: Any.Type) -> Bool {
    value is ArrayType.Type
}
isArrayType( [Int].self )
isArrayType( [Any].self )
isArrayType( NSArray.self )
isArrayType( NSMutableArray.self )
isArrayType( String.self )
