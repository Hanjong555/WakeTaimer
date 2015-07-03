//
//  UserDataTimesDay.swift
//  WakeTaimer
//
//  Created by SatanSatoh on 2015/06/20.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import Foundation

class UserDataTimesDays {
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    var LoadWakeDataArry = [wakeData]() //集合体
    
    var SaveData = wakeData()
    
    init(SetDataTime : String){
        SaveData.settingday = TodayString()
        SaveData.wakehourmin = SetDataTime
    }
    
    init(){
        LoadUserTime()
    }
    
    func LoadUserTime(){
        
        var udwakehourmin : [String] = []
        var udsettingday : [String] = []
        var LoadWakeData = wakeData() //単体
        var index : Int
        
        if let udsettingday = ud.objectForKey("SetDay") as? [String]{
            if let udwakehourmin = ud.objectForKey("SetTime") as? [String]{
                for (var i = 0 ; i < udsettingday.count ; i++){
                    LoadWakeData.settingday = udsettingday[i]
                    LoadWakeData.wakehourmin = udwakehourmin[i]
                    LoadWakeDataArry.append(LoadWakeData)
                }
            }
        }
    }
    
    func SaveUserTime(){
        //渡された値をまずこっちにある構造体に代入
        //読み込み
        LoadUserTime()
        //前までのデータを消去
        DeleteUserTime()
        
        //保存したい構造体配列に 以前まで保存してたものを読み出しついか
        var SavedWakeDataArry = LoadWakeDataArry
        SavedWakeDataArry.append(SaveData)
        //１次元に落とすための配列（保存したい配列）
        var udwakehourmin : [String] = []
        var udsettingday : [String] = []
        
        //構造体配列を一列に
        for(var i = 0; i < SavedWakeDataArry.count; i++){
            udwakehourmin += [SavedWakeDataArry[i].wakehourmin]
            udsettingday += [SavedWakeDataArry[i].settingday]
        }
        //保存の開始
        ud.setObject(udsettingday, forKey: "SetDay")
        ud.setObject(udwakehourmin, forKey: "SetTime")
    }
    
    func DeleteUserTime(){
        ud.removeObjectForKey("SetDay")
        ud.removeObjectForKey("SetTime")
    }
}