//
//  BinaryNode.swift
//  DSA
//
//  Created by Jayakrishnan u on 8/6/24.
//

import Foundation

public class BinaryNode<Element> {
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
}

extension BinaryNode {
    
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traverseInOrder(visit: visit)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
    
    func height(of node: BinaryNode<Element>?) -> Int {
        guard let node = node else {
            return -1
        }
        return 1 + max(height(of: node.leftChild), height(of: node.rightChild))
    }
    
    public func deserialize(visit: (Element?) -> Void) {
        visit(value)
        if let leftChild = leftChild {
            leftChild.traverseInOrder(visit: visit)
        } else {
            visit(nil)
        }
        
        if let rightChild = rightChild {
            rightChild.traversePreOrder(visit: visit)
        } else {
            visit(nil)
        }
    }
}


public struct BinarySearchTree<Element: Comparable> {
    public private(set) var root: BinaryNode<Element>?
    public init() { }
    
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        guard let node = node else {
            return BinaryNode(value: value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        return node
    }
    
    public mutating func remove(_ value: Element) {
        remove(node: root, value: value)
    }
    
    public mutating func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            
            if node.leftChild == nil {
                return node.leftChild
            }
            
            if node.rightChild == nil {
                return node.rightChild
            }
            
//            node.value = node.rightChild!.min.rawValue
//            node.rightChild = remove(node: rightChild, value: node.value)
            
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        return node
    }
    
    public func contains(_ value: Element) -> Bool {
//        guard let root = root else {
//            return false
//        }
//        var found = false
//        root.traverseInOrder {
//            if $0 == value {
//                found = true
//            }
//        }
//        return found
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
    
    private func isBST(_ tree: BinaryNode<Element>?, min: Element?, max: Element?) -> Bool {
        guard let tree = tree else { return false }
        if let min = min, tree.value <= min { return false }
        if let max = max, tree.value > max { return false }
        return isBST(tree.leftChild, min: min, max: tree.value) && isBST(tree.rightChild, min: tree.value, max: max)
    }
    
}


public extension RandomAccessCollection where Element: Comparable {
    func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
        let range = range ?? startIndex..<endIndex
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size / 2)
        if self[middle] == value {
            return middle
        } else if self[middle] > value {
            return binarySearch(for: value, in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
        }
        
    }
    
    func findIndices(of value: Int, in array: [Int]) -> Range<Int>? {
        guard let leftIndex = array.firstIndex(of: value) else {
            return nil
        }
        
        guard let rightIndex = array.lastIndex(of: value) else {
            return nil
         }
        
        return leftIndex..<rightIndex
        
    }
    
}

extension BinarySearchTree where Element: Hashable {
    public func contains(_ subtree: BinarySearchTree) -> Bool {
        var set: Set<Element> = []
        root?.traverseInOrder {
            set.insert($0)
        }
        var isEqual = true
        
        subtree.root?.traverseInOrder {
            isEqual = isEqual && set.contains($0)
        }
        return isEqual
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        return String(String(describing: root))
    }
}
