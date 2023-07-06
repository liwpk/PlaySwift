// Apple 官方 Swift 教程

/**
 Swift 的集合类型有三种： 数组Array、字典Dictionary、集合Set。
 数组是有序数据的集。 集合是无序数据的集。 字典是无序的键值对的集。
 
 数组：
    一个数组使用有序列表存储同一类型的多个值。
 数组的定义： OC 使用 [ ] 定义数组， Swift也一样， 只是没有 @ 符号
 
 集合Set：
    一个集合不允许出现两个完全相同的元素。
    一个集合中的数据元素是无序的。
    只有遵循Hashable协议类型的对象才能作为集合的元素。必须提供一个方法来计算它的哈希值。
 集合的定义： OC 使用 [ ]
 
 字典Dictionary：
    一个字典不允许出现两个完全相同的键Key。
    一个字典中的键值对元素是无序的。
    只有遵循Hashable协议类型的对象才能作为字典的键Key。
 字典的定义： OC 使用 { }，  Swift 使用 [ ] 。 Swift定义数组也是 [ ]，Swift定义集合也是 [ ]
 */

import UIKit

// ======================================================================================
// 数组
let emptyArray: [String] = []                       // 创建空数组，必须携带类型信息。
let chars = Array("David Li")
print(chars)

// 用初始化器 来创建数组。 使用初始化器有两种方式：
var myArray = [String]()
var myArray2 = Array<String>()
myArray.append("A1")
myArray.append("A2")
myArray2.append("B1")
myArray2.append("B2")
myArray2.append("B3")
print(myArray, myArray2)

// 用初始化器参数 来创建数组：
var threeDoubles = Array(repeating: 0.0, count: 3)                // 使用默认值创建数组
print(type(of: threeDoubles))
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles
print(sixDoubles)
var threeInts = [Int](0...7)
print(threeInts)

var arr = ["小张", "小王", "小李"]            // 自动推导的结果 [String] ，表示数组中存放的都是 String
print(arr)

let arr3:[Any] = ["David", 29, CGPoint(x: 10, y: 20)]           // 也可以不限类型Any，不常用。
print(arr3)


// 数组的遍历， 几种遍历方法：
// 1. 按照下标遍历
for i in 0..<arr.count {
    print("aaa \(arr[i])")
}
// 2. for in 遍历元素
for s in arr {
    print("bbbbbb \(s)")
}

arr.forEach { (str) in
    print("cccccccc \(str)")
}

var it = arr.makeIterator()
while let str = it.next() {
    print("ddddddddddd \(str)")
}

for i in arr.indices {
    print("the index is \(i), value is \(arr[i])")
}

// 3. enum block 遍历， 同时遍历下标和内容1
for e in arr.enumerated() {            // e 的数据类型 ： 元祖 (offset: Int, element: String)
    print(e)
    print("\(e.offset) \(e.element)")
}
// 4. 遍历下标和内容2
for (n, s) in arr.enumerated() {
    print("\(n) \(s)")
}
// 5. 反序遍历
for s in arr.reversed() {
    print(s)
}
// 6. 反序索引和内容
for (n, s) in arr.reversed().enumerated() {            //  错误的反序，索引和内容不一致
    print("\(n) \(s)")
}
for (n, s) in arr.enumerated().reversed() {            //  正确的反序， 先枚举，后反序！！！
    print("\(n) \(s)")
}


// 数组的 增、改、删
arr.append("老朱")
arr.append(contentsOf: ["David","Eric","Jim"])
print(arr)
arr[1] = "老王"
print(arr)
arr.insert("插入元素", at:2)
arr.insert(contentsOf: ["插入多个元素1","插入多个元素2","插入多个元素3"], at: 3)
print(arr)
arr.remove(at: 2)
print(arr)
arr.removeFirst()
print(arr)
arr.removeLast(3)
print(arr)
arr.removeSubrange(1...3)
print(arr)
arr.removeLast()
print(arr)
arr.removeAll(keepingCapacity: true)                   // 删除所有元素，并保留数组容量
print("\(arr) \(arr.capacity)")
print(arr.popLast() as Any)


// 数组合并
var aa = ["111","222","333"]
let bb = ["444","555","666"]
aa += bb                                               // 注意： 要合并数组的两个类型必须一致
print(aa)

let reversArr = aa.reversed()
print(reversArr)
for i in reversArr {
    print(i)
}

// 获取数组切片ArraySlice （得到的切片依然和原数组共享内存。 只有在修改元素值的时候，会拷贝一份出来）
let slice = aa.prefix(3)
print(type(of: slice), slice)
print(aa.prefix(upTo: 4))
print(aa.suffix(from: 4))
print(aa.dropFirst())
print(arr.shuffled())       // 数组元素的随机化

// 关于数组的容量： 当插入元素时，如果容量不够，会在当前容量的基础上 * 2 （乘以二），也就是容量会翻倍增加(1,2,4,8,16,32,...)

var numArray = [10,20,45,30,98,101,30,4]
// 判断数组是否包含某元素
print(numArray.contains(30))
print(numArray.contains(where: {$0 < 3}))

