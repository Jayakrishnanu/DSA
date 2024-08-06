//
//  Trees.swift
//  DSA
//
//  Created by Jayakrishnan u on 8/6/24.
//

import Foundation

public class TreeNode<T> {
    public var value: T
    public var children: [TreeNode] = []
    
    public init(value: T) {
        self.value = value
    }
    
    public func add(_ child: TreeNode) {
        children.append(child)
    }
    
}

extension TreeNode {
    public func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach { $0.forEachDepthFirst(visit: visit) }
    }
    
//    public func forEachLevelOrder(visit: (TreeNode) -> Void) {
//        visit(self)
//        var queue = Queue()
//        children.forEach { queue.enqueue($0) }
//        while let node = queue.dequeue() {
//            visit(node)
//            node.children.forEach { queue.enqueue($0) }
//        }
//    }
}
