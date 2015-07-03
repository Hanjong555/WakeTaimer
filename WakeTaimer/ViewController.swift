//
//  ViewController.swift
//  WakeTaimer
//
//  Created by SatanSatoh on 2015/06/13.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import UIKit
import AVFoundation

struct wakeData {
    var wakehourmin : String
    var settingday : String
    init(){
        wakehourmin = ""
        settingday = ""
    }
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource ,AnyObject, AVAudioPlayerDelegate{
    var strhour : String = "00"
    var strmin : String = "00"
    
    var myUIPicker: UIPickerView = UIPickerView()
    var hourArr :NSArray = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    var minArr : NSArray = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    
    var usersettime = wakeData()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        myUIPicker.frame = CGRectMake(0,0,self.view.bounds.width, 180.0)
        myUIPicker.delegate = self
        myUIPicker.dataSource = self
        self.view.addSubview(myUIPicker)
    }
    
    //表示列
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //表示個数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0){
            return hourArr.count
        }else if (component == 1){
            return minArr.count
        }
        return 0;
    }
    
    //表示内容
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        if (component == 0){
            return hourArr[row] as! String
        }else if (component == 1){
            return minArr[row] as! String
        }
        return "";
    }
    
    //選択時
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let alertController = UIAlertController(title: "時間のセット", message: "上記の時間でアラームをセットしますか？", preferredStyle: .ActionSheet)
        let firstAction = UIAlertAction(title: "はい", style: .Default) {
            action in println("Pushed First")
            
            var ArameClass : () = Arame(strhour: self.strhour, strmin: self.strmin).StartTimer()
            
            println(self.strhour + ":" + self.strmin)
            
        }
        let secondAction = UIAlertAction(title: "いいえ", style: .Default) {
            action in println("Pushed Second")
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel) {
            action in println("Pushed CANCEL")
        }
    
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    //
        if (component == 0){
        strhour = hourArr[row] as! String
        //println("列: \(row)")
        //println("値: \(hourArr[row])")
        }else if (component == 1){
        strmin = minArr[row] as! String
        //println("列: \(row)")
        //println("値: \(minArr[row])")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


func TodayString() -> String{
    let dateFormatter = NSDateFormatter()// フォーマットの取得
    dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")  // JPロケール
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"         // フォーマットの指定  HH:mm:ss
    let stringday = dateFormatter.stringFromDate(NSDate())
    return stringday
}

/*
func WakeTimeDatasave(wakeData : setday){

}
*/
