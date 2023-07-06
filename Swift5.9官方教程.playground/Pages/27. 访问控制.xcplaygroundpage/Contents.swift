// Apple 官方 Swift 教程
/**
 访问控制可以限定其它源文件或模块对你的代码的访问。
 这个特性可以让你隐藏代码的实现细节，并且能够提供一个接口来让别人访问和使用你的代码。
 五种访问级别：open, public, internal, fileprivate, private
 */

import Foundation
public class SomePublicClass {                // 显式 public 类
    public var somePublicProperty = 0         // 显式 public 类成员
    var someInternalProperty = 0              // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {} // 显式 fileprivate 类成员
    private func somePrivateMethod() {}         // 显式 private 类成员
}

class SomeInternalClass {
    var someInternalProperty = 0
    fileprivate func someFilePrivateMethod() {}
    private func somePrivateMethod() {}
}

fileprivate class SomeFilePrivateClass {       // 显式 fileprivate 类
    func someFilePrivateMethod() {}            // 隐式 fileprivate 类成员
    private func somePrivateMethod() {}        // 显式 private 类成员
}

private class SomePrivateClass {
    func somePrivateMethod() {}
}



 
