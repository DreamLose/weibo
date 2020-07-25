
//
//  UIButton-Extention.swift
//  weibo
//
//  Created by 2020 on 2020/7/24.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
extension UIButton {
//    class func creatBtutton(image:String,bgImageName:String) ->UIButton {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: image), for: .normal)
//        btn.setImage(UIImage(named: image + "_highlighted"), for: .highlighted)
//        btn.setBackgroundImage(UIImage(named: bgImageName), for: .normal)
//        btn.setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
//        btn.sizeToFit()
//        return btn
//    }
    
    convenience init(image:String,bgImageName:String) {
        self.init()
        setImage(UIImage(named: image), for: .normal)
        setImage(UIImage(named: image + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
}
