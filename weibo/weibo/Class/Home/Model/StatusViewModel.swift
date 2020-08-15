//
//  StatusViewModel.swift
//  weibo
//
//  Created by 2020 on 2020/8/15.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
    var status : StatusModel?
    //MARK: ------- 自定义属性
   @objc var sourceText : String?  //处理来源
   @objc var creatAtStr : String?  //处理创建时间
    //MARK: ------- 自定义属性
    @objc var verifiedImage : UIImage?  //用户认证图标
    @objc var vipImage : UIImage?   //用户会员等级
    @objc var profileUrl : URL?
    init(status : StatusModel) {
        self.status = status
//            source 有值且不为空
        if let source = status.source, source != "" {
   //            <a href="http://weibo.com" rel="nofollow">新浪微博</a>
   //            获取起始位置和截取长度
           let startIndex = (source as NSString).range(of: ">").location + 1
           let length = (source as NSString).range(of: "</").location - startIndex
   //            截取字符串
           sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        if let creatAt = status.created_at {
             creatAtStr = Date.creatDateSting(creatAtStr: creatAt)
        }
        let verifiedType = status.user?.verified_type ?? -1
        switch verifiedType {
            case 0:
                verifiedImage = UIImage(named: "avatar_vip")
            case 2,3,5:
                verifiedImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                verifiedImage = UIImage(named: "avatar_grassroot")
            default:
                verifiedImage = nil
        }
        
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        let profileUrlStr = status.user?.profile_image_url ?? ""
        profileUrl = URL(string: profileUrlStr)
        
    }
}
