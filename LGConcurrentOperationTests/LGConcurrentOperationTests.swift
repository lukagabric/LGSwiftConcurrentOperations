//
//  LGConcurrentOperationTests.swift
//  LGConcurrentOperationTests
//
//  Created by Luka Gabric on 08/11/15.
//  Copyright © 2015 Luka Gabric. All rights reserved.
//

import XCTest
@testable import LGConcurrentOperation

class LGConcurrentOperationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOneConcurentOperation() {
        runOperations(1)
    }
    
    func testTwoConcurentOperations() {
        runOperations(2)
    }
    
    func runOperations(count: Int) {
        let operationQueue = NSOperationQueue()
        operationQueue.suspended = true
        operationQueue.maxConcurrentOperationCount = count
        
        let op1 = LGSampleOperation(debugName: "op1")
        let op2 = LGSampleOperation(debugName: "op2")
        let op3 = LGSampleOperation(debugName: "op3")
        let op4 = LGSampleOperation(debugName: "op4")
        let op5 = LGSampleOperation(debugName: "op5")
        let op6 = LGSampleOperation(debugName: "op6")
        
        operationQueue.addOperation(op1)
        operationQueue.addOperation(op2)
        operationQueue.addOperation(op3)
        operationQueue.addOperation(op4)
        operationQueue.addOperation(op5)
        operationQueue.addOperation(op6)
        
        operationQueue.suspended = false
        operationQueue.waitUntilAllOperationsAreFinished()
    }
    
    func testOperationSignal() {
        let operationQueue = NSOperationQueue()
        operationQueue.suspended = true
        operationQueue.maxConcurrentOperationCount = 1
        
        let op1 = LGSampleOperation(debugName: "op1")

        op1.signal.observeCompleted {
            print("Operation \"\(op1.debugName)\" completed")
        }
        
        operationQueue.addOperation(op1)
        
        operationQueue.suspended = false
        operationQueue.waitUntilAllOperationsAreFinished()
    }
    
}
