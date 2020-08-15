//
//  UserAccountTools.swift
//  weibo
//
//  Created by 2020 on 2020/8/5.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class UserAccountViewModel {
    //MARK: ------- 将类设置单利
    static let sharIntance : UserAccountViewModel = UserAccountViewModel()
    var account : UserAccount?
    var accountPath : String {
         let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("account.plist")
    }
    var isLogin : Bool {
        if account == nil {
            return false
        }
        guard let expiresDate = account?.expries_date else {
            return false
        }
        return expiresDate.compare(Date()) == .orderedDescending
    }
    init() {
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
    
}
