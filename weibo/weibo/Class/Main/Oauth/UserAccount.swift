//
//  Person.swift
//  weibo
//
//  Created by 2020 on 2020/8/3.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding{
   
    //MARK: ------- 属性
    //["remind_in": 157679999, "access_token": 2.00uiKdQG0KdrK_84df6760ea5rRjdE, "expires_in": 157679999, "isRealName": true, "uid": 5742554384]
//    令牌
   @objc var access_token : String?
//    过期日期 换成 date类型
   @objc var expries_date : Date?
//    过期时间
    @objc var expires_in : TimeInterval = 0.0 {
        didSet {
           expries_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
//    用户id
   @objc var uid : String?
   
    @objc var screen_name : String?
    @objc var avatar_large : String?
    //MARK: ------- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
//MARK: ------- 重写description 属性
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token","uid","expries_date","screen_name","avatar_large"]).description
    }
    
//    解档方法
    required init?(coder: NSCoder) {
        access_token = coder.decodeObject(forKey: "access_token") as? String
        uid = coder.decodeObject(forKey: "uid") as? String
        expries_date = coder.decodeObject(forKey: "expries_date") as? Date
        screen_name = coder.decodeObject(forKey: "screen_name") as? String
        avatar_large = coder.decodeObject(forKey: "avatar_large") as? String
    }
//    归档 方法
    func encode(with coder: NSCoder) {
        coder.encode(access_token, forKey: "access_token")
        coder.encode(uid, forKey: "uid")
        coder.encode(expries_date, forKey: "expries_date")
        coder.encode(screen_name, forKey: "screen_name")
        coder.encode(avatar_large, forKey: "avatar_large")
    }
}
