//
//  MainController.swift
//  weibo
//
//  Created by 2020 on 2020/7/24.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class MainController: UITabBarController {
//    fileprivate lazy var composeBtn : UIButton = UIButton.creatBtutton(image: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    fileprivate lazy var composeBtn : UIButton = UIButton(image: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加加号
        setupComposeBtn()
    }
    

}
extension MainController {
    fileprivate func setupComposeBtn() {
        tabBar.addSubview(composeBtn)
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        composeBtn.addTarget(self, action: #selector(self.addClick(btn:)), for: .touchUpInside)
    }
}

extension MainController {
    @objc fileprivate func addClick(btn:UIButton) {
        print("0---")
    }
}
