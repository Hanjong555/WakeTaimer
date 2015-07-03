//
//  NSTimer+Closure.swift
//  WakeTaimer
//
//  Created by SatanSatoh on 2015/06/20.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import Foundation

// (c) 2014 Nate Cook, licensed under the MIT license

extension NSTimer {
    class func scheduledTimerWithTimeInterval(interval: NSTimeInterval, repeats: Bool, handler: NSTimer! -> Void) -> NSTimer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let repeatInterval = repeats ? interval : 0
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, repeatInterval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
        return timer
    }
}