// Apple 官方 Swift 教程
/**
 Swift在运行时提供了抛出、捕获、传递和操作可恢复错误的一等支持。
 */

import UIKit

// 表示与抛出错误 ： Swift的枚举类型尤为适合构建一组相关的错误状态，枚举的关联值还可以提供错误状态的额外信息。
enum VendingMachineError: Error {
    case invalidSelection                            // 选择无效
    case insufficientFunds(coinsNeeded: Int)         // 金额不足
    case outOfStock                                  // 缺货
}
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

/**
 处理错误 ： 某个错误被抛出时，附近的某部分代码必须负责处理这个错误。
 Swift有4中处理错误的方式：
    1. 把函数抛出的错误传递给调用此函数的代码（只有 throwing 函数可以传递错误。其他函数只能在函数内部处理）
    2. 用 do-catch 语句处理错误
    3. 将错误作为可选类型处理
    4. 断言此错误根本不会发生
 */

// 1.用 throwing 函数传递错误 ： 一个标有 throws 关键字的函数被称为 throwing 函数。
struct Item {
    var price: Int
    var count: Int
}
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)      // vend()方法能抛出错误，所以在调用它的时候前面加了 try 关键字
        self.name = name
    }
}

// 2. 用 Do-Catch 处理错误
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

do {
    try nourish(with: "Beet-Flavoried Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error).")
}

func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
        print("Invalid selection, out of stock, or not enough money.")
    }
}

// 3. 将错误转成可选值:  使用 try? 来将错误转成可选值
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

func fetchDataFromDisk() {}
func fetchDataFromServer() {}

// 指定清理操作 ： 你可以使用 defer 语句在即将离开当前代码块时执行一系列语句。
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(filename)
        }
        if let line = try file.count {
            // 处理文件
        }
        // close(file) 会在这里被调用，即作用域的最后。
    }
}

func exists(_ path: String) -> Bool { return true }
func open(_ path: String) -> Data { return Data() }
func close(_ path: String) {}


enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't that password.")
}

if let result = try? checkPassword("password") {
    print("Result was \(result)")
}else {
    print("D'oh.")
}

try! checkPassword("sekrit")
print("OK!")



enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}
