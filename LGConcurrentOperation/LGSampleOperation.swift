//
//  LGSampleOperation.swift
//  LGConcurrentOperation
//
//  Created by Luka Gabric on 08/11/15.
//  Copyright © 2015 Luka Gabric. All rights reserved.
//

import Foundation
import ReactiveCocoa

public class LGSampleOperation: LGConcurrentOperation {
    
    public var debugName = ""
    public let signal: Signal<String, NoError>
    let observer: Observer<String, NoError>

    init(debugName: String) {
        self.debugName = debugName
        
        let (signal, observer) = Signal<String, NoError>.pipe()
        self.signal = signal.takeLast(1)
        
        self.observer = observer
        
        super.init()
    }
    
    public override func main() {
        print("did begin work for operation \(self.debugName)")
        let seconds = Double(arc4random_uniform(1) + 1)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_queue_create("com.test.lg", nil)) { [weak self] in
            guard let strongSelf = self else { return }
            
            print("did end work for operation \(strongSelf.debugName)")
            strongSelf.completeOperation()
        }
    }
    
    public override func start() {
        print("will start work for operation \(self.debugName)")
        super.start()
    }
    
    override func completeOperation() {
        self.observer.sendNext("Some string")
        self.observer.sendCompleted()
        super.completeOperation()
        print("did complete operation \(self.debugName)")
    }
}