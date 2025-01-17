//
//  Queues.swift
//  DSA
//
//  Created by Jayakrishnan u on 8/6/24.
//

import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}


public struct QueueArray<T>: Queue {
    private var array: [T] = []
    public init() { }
    public var isEmpty: Bool {
        array.isEmpty
    }
    
    public var peek: T? {
        array.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}


//public class QueueLinkedList<T>: Queue {
//    private var list = DoublyLinkedList<T>()
//    public init() { }
//    
//    public func enqueue(_ element: T) -> Bool {
//        list.append(element)
//        return true
//    }
//}
