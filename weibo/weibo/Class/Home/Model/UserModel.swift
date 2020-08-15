//
//  UserModel.swift
//  weibo
//
//  Created by 2020 on 2020/8/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    @objc var screen_name : String?  //昵称
    @objc var profile_image_url : String?  //头像
    @objc var verified_type : Int = -1 //是否认证 -1 未认证
    @objc var mbrank : Int = 0  //会员等级
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
