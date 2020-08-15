//
//  StatusModel.swift
//  weibo
//
//  Created by 2020 on 2020/8/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class StatusModel: NSObject {
    @objc var created_at : String?  //创建时间处理
    @objc var source : String?     //来源处理
    @objc var text : String?    //正文
    @objc var id : Int = 0
    @objc var user : UserModel?
   
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
        if let userDict = dict["user"] as? [String : Any] {
            user = UserModel(dict: userDict)
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
