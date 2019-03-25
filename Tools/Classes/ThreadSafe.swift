//
//  ThreadSafe.swift
//  Pods
//
//  Created by 杨俊江 on 2019/3/20.
//

import Foundation

/// 线程安全属性包装器
final public class ThreadSafe<Value> {
    private var queue: DispatchQueue
    private var _value: Value
    
    /// 线程安全的访问属性值 同步读取 异步写入
    public var value: Value {
        get { return queue.sync { _value }}
        set { queue.async(flags: .barrier) { self._value = newValue }}
    }
    
    ///异步读取
    public func asyncRead(_ reader: @escaping (Value)->Void) {
        queue.async { reader(self._value) }
    }
    
    public func asyncWrite(_ value: Value, completion: (() -> Void)? = nil) {
        queue.async(flags: .barrier) { self._value = value; completion?() }
    }
    
    ///同步读取
    public func syncRead() -> Value {
        return queue.sync { _value }
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
    public init(_ value: Value, queue: DispatchQueue = DispatchQueue.init(label: "com.shanayyy.synchronized",attributes: .concurrent)) {
        self.queue = queue
        _value = value
    }
}


public class ThreadSafeStore {
    private lazy var singleQueueStore = ThreadSafe<[String:Any]>([:])
    private lazy var multiQueueStore = ThreadSafe<[String:ThreadSafe<Any>]>([:])
    
    public let isIndependentWrite : Bool
    
    public init(independentWrite: Bool) {
        isIndependentWrite = independentWrite
    }
    
    public func getItem<T>(forKey aKey: String) -> T? {
        if isIndependentWrite {
            return multiQueueStore.value[aKey]?.value as? T
        }else {
            return singleQueueStore.value[aKey] as? T
        }
    }
    
    public func setItem<T>(_ item: T, forKey aKey: String) {
        if isIndependentWrite {
            if let safeV = multiQueueStore.value[aKey] {
                safeV.value = item
            }else {
                multiQueueStore.value[aKey] = ThreadSafe<Any>(item)
            }
        }else {
            singleQueueStore.value[aKey] = item
        }
    }
}