// 判断所有元素符合某个条件 ： allSatisfy
print(numArray.allSatisfy({$0 > 3}))

// 查找元素： first , last,
print(numArray.first!)
print(numArray.last ?? 0)
print(numArray.first(where: {$0 > 30})!)
print(numArray.last(where: {$0 > 30})!)
print(numArray.firstIndex(of: 9) as Any)
print(numArray.lastIndex(where: {$0 > 30}) as Any)
print(numArray.min() as Any)
print(numArray.max() as Any)

let errors = [(12, "aa"),(22, "bb"),(94, "cc"),(52, "xx")]
print(errors.min(by: { (a, b) -> Bool in
    a.0 < b.0
}) as Any)
print(errors.max(by: { (a, b) -> Bool in
    a.0 < b.0
}) as Any)


// ======================================================================================
// 集合
var letters = Set<Character>()       // 用初始化器语法来声明一个空的集合。

var s: Set<Int> = [1, 3, 5, 7, 9]    // 用数组来声明一个集合，必须显式声明类型Set，否则会自动推导为数组Array
print(s.count)
print(s)
s.insert(8)
s.remove(9)
s.insert(7)
print(s.isEmpty)
print(s.sorted())
for num in s.sorted() {          // 为了按照特定顺序来遍历一个集合中的值可以使用sorted()方法。
    print(num)
}

var course: Set = ["Math", "English", "History"]
print(course.contains("English"))

// 集合的可哈希性
struct Person {
    var name: String
    var age: Int
}

/**
 你可以使用自定义的类型作为集合值的类型或者是字典键的类型，但需要使用自定义类型遵循Swift标准库中的Hashable协议。
 */
extension Person: Hashable {
    func hash(info hasher: inout Hasher) {
        hasher.combine(name)
    }
}

//extension Person: Equatable {
//    static func == (lhs: Person, rhs: Person) -> Bool {
//        return lhs.name == rhs.name
//    }
//}

var persons: Set<Person> = [Person(name: "David", age: 18), Person(name: "Eric", age: 22)]
persons.update(with: Person(name: "David", age: 38))
persons.update(with: Person(name: "Cook", age: 60))
print(persons)
print(persons.filter({$0.age > 30}))

// 集合的操作：  并集、交集、差集、补集
let setA: Set<Character> = ["A","B","C"]
let setB: Set<Character> = ["C","E","F"]
print(setA.intersection(setB))                  // 交集
print(setA.union(setB))                         // 并集
print(setA.symmetricDifference(setB))           // 差集
print(setA.subtracting(setB))                   // 相对补集

let bigSet: Set<Character> = ["A","B","C"]
let smallSet: Set<Character> = ["A","B"]
print(smallSet.isSubset(of: bigSet))
print(smallSet.isStrictSubset(of: bigSet))
print(smallSet.isDisjoint(with: bigSet))

// 算法示例： 给定一个集合，求这个集合所有的子集
func getSubsets<T>(_ set: Set<T>) -> Array<Set<T>> {
    let count = 1 << set.count
    let elements = Array(set)
    var subsets = [Set<T>]()
    for i in 0..<count {
        var subset = Set<T>()
        for j in 0..<elements.count {
            if ((i >> j) & 1) == 1 {
                subset.insert(elements[j])
            }
        }
        subsets.append(subset)
    }
    return subsets
}
let set: Set = ["A","B","C"]
for subset in getSubsets(set) {
    print(subset)
}

// ======================================================================================
// 字典

let emptyDictionary = [String: Float]()     // 字典的定义

var dic: [String : Any] = ["name": "David Li", "age": 18]
                               // 字典是通过 KEY 来定位值的， KEY 必须是可以 ‘hash 哈希’ ， MD5一种
                               // hash 就是将字符串变成唯一的‘整数’，便于查找，提高字典的遍历速度。
// 定义一个数组，数组元素为字典
var dataArray:[[String : Any]] = [["name": "David", "age":18], ["name": "Jim", "age":28]]
print(dataArray)

print(dic.count)
print(dic.isEmpty)

// 字典的 增、改、删
print(dic)
dic["height"] = 1.88
print(dic)
dic["height"] = 1.77
print(dic)
dic.removeValue(forKey: "height")
print(dic)

var mergedictionary = ["a":1, "b":2]
mergedictionary.merge(["a":11, "c":3]) { (current, _) in current }
print(mergedictionary)
mergedictionary.merge(["c":33, "d":4]) { (_, new) in new }
print(mergedictionary)

// 字典的遍历
for e in dic {                              // e 的数据类型是 元祖  (key: String, value: Any)
    print("key=\(e.key), value=\(e.value)")
}
for (key, value) in dic {                   // 前面是 KEY， 后面是 VALUE， 具体的名字可随便
    print("\(key),\(value)")
}
for dicKey in dic.keys {
    print("key=\(dicKey)")
}
for dicValue in dic.values {
    print("value=\(dicValue)")
}

// 字典的合并  字典合并不能像Array那样相加，即使类型一致也不能相加合并。
let dic2:[String: Any] = ["address":"tian fu zhi guo", "mobile":13512341234]
for e in dic2 {
    dic[e.key] = e.value
}
print(dic)
