//
//  UtilsManager.swift
//  BitClient
//
//  Created by Alan on 2021/11/7.
//

import Foundation
class UtilsManager {
    static func getSizeText(_ size: Int) -> String{
        let unitList = ["GB", "MB", "KB", "B"];
        for (index, item) in unitList.enumerated() {
            if(size > Int(pow(Double(1024), Double(unitList.count - 1 - index)))){
                let value = Double(size) / Double(pow(Double(1024), Double(unitList.count - 1 - index)))
                return String(format: "%g", FloorDouble(value: value)) + " " + item
            }
        }
        return String(format: "%g", FloorDouble(value: Double(size))) + " " + unitList[unitList.count - 1]
    }
    
    static func FloorDouble(value: Double) -> Double{
        return floor(value * 100) / 100
    }
    
    static func timeStampToCurrennTime(timeStamp: Double) -> String {
            //获取当前的时间戳
            let currentTime = Date().timeIntervalSince1970
            //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
           //let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
            //时间差
            let reduceTime : TimeInterval = currentTime - timeStamp
            //时间差小于60秒
            if reduceTime < 60 {
                return "刚刚"
            }
            //时间差大于一分钟小于60分钟内
            let mins = Int(reduceTime / 60)
            if mins < 60 {
                return "\(mins)分钟前"
            }
            //时间差大于一小时小于24小时内
            let hours = Int(reduceTime / 3600)
            if hours < 24 {
                return "\(hours)小时前"
            }
            //时间差大于一天小于30天内
            let days = Int(reduceTime / 3600 / 24)
            if days < 30 {
                return "\(days)天前"
            }
            //不满足以上条件直接返回日期
            let date = NSDate(timeIntervalSince1970: timeStamp)
            let dfmatter = DateFormatter()
            //yyyy-MM-dd HH:mm:ss
            dfmatter.dateFormat="yy年MM月dd日"
            return dfmatter.string(from: date as Date)
        }

}
