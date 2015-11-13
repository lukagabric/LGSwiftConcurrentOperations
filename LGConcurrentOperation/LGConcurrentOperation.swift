//
//  LGConcurrentOperation.swift
//  LGConcurrentOperation
//
//  Created by Luka Gabric on 08/11/15.
//  Copyright © 2015 Luka Gabric. All rights reserved.
//

import Foundation

public class LGConcurrentOperation: NSOperation {
    
    public override var asynchronous: Bool {
        return true
    }
    
    private var _executing: Bool = false
    public override var executing: Bool {
        get {
            return _executing
        }
        set {
            if (_executing != newValue) {
                self.willChangeValueForKey("isExecuting")
                _executing = newValue
                self.didChangeValueForKey("isExecuting")
            }
        }
    }
    
    private var _finished: Bool = false;
    public override var finished: Bool {
        get {
            return _finished
        }
        set {
            if (_finished != newValue) {
                self.willChangeValueForKey("isFinished")
                _finished = newValue
                self.didChangeValueForKey("isFinished")
            }
        }
    }
    
    public override func start() {
        if (cancelled) {
            finished = true
            return
        }
        
        executing = true
        
        main()
    }
    
    func completeOperation() {
        executing = false
        finished  = true
    }

}
