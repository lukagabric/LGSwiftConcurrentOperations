//
//  LGSampleOperation.swift
//  LGConcurrentOperation
//
//  Created by Luka Gabric on 08/11/15.
//  Copyright © 2015 Luka Gabric. All rights reserved.
//

import Foundation

class LGSampleOperation: LGConcurrentOperation {
    
    var debugName = ""
    
    init(debugName: String) {
        self.debugName = debugName
    }
    
    override func main() {
        print("did begin work for operation \(self.debugName)")
        let seconds = Double(arc4random_uniform(2) + 2)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_queue_create("com.test.lg", nil)) { [unowned self] in
            print("did end work for operation \(self.debugName)")
            self.completeOperation()
        }
    }
    
    override func start() {
        print("will start work for operation \(self.debugName)")
        super.start()
    }
    
    override func completeOperation() {
        super.completeOperation()
        print("did complete operation \(self.debugName)")
    }
}