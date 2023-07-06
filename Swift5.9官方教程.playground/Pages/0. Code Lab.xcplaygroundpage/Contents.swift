// Swift 官方文档 swiftgg.gitbook.io


import Foundation
import UIKit
import PlaygroundSupport


//import PlaygroundSupport
//PlaygroundPage.current.needsIndefiniteExecution = true
//PlaygroundPage.current.setLiveView(<#T##newLiveView: View##View#>)

DispatchQueue.main.asyncAfter(deadline: .now()+3) {
    print("Hello Playground!!")
}

#warning("to do")

func test() -> UIView {
    #warning("undo")
    fatalError()        // 占位
}

import _Concurrency
Task {
    try await Task.sleep(nanoseconds: 2_000_000_000)
    print("Hello Playground 2")
}

let str = playgroundName()
let str2 = pageName()
print("\(str)\n\(str2)")


//#-hidden-code
print("这里的代码在 Swift Playground 中不显示（但会执行）")
//#-end-hidden-code

let url = Bundle.main.url(forResource: "testImg", withExtension: "jpg")
print(url!)

let img = UIImage(contentsOfFile: url!.path)


let view = UIView()                         // 创建对象
view.frame = CGRect.init(x: 0, y: 0, width: 200, height: 200)
view.backgroundColor = UIColor.red

let btn = UIButton(type: UIButton.ButtonType.infoDark)
btn.center = view.center
btn.backgroundColor = UIColor.green
view.addSubview(btn)

PlaygroundPage.current.liveView = view

// markup 语法
/*:
 # 一级标题
 
 ## 二级标题
 ### 三级标题
 ### 三级标题2
 
 ## 无序列表
 - first
 - second
 
 ## 有序列表
 1. CLASS
 2. STRUCT
 
 ## 笔记
 > This is a note
 ---
 
 ## 图片
 ![logo](log.png, "local image url")

 ## 链接
 * [click URL](https://www.baidu.com)
 
 ## 粗体、斜体
this is **Bold** , this is *Italic*
 */


