// Apple 官方 Swift 教程

/**
 可选链式调用 是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法和下标的方法。
 如果可选值有值，则会调用成功。否则调用失败。多个调用连接在一起形成一个调用链，任何一个节点为 nil，整个调用链都会失败，即返回 nil.
 */
import Foundation

// 使用可选链式调用代替强制解包 ： 通过在想调用的属性、方法、或下标的可选值后面放一个问号（ ？），可以定义一个可选链。
class Person {
    var residence: Residence?
}

let david = Person()
//let roomCount = david.residence!.numberOfRooms   // 当 residence 为 nil 时，这段代码会触发运行时错误。
if let roomCount = david.residence?.numberOfRooms {    // 定义一个可选链
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// 在 residence 后面添加 ？之后，Swift就会在 residence 不为 nil 的情况下访问 numberOfRooms.

david.residence = Residence()
if let roomCount = david.residence?.numberOfRooms {    // 定义一个可选链
    print("david's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}


// 为可选链式调用定义模型类
// 通过使用可选链式可以调用多层属性、方法和下标。这样可以在复杂的模型中向下访问各种属性，并且判断能否访问子属性的属性、方法和下标。
class Residence {
    var rooms: [Room] = []
    var numberOfRooms: Int {         // numberOfRooms 被实现为计算属性，而不是存储属性
        return rooms.count
    }
    subscript(i: Int) -> Room {      // 提供访问 rooms 数组的快捷方式：下标
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

// 通过 可选链式调用 访问属性
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress   // 通过可选链式调用来设置属性值

// 通过 可选链式调用 来调用方法
if john.residence?.printNumberOfRooms() != nil {
    // 即使方法本身没有定义返回值，通过判断返回值是否为 nil 可以判断调用是否成功
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}

// 通过可选链式调用 访问下标
if let firstRoomName = john.residence?[0].name {        // 问号放在 方括号 的前面
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// 用 可选链式调用 给下标赋值
john.residence?[0] = Room(name: "Bathroom")       // 赋值失败。 因为 residence 为 nil

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

// 访问可选类型的下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
print(testScores)

// 连接多层 可选链式调用
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Larches Street"
john.residence?.address = johnsAddress
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

// 在方法的可选返回值上进行 可选链式调用
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's bilding identifier is \(buildingIdentifier)")
}
if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"the\".")
    } else {
        print("John's building identifier does not begin with \"the\".")
    }
}

