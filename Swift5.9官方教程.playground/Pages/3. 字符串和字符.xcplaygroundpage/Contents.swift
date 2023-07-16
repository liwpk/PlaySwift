// Apple 官方 Swift 教程

/*
 String 字符串是是值类型，在传递给方法或者函数的时候会被复制过去。
 赋值给常量或变量的时候也是一样。
 Swift编译优化了字符串使用的资源，实际上拷贝只会在确实需要的时候才会进行。
 */

import UIKit

// 多行字符串
let quotation = """
如果你需要一个字符串时跨越多行的，
那就使用多行字符串字面量： 由一对三个双引号包裹着
"""                        // 后面的三引号必须单独成行
print(quotation)

// 转义字符
let s1 = "1\n2\n3\n4\05\\6\'7\""
print(s1)
let s2 = #"1\n2\n3\n"#      // 屏蔽转义字符
print(s2)
let s3 = #"1\#n2\n3\n"#     // 屏蔽转义字符，个别的例外。
print(s3)

// Unicode 标量
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"
print(dollarSign, blackHeart, sparklingHeart)
/**
 Unicode是一个用于在不同书写系统中对文本进行编码、表示和处理的国际标准。
 它使你可以用标准格式表示来自任意语言几乎所有的字符。
 */

// 初始化空字符串
var emptyString = ""
var anotherEmptyString = String()
if emptyString.isEmpty {
    print("nothing in string！")
}
anotherEmptyString = "Hello"
anotherEmptyString += "David"

// 字符串的遍历
var str: String = "我要飞得更高"
for c in str {      // Swift的 String 是结构体 (OC的NSString是类，不支持遍历)
    print(c)
}

// 字符串的个数统计
print(str.lengthOfBytes(using: .utf8))
// 输出结果： 18  。   返回指定编码的对应的字节数量。UTF8编码(0~4个)，每个汉字是3个字节
print(str.count)
// 输出结果： 6   。   返回字符的个数。 推荐使用！

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)   // 通过字符数组来构造字符串
print("catString is \(catString)")      // 字符串的插值

// 字符串的截取
let urlStr = "www.baidu.com"
let header = urlStr.prefix(4)
print(header)
let footer = urlStr.suffix(3)
print(footer)
let aa = urlStr.hasPrefix("www")
let bb = urlStr.hasSuffix("com")
if aa && bb {
    print("this string has 'www' and 'com'")
}
let dropFirst = urlStr.dropFirst()
print(dropFirst)
let dropLast = dropFirst.dropLast()
print(dropLast)

// 字符串的range截取
func findString(string: String, subString: String) {
    guard let range = string.range(of: subString) else {
        print("没有找到字符串")
        return
    }
    print("找到\(urlStr[range])了")                 // 字符串插值
}
findString(string:urlStr, subString:"baidu")
findString(string:urlStr, subString:"xxx")

// 字符串索引
if(emptyString.startIndex == emptyString.endIndex) {
    print("string is empty.")
}
// 插入和删除
var welcome = "hello, David"
print(welcome[welcome.startIndex])
print(welcome[welcome.index(before: welcome.endIndex)])
welcome.insert("!", at: welcome.endIndex)
print(welcome)
welcome.insert(contentsOf: " Li", at: welcome.index(before: welcome.endIndex))
print(welcome)
welcome.remove(at: welcome.index(before: welcome.endIndex))
print(welcome)

// 子字符串
let substring = welcome.prefix(5)
print(substring)
/**
 使用下标或类似prefix的方法得到的子字符串是 Substring 类型
 Substring 拥有 String 的大部分方法
 Substring 可以转成 String类型
 */

let ocStr = str as NSString                 // 使用 NSString 中转
print(ocStr.length)

// 字符串的拼接
let name = "David Li"
let age = 28
let height:Double? = 1.88
let jointStr = str + " " + name
print(jointStr)
let info = "My name is \(name), age is \(age), height is \(height ?? 1.55)"
print(info)
let arr = ["hello", "world"]
print(arr.joined())
print(arr.joined(separator: "-"))

let ranges = [0...3, 5...7, 15...16]
for i in ranges.joined() {
    print(i)
}

let nestedArray = [[1,2,3], [4,5,6], [7,8,9]]
let result = nestedArray.joined(separator: [-1,-2])
print(Array(result))

// 字符串的格式化输出
let h = 8
let m = 9
let s = 6
let timeStr = "\(h):\(m):\(s)"
print(timeStr)
let timeStr2 = String(format: "%02d:%02d:%02d", h,m,s)     // String(format: )
print(timeStr2)


//: [Next](@next)
