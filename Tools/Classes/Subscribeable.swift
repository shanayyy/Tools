//
//  Subscribeable.swift
//  Pods
//
//  Created by yangjunjiang on 2019/3/25.
//

import Foundation
public class Subscriber<T>: Equatable {
    var handler: (T) -> Void
    var queue: DispatchQueue?
    var isRemovedAfterHandle: Bool
    
    public init(handler: @escaping (T) -> Void, onlyOnce: Bool = false, queue: DispatchQueue?) {
        self.handler = handler
        self.queue = queue
        self.isRemovedAfterHandle = onlyOnce
    }
    
    public static func == (lhs: Subscriber, rhs: Subscriber) -> Bool {
        return lhs === rhs
    }
}

public class Subscribeable<T> {
    private lazy var subscribers: ThreadSafe<[Subscriber<T>]> = .init([])
    
    deinit {
        removeAllSubscribers()
    }
    
    public func addSubscriber(_ ob: Subscriber<T>) {
        var subs = subscribers.syncRead()
        subs.append(ob)
        subscribers.asyncWrite(subs)
    }
    
    public func subscribe(onlyOnce: Bool = false, onQueue queue: DispatchQueue? = nil, handler: @escaping (T) -> Void) -> Subscriber<T> {
        let ob = Subscriber(handler: handler, onlyOnce: onlyOnce, queue: queue)
        addSubscriber(ob)
        return ob
    }
    
    public func publish(_ value: T) {
        subscribers.value.forEach({ subscriber in
            let block = {[weak self] in
                subscriber.handler(value)
                if subscriber.isRemovedAfterHandle {
                    self?.removeSubscriber(subscriber)
                }
            }
            subscriber.queue?.async(execute: block) ?? block()
        })
    }
    
    public func removeSubscriber(_ ob: Subscriber<T>) {
        var subs = subscribers.syncRead()
        subs.removeAll(where: { $0 == ob })
        subscribers.asyncWrite(subs)
    }
    
    public func removeAllSubscribers() {
        subscribers.asyncWrite([])
    }
}
