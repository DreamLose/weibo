//
//  VisitorView.swift
//  weibo
//
//  Created by 2020 on 2020/7/25.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    
    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var cycleImg: UIImageView!
    
    @IBOutlet weak var iconimg: UIImageView!
   
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registoreBtn: UIButton!
}

//MARK: ------- 自定义函数
extension VisitorView {
    class func visitorView() ->VisitorView {
           return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
       }
    func setUpVisitorViewInfo(iconName:String,title:String) {
        iconimg.image = UIImage(named: iconName)
        tipLab.text = title
        cycleImg.isHidden = true
    }
    func addRotationAnim() {
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        rotationAnim.isRemovedOnCompletion = false  //防止切换界面,动画停止被移除
        cycleImg.layer.add(rotationAnim, forKey: nil)
    }
}
