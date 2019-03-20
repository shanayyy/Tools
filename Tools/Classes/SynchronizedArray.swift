//
//  SynchronizedArray.swift
//  Pods
//
//  Created by yangjunjiang on 2019/3/20.
//

import Foundation

/*
@available(*, unavailable, message: "这儿有bug")
final public class SynchronizedArray<Element> {
    private var array: Synchronized<[Element]>
    
    public init() {
        array = Synchronized.init(value: [])
    }
    
    public init<S>(s: S) where S.Element == Element, S:Sequence {
        array = Synchronized.init(value: .init(s))
    }
    
    public init(repeating repeatedValue: Element, count: Int) {
        array = Synchronized.init(value: .init(repeating: repeatedValue, count: count))
    }
    
    public var startIndex: Int {
        return array.value.startIndex
    }
    
    public var endIndex: Int {
        return array.value.endIndex
    }
    
    public func index(after i: Int) -> Int {
        return array.value.index(after: i)
    }
    
    public func index(before i: Int) -> Int {
        return array.value.index(before: i)
    }
    
    public subscript(index: Int) -> Element {
        get { return array.value[index] }
        set { array.value[index] = newValue }
    }
}

extension SynchronizedArray: Collection {
}

extension SynchronizedArray: Sequence {}
extension SynchronizedArray: MutableCollection {}
extension SynchronizedArray: RandomAccessCollection {}
extension SynchronizedArray: RangeReplaceableCollection {}
extension SynchronizedArray: LazyCollectionProtocol {}

extension SynchronizedArray: Equatable where Element: Equatable {
    public static func == (lhs: SynchronizedArray<Element>, rhs: SynchronizedArray<Element>) -> Bool {
        return lhs.array.value == rhs.array.value
    }
}

extension SynchronizedArray: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral: Element...) {
        self.init(s: arrayLiteral)
    }
}
*/
