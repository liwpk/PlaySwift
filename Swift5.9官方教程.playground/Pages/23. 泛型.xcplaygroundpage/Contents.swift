// Apple 官方 Swift 教程
/**
    泛型：用来表达一种未定的数据类型。
         将类型参数化，提高代码复用率，减少代码量。
    泛型是Swift最强大的特性之一，很多Swfit标准库是基于泛型代码构建的。
 */
import Foundation


var someInt = 3
var anotherInt = 107
func swapIntValue(_ a: inout Int, _ b: inout Int) {
    (a, b) = (b, a)
}
swapIntValue(&someInt, &anotherInt)
print(someInt,anotherInt)

// 泛型函数, 函数名后面的尖括号 告诉编译器那个 T 是 swapTwoValues 函数定义内的一个“占位类型名”
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
swapTwoValues(&someInt, &anotherInt)
print(someInt,anotherInt)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print(someString,anotherString)

// 类型参数 ： 类型参数指定并命名一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来。可以使用多个泛型，用逗号分隔。


// 泛型类型
// 1. 非泛型版本的栈 （Int型的栈）
struct IntStack {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
var myIntStack = IntStack()         // 创建一个栈
myIntStack.push(55)
myIntStack.push(66)
print("myIntStack pop item: \(myIntStack.pop())")

// 2. 泛型版本的栈 : 基本上和IntStack相同，只是用占位类型参数 ItemType 替代了实际的 Int 类型。
struct MyStack<ItemType> {
    var items: [ItemType] = []           // 内部有关元素类型的操作，都是用 ItemType
    mutating func push(_ item: ItemType) {
        items.append(item)
    }
    mutating func pop() -> ItemType {
        return items.removeLast()
    }
}
// 整型栈
var myIntStack2 = MyStack<Int>()         // 创建一个 Int 类型的栈
myIntStack2.push(22)
myIntStack2.push(33)
print("myIntStack pop item: \(myIntStack2.pop())")

// 字符串栈
var myStringStack = MyStack<String>()   // 创建一个 String 类型的栈
myStringStack.push("uno")
myStringStack.push("dos")
myStringStack.push("tres")
myStringStack.push("cuatro")
let fromTheTop = myStringStack.pop()
print("From the top : \(fromTheTop)")

// 为 MyStack 栈类型添加一个扩展
extension MyStack {
    // 为其添加一个方法，直接使用泛型 ItemType 即可
    var topItem: ItemType? {              // 添加一个 topItem 的只读计算型属性
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = myStringStack.topItem {
    print("The top item on the stack is \(topItem).")
} else {
    print("The stack is empty.")
}

/**
    对泛型进行约束：
    Swift语言中，可以通过两种方式对泛型进行约束：
        1. 通过继承基类或遵守协议来进行约束
        2. 通过Where子句来进行约束
 */
class MyClass { }
// 只有 MyClass 的类或其子类才可以成为 MyStackB 栈中的元素
struct MyStackB<ItemType: MyClass> {
    var items: [ItemType] = []           // 内部有关元素类型的操作，都是用 ItemType
    mutating func push(_ item: ItemType) { items.append(item) }
    mutating func pop() -> ItemType { return items.removeLast() }
}
var myClassStack = MyStackB()
myClassStack.push(MyClass())
myClassStack.push(MyClass())
myClassStack.pop()

protocol MyProtocol { }
// 只有 遵守类 MyProtocol 协议的类型，才能作为 MyStackC 栈中的元素
struct MyStackC<ItemType: MyProtocol> {
    var items: [ItemType] = []           // 内部有关元素类型的操作，都是用 ItemType
    mutating func push(_ item: ItemType) { items.append(item) }
    mutating func pop() -> ItemType { return items.removeLast() }
}
// 定义一个遵守 MyProtocol协议的类
class MyClassP: MyProtocol { }
var myProtocolStack = MyStackC<MyClassP>()
myProtocolStack.push(MyClassP())
myProtocolStack.push(MyClassP())
myProtocolStack.pop()


// 关联类型（Associated Type）: 定义一个协议时，声明一个或多个关联类型作为协议定义的一部分将会非常有用
protocol ContainerB {
    associatedtype ItemType                 // 直到实现协议时，才指定类型
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStackB: ContainerB {
    // IntStack 的原始实现部分
    var items: [Int] = []
    mutating func push(_ item: Int) { items.append(item) }
    mutating func pop() -> Int { return items.removeLast() }
    
    // Container 协议的实现部分
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

// 让泛型 MyStackD 结构体遵循 ContainerB 协议：
struct MyStackD<ItemType>: ContainerB {
    // MyStackD<ItemType> 的原始实现部分
    var items: [ItemType] = []
    mutating func push(_ item: ItemType) { items.append(item) }
    mutating func pop() -> ItemType { return items.removeLast() }
    // Container 协议的实现部分
    mutating func append(_ item: ItemType) { self.push(item) }
    var count: Int { return items.count }
    subscript(i: Int) -> ItemType { return items[i] }
}

// 给关联类型添加约束
protocol ContainerC {
    associatedtype Item: Equatable
    mutating func add(_ item: Item)
}

// 在关联类型约束里使用协议
protocol SuffixableContainer: ContainerC {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

//extension MyStackD: SuffixableContainer {
//    func suffix(_ size: Int) -> MyStackD {
//        var result = MyStackD()
//        for index in (count-size)..<count {
//            result.append(self[index])
//        }
//        return result
//    }
//    // 推断 suffix 结果是 Stack
//    typealias ItemType = Item
//    mutating func add(_ item: Item) {
//        self.push(item)
//    }
//}
var stackOfInts = MyStackD<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)


// 泛型 Where 语句 ： 类型约束让你能够为泛型函数、下标、类型的类型参数定义一些强制要求
class MyClassTC<T,C> where T:BinaryInteger, C:BinaryInteger {
    var param1: T
    var param2: C
    init(param1: T, param2: C) {
        self.param1 = param1
        self.param2 = param2
    }
}
let myObjTC = MyClassTC(param1: 11, param2: 22)
print(myObjTC)



// 包含上下文关系的 where 分句

// 具有泛型 Where 子句的关联类型
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

// 泛型下标
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int {
        var result: [Item] = []
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

