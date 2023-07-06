/**
 多态： 父类指针指向 子类对象
 多态的实现原理：
 1. OC：Runtime
 2. C++：虚表（虚函数表）
 3. Swift 和 C++ 类似
 
 */
import Foundation


class Animal {
    func speak() {
        print("Animal speak")
    }
    func eat() {
        print("Animal eat")
    }
    func sleep() {
        print("Animal sleep")
    }
}

class Dog : Animal {
    override func speak() {
        print("Dog speak")
    }
    override func eat() {
        print("Dog eat")
    }
    func run() {
        print("Dog run")
    }
}

var anim: Animal

anim = Animal()
anim.speak()
anim.eat()
anim.sleep()

anim = Dog()
anim.speak()
anim.eat()
anim.sleep()

// 由于结构体不存在继承，不存在重写，所以调用结构体的方法时，编译完就确定了。
// 类有继承，有方法重写，有多态，所以要在运行时才能确定调用哪个方法。
