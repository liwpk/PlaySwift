// Apple 官方 Swift 教程
/**
 类型转换在 Swift 中使用 is 和 as 操作符实现。
 */

import Foundation
// 为类型转换定义类层次
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
// 数组 library 的类型被推断为 [MediaItem]

// 检查类型 ： 类型检查符（is）来检查一个实例是否属于特定子类型。
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    }else if item is Song {
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs.")


// 向下转型 ： 当不确定向下转型是否成功时，用类型转换的条件形式（as?）
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

// Any 和 AnyObject 的类型转换
/**
 Swift 为不确定类型提供了两种特殊的类型别名：
    AnyObject 可以表示任何类型的实例, 是通用的引用类型，不能用来描述值类型。
    Any       更加通用，可以表示任何类型，包括值类型、引用类型。
    
 */
var things: [Any] = []
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({(name: String) -> String in "Hello, \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0 :
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name)")
    case let stringConverter as (String) -> String:
        print(stringConverter("David"))
    default:
        print("something else")
    }
}

let optionalNumber: Int? = 3
things.append(optionalNumber)            // 警告
things.append(optionalNumber as Any)     // 没有警告
