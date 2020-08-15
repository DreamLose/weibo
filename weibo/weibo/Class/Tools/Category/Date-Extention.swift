//
//  Date-Extention.swift
//  weibo
//
//  Created by 2020 on 2020/8/14.
//  Copyright © 2020 2020. All rights reserved.
//

import Foundation
extension Date {
    static func creatDateSting(creatAtStr:String) -> String {
        let fmt = DateFormatter()
//        格式化
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        guard let creatDate = fmt.date(from: creatAtStr) else {
            return ""
        }
        let nowDate = Date()
//        计算时间差
      let interval = Int(nowDate.timeIntervalSince(creatDate))
//       对时间间隔处理
//        显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
             
        }
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
//        判断昨天
        let calendar = Calendar.current
        if calendar.isDateInYesterday(creatDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: creatDate)
            return timeStr
        }
//        一年之内。02-22 12:22
        let cmps = calendar.dateComponents([Calendar.Component.year], from: creatDate, to: nowDate)
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: creatDate)
            return timeStr
        }
//        超过一年
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: creatDate)
        return timeStr
    }
}
