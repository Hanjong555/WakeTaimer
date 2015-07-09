//
//  Arame.swift
//  WakeTaimer
//
//  Created by SatanSatoh on 2015/06/20.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

@objc
class Arame : NSObject, AnyObject , AVAudioPlayerDelegate{
    var tagetTimehour : Int = 0
    var tagetTimemin : Int = 0
    var nowhour : Int = 0
    var nowmin : Int = 0
    var timer = NSTimer()
    var audioPlayer: AVAudioPlayer?
    
    override init(){
    
    }
    
    func SetTimer (strhour:String,strmin:String){
        tagetTimehour = strhour.toInt()!
        tagetTimemin = strmin.toInt()!
        //AboutAudio()
        //TagetTimeAim()
    }
    
    func StartTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
        if timer.valid == true {
            println("Timer ON")
        }else{
            println("Timer OFF")
        }
    }
    
    func StopTimer(){
        //timerが動いてるなら.
        if timer.valid == true {
            
            //timerを破棄する.
            timer.invalidate()
        }
    }
    
    internal func update(){
        self.getTime()
        if(!self.checkTime()){
            AboutAudioinit()
            ArameCall()
        }
    }
    
    func getTime(){
        var date = NSDate() // -> "Nov 2, 2014, 10:32 AM"
        var calendar = NSCalendar.currentCalendar()
        var components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
        nowhour = components.hour // -> 10
        nowmin = components.minute // -> 32
        println("IntGettime:\(nowhour):\(nowmin)")
        //let second = components.second // -> 22
    }
    
    func checkTime()->Bool{
        println("IntTagetTime:\(tagetTimehour):\(tagetTimemin)")
        println("IntGettime:\(nowhour):\(nowmin)")
        //if tagetTimehour == nowhour && tagetTimemin == nowmin {
        if tagetTimehour == nowhour{
            if tagetTimemin == nowmin {
                println("Same!")
                //ArameCall()
                return false
            }
            return true
        }
        println("Not Same!")
        return true
    }
    
    func AboutAudioinit(){
        let soundFilePath : NSString = NSBundle.mainBundle().pathForResource("sample", ofType: "mp3")!
        let fileURL : NSURL = NSURL(fileURLWithPath: soundFilePath as String)!
        audioPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
        audioPlayer!.delegate = self
        audioPlayer!.prepareToPlay()
    }
    
    func ArameCall(){
        if audioPlayer!.playing == true {
            println("サウンド停止")
            audioPlayer!.pause()
        } else {
            println("サウンド再生")
            audioPlayer!.play()
        }
    }
}