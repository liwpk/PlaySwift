//: [Previous](@previous)

import Foundation

// 动态方法查找, 动态方法调用
@dynamicMemberLookup
@dynamicCallable
class CustomData {
    var name: String = ""
    var age: Int = 0
    subscript(dynamicMember member: String) -> String {
        return "unknow"
    }
    subscript(dynamicMember member: String) -> Int {
        return 0
    }
    func dynamicallyCall(withArguments arg: [String]) {
        print("unknow func: \(arg)")
    }
    func dynamicallyCall(withKeywordArguments paris: KeyValuePairs<String, Int>) {
        let res = paris.map { key, value in
            return "[\(key):\(value)]"
        }.joined(separator: " ")
        print(res)
    }
}
let obj = CustomData()
print(obj.name)
let str1: String = obj.other // 访问了不存在的属性，就会根据指定的属性类型调用对应的subscript方法来返回对应类型的值
let num1: Int = obj.num
print(str1, num1)            // 输出 unknow 0

obj("字符串参数", "A", "B")。  // unknow func: ["字符串参数", "A", "B"]
obj(a:1, b:2)                // [a:1] [b:2]
//

