import UIKit

// Swift提供了map、filter、reduce这三个高阶函数作为对容器的支持

/*
    map函数： 可以对一个集合类型的所有元素做一个映射操作。
    flatMap函数：和map函数类似，但有”降维“的作用。
    compactMap函数：和map函数类似，但有个”解包“作用，过滤数组元素中的nil值。
 */

var numbers = [20, 19, 12, 4]

let results = numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})
print(results)


let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)


var arr2 = [2,3,4,5,6,8,9]
print(arr2.map{$0+100})

var arrmap = [(1,2),(3,4),(5,6),(7,8)]
print(arrmap.map({$1}))                 // [2, 4, 6, 8]
print(arrmap.map({$0+$1}))              // [3, 7, 11, 15]


// 1、一维数组
numbers = [1,2,3,4]
let result = numbers.map { $0 + 2 }         // $0表示闭包中的第一个参数，这里只有一个参数，即当前遍历到的元数。
print(result) // [3,4,5,6]

// 2、二维数组
let numbers2 = [[1,2,3],[4,5,6]]
var result2 = numbers2.map { $0.map{ $0 + 2 } }
print(result2) // [[3, 4, 5], [6, 7, 8]]
//这个调用实际上是遍历了这里两个数组元素 [1,2,3] 和 [4,5,6]。 因为这两个元素依然是数组，所以我们可以对他们再次调用 map 函数。


let flatResult2 = numbers2.flatMap { $0.map{ $0 + 2 } }
print(flatResult2) // [3, 4, 5, 6, 7, 8]    二维降一维了。

let strings = ["AA","BB",nil,"CC"]
let flatStrings = strings.compactMap { $0 }
print(flatStrings)



// ==============================================================

var arr = [1,2,3,4]
var reduce_arr = arr.reduce(0) { partialResult, element in
    return partialResult + element
    // partialResult 是上一次遍历返回的结果。初始值是 0
}
print("reduce_arr = \(reduce_arr)")    // 10
// reduce 用于本次遍历时需要用到上次遍历结果的。即每次遍历结果是有关联的。

func convertToString(_ i: Int) -> String {
    return "num \(i)."
}
var map_arr = arr.map(convertToString)
print("map_arr = \(map_arr)")       // ["num 1.", "num 2.", "num 3.", "num 4."]


var filter_arr = arr.filter { element in
    return element > 2
}
print("filter_arr = \(filter_arr)")   // [3, 4]

var newArr = [arr, arr]
var flatMap_arr = newArr.flatMap { element in
    return element.map { item in
        item + 1
    }
}
print("flatMap_arr = \(flatMap_arr)") //  [2, 3, 4, 5, 2, 3, 4, 5]
// flat : 铺平的意思。


let lazyMap_arr = arr.lazy.map { element in
    print("mapping \(element)")
    return element * 10
}
print(" begin ----")
//print("lazyMaped", lazyMap_arr[0])
print("lazyMaped", lazyMap_arr[1])
print("lazyMaped", lazyMap_arr[2])
print(" end ----")
// lazy map : 用到哪个 map 哪个。

