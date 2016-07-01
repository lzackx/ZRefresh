//
//  NSObject+ZExtension.swift
//  Pixcial
//
//  Created by Zack on 29/6/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

import Foundation

extension NSObject {
    
    public typealias Task = (cancel : Bool) -> ()
    
    public func delay(time:NSTimeInterval, task:()->()) ->  Task? {
        
        func dispatch_later(block:()->()) {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(time * Double(NSEC_PER_SEC))),
                dispatch_get_main_queue(),
                block)
        }
        
        var closure: dispatch_block_t? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    dispatch_async(dispatch_get_main_queue(), internalClosure);
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(cancel: false)
            }
        }
        
        return result;
    }
    
    public func cancel(task:Task?) {
        task?(cancel: true)
    }
    
}
