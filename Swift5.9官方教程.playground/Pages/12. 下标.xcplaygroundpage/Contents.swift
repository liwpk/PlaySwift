// Apple 官方 Swift 教程

/**
 下标可以定义在类、结构体和枚举中，是访问集合、列表或序列中元素的快捷方式。
 可以使用下标的索引，设置和获取值，而不需要再调用对应的存取方法。
 */

import Foundation
// 下标语法 ： 下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行查询。
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {        // 只读下标
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

// 下标选项 ： 下标可接受不同数量的参数，并为这些参数提供默认值。 与函数不同的是，下标不能是 in-out 参数。
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
print(matrix.grid)

// 类型下标
/**
 实例下标是在特定类型的一个实例上调用的下标。
 类型下标是在这个类型自身上调用的下标。
 */

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)


struct Point {
    var x = 10, y = 10
}
class PointManager {
    var point = Point()
    subscript(index: Int) -> Point {
        set {
            point = newValue
        }
        get {
            point
        }
    }
}
var pm = PointManager()
pm[0].x = 11
pm[0].y = 22
print(pm.point)
