import Foundation

/**
 响应式编程（Reactive Programming，简称RP）
    是一种编程范式，可以简化异步编程，提供更优雅的数据绑定
    一般与函数式融合在一起，所以也会叫做：函数响应式编程（Functional Reactive Programming，FRP）
 
 比较著名的、成熟的响应式框架： ReactiveCocoa（RAC）， RxSwift
 RxSwift : Rx标准API的Swift实现，不包括任何iOS相关的内容。
 RxCocoa : 基于RxSwift，给iOS UI控件扩展了很多Rx特性。
 
 RxSwift的核心角色：
    Observable : 负责发送事件（Event）
    Observer   : 负责订阅 Observable, 监听Observable发送的事件（Event）
  */
