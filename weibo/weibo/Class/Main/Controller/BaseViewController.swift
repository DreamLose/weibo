//
//  BaseViewController.swift
//  weibo
//
//  Created by 2020 on 2020/7/25.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    //MARK: ------- 懒加载属性
    lazy var visitorView : VisitorView = VisitorView.visitorView()
    //MARK: ------- 设置登录状态
    var isLogin : Bool = UserAccountViewModel.sharIntance.isLogin
       
   override func loadView() {
       isLogin ? super.loadView() : setupVisitorView()
   }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavgitionItems()
    }
}
//MARK: ------- 设置界面
extension BaseViewController {
    //设置访客试图
    fileprivate func setupVisitorView() {
          view = visitorView
        //监听访客试图中的点击
        visitorView.registoreBtn.addTarget(self, action: #selector(self.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(self.logInBtnClick), for: .touchUpInside)
      }
//    设置导航栏item
    fileprivate func setupNavgitionItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(self.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(self.logInBtnClick))
    }
}

//MARK: ------- 事件监听
extension BaseViewController {
   @objc fileprivate func registerBtnClick() {
        print("-----registerBtnClick")
    }
    @objc fileprivate func logInBtnClick() {
        print("-----logInBtnClick")
        let oauthVC = OauthController()
//        包装导航控制器
        let oauthNav = UINavigationController(rootViewController: oauthVC)
        oauthNav.modalPresentationStyle = .fullScreen
        present(oauthNav, animated: true, completion: nil)
        
    }
}


