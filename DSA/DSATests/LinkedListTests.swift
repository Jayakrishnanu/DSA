//
//  LinkedListTests.swift
//  DSATests
//
//  Created by Jayakrishnan u on 8/6/24.
//

import XCTest
@testable import DSA

final class LinkedListTests: XCTestCase {
    
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    var list = LinkedList<Int>()
    
    override func setUpWithError() throws {
        node1.next = node2
        node2.next = node3
        
        list.push(3)
        list.push(2)
        list.push(1)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNode() throws {
        print(node1)
        print(list)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
