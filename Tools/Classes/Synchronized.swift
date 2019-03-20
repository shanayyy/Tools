//
//  Synchronized.swift
//  Pods
//
//  Created by 杨俊江 on 2019/3/20.
//

import Foundation

/// 线程安全属性包装器
final public class Synchronized<Value> {
    private var queue: DispatchQueue
    private var _value: Value
    
    /// 线程安全的访问属性值
    ///
    /// 同步读取 异步写入
    public var value: Value {
        get { return queue.sync { _value }}
        set { queue.async(flags: .barrier) { self._value = newValue }}
    }
    
    ///异步读取
    public func asyncRead(_ reader: @escaping (Value)->Void) {
        queue.async { reader(self._value) }
    }
    
    ///同步写入
    public func syncWrite(_ value: Value) {
        queue.sync(flags: .barrier) { self._value = value }
    }
    
    
    ///
    ///
    /// - Parameters:
    ///   - value: 要安全访问的值
    ///   - queue: 可选提供你自己的读写队列
    public init(value: Value, queue: DispatchQueue = DispatchQueue.init(label: "com.shanayyy.synchronized",attributes: .concurrent)) {
        self.queue = queue
        _value = value
    }
}
