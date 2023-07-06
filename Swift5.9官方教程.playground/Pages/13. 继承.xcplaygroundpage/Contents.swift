// Apple 官方 Swift 教程
/**
 继承 ： Swift中，继承是区分“类”与其他类型的一个基本特征。
        可以为类中继承来的属性添加属性观察器，这样当属性值改变时，类就会被通知到。
 重写 ： 子类可以为继承来的实例方法、类方法、实例属性、类属性、下标提供自己定制的实现。
 防止重写 ： final
        属性、方法、下标，标记为 final 来表示不可被重写。
        类，标记为 final，表示不可被继承。
 */


import Foundation

// 定义一个基类 ： 继承于其他类的类，称之为基类。
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour."
    }
    func makeNoise() {
        //
    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

// 子类生成
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")

// 重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()

// 重写属性
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

// 重写属性观察器
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")


