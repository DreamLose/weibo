//
//  WelComeController.swift
//  weibo
//
//  Created by 2020 on 2020/8/12.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
import SDWebImage
class WelComeController: UIViewController {
//MARK: ------- 拖线属性
    @IBOutlet weak var iconViewbottomCons: NSLayoutConstraint!
    
    
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        设置头像
        let profileUrl = UserAccountViewModel.sharIntance.account?.avatar_large
        let url = URL(string: profileUrl ?? "")
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
//    改变约束
        iconViewbottomCons.constant = UIScreen.main.bounds.height - 200
//         执行动画
//Damping :阻力系数,阻力系数越大,弹动效果越不明显 0-1
//        initialSpringVelocity:初始化速度
        UIView.animate(withDuration:1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (isFinshed) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
}
