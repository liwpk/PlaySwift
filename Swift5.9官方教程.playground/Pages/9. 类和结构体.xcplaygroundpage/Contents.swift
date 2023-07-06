// Apple 官方 Swift 教程

/**
 Swift中，结构体和类又很多共同点。两者都可以：
 1. 定义属性，用于存储值。
 2. 定义方法，用于提供功能。
 3. 定义下标操作，用于通过下标语法访问它们的值。
 4. 定义构造器，用于设置初始值。
 5. 通过扩展，以增加默认实现之外的功能。
 6. 遵循协议，以提供某种标准功能。

 与结构体比，类还有如下附加功能：
 1. 继承，允许一个类继承另一个类的特征。
 2. 类型转换，允许在运行时检查和解释一个类实例的类型。
 3. 析构器，允许一个类实例释放任何其所被分配的资源。
 4. 引用计数，允许对一个类的多次引用。

 类支持的附加功能是以增加复杂性为代价的。作为一般准则，优先使用结构体。
 实际上，这意味着你的大多数自定义数据类型都会是结构体和枚举。

 结构体、枚举：
 - 值类型。 当它被赋值给一个变量、常量或被传递给一个函数时，其值会被拷贝(属于深拷贝)。
 - 实际上，Swift中所有的基本类型：整数、浮点数、布尔值、字符串、数组、字典，都是值类型，其底层也是使用结构体实现的。
 
 结构体：
 在Swift 标准库中，绝大多数的公开类型都是结构体，而枚举和类只占很小一部分。
 所有的结构体都有一个编译器自动生成的初始化器。
 
 类：
 引用类型。当它被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。使用的是已存在实例的引用，而不是其拷贝。
 */


import UIKit

// 类型定义
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
let someResolution = Resolution()     // 创建结构体/类的实例
let someVideoMode = VideoMode()

// 属性访问
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

// 结构体类型的成员逐一构造器  (类没有默认的成员逐一构造器)
let vga = Resolution(width: 640, height: 480)
print("The width of vga is \(vga.width)")

// 结构体和枚举是值类型
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("hd.width = \(hd.width), cinema.width = \(cinema.width)")

// 类是引用类型
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("tenEighty.frameRate = \(tenEighty.frameRate), alsoTenEighty.frameRate = \(alsoTenEighty.frameRate)")

// 恒等运算符 ： 相同（===）， 不相同（!==）
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the save VideoMode instance.")
}

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Woof!")
    }
}
let poppy = Dog(name: "Poppy", breed: "Poodle")
poppy.makeNoise()

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
    
    override func makeNoise() {
        print("Yip!!!")
    }
}
let poppy2 = Poodle(name: "Tom")
print("name:\(poppy2.name), breed:\(poppy2.breed)")
poppy2.makeNoise()


final class SpecialDog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    deinit {
        print("\(name) is no more!")
    }
    
    func makeNoise() {
        print("I can't be inherited !")
    }
    
}
for i in 0...2 {
    let specialDog = SpecialDog(name: "DDog", breed: "SpecialDog")
    if i==1 {
        specialDog.name = "DDDDDDog"
    }
    specialDog.makeNoise()
}

// 1.结构体不能继承； 2.结构体是值类型，拷贝时是深拷贝；类是引用类型，拷贝时是浅拷贝。 3.类有析构函数



class Student: NSObject {
    static var courseCount: Int = 0          // 类属性

    var name: String? = nil                  // 属性 （存储型属性）
    var age: Int = 0
    var chineseScore = 0.0
    var mathScore = 0.0

    var averageScore: Double {               // 属性 （计算型属性, get属性，省略了get)
        return (chineseScore + mathScore) * 0.5
    }
    
    lazy var aClosure: String = {            // 属性 （存储型属性）。 注意: 这是一个闭包。
        // lazy 懒加载：第一次调用的时候执行该闭包，并在 aClosure 保存执行结果，再次调用不再执行闭包，直接返回之前计算的结果。
        print("call aclouse")
        return "hello, this is a closure."
    }()
    
    var mobile: String? {                 // 监听mobile属性的改变  (利用属性监听器 willSet & didSet)
        willSet {
            print("即将要改变手机号为：\(newValue!)")
        }
        didSet {
            print("改变了手机号为：\(mobile!)")
        }
    }
    
    // 🔼 以上都是 属性。  🔽 以下都是 方法。
    
    override init() {                       // override 重写 父类的构造函数
        print("----init()-----")            // 在构造函数中，如果没有明确调用super.init(), 那么系统会自动调用。
    }
    
    init(name: String, age: Int) {          // 构造函数
        self.name = name                    // 注意: 使用 self 来区分 name属性还是初始化器里的 name参数
        self.age = age
    }
    
    deinit {                                // 析构函数
        
    }
    
    init(dic: [String: Any]) {
        let tmpName = dic["name"]
        name = tmpName as? String           // tmpName是AnyObject?类型，这里需要转成 String?类型
        
        /*
        let tmpAge = dic["age"]
        let tmpAge2 = tmpAge as? Int
        if tmpAge2 != nil {
            age = tmpAge2!
        }
        */
        if let tmpAge = dic["age"] as? Int {      // 这一句替代上面几句
            age = tmpAge
        }
        
        // 以上代码仅仅是练习。 实际是直接调用KVC 将字典转为属性值，此时要先手动调用 super.init()
//        super.init()
//        self.setValuesForKeys(dic)
    }

    override func setValue(_ value: Any?, forKey key: String) {
        print("call setValue")
    }
    
    class func sayHi() {                           // 类方法
        print("hi swift")
    }
}


extension Student {                     // 类的动态扩展
    class func sayHaHa() {
        print("haha swift")
    }
}

Student.sayHi()
Student.sayHaHa()
Student.courseCount = 2

let p = Student()     // 通过在类名字后边添加一对圆括号来创建一个类的实例。使用点语法来访问实例里的属性和方法。
p.name = "David"
p.age = 18
p.mathScore = 59.9
p.chineseScore = 89.5

print(p.aClosure)

if let name=p.name {
    print("\(name)的平均成绩是\(p.averageScore)")
}


let s = Student(name: "Jim", age: 29)
s.mathScore = 100
s.chineseScore = 50
if let name=s.name {
    print("\(name)的平均成绩是\(s.averageScore)")
}
s.mobile = "134567890"
s.mobile = "33333333"


let s2 = Student(dic: ["name": "Jessica", "age": "34"])
if let name=s2.name {
    print("\(name)的平均成绩是\(s2.averageScore)")
}

