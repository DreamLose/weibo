//
//  HomeViewController.swift
//  weibo
//
//  Created by 2020 on 2020/7/24.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
class HomeViewController: BaseViewController {

    //MARK: ------- 懒加载
    fileprivate lazy var titleBtn : TitleBtn = TitleBtn()
    
    //1: 如果在一个函数中,出现了歧义,要用self
//    2:在闭包中使用当前对象的属性和方法也要加self
    fileprivate lazy var popoverAnimation : PoperAnimator = PoperAnimator {[weak self] (isPresented) in
        self?.titleBtn.isSelected = isPresented
    }
    //MARK: ------- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        //没有登录.设置内容
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        setUpNavgationBar()
       
    }
 

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

//MARK: ------- 设置导航栏按钮
extension HomeViewController {
    fileprivate func setUpNavgationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: "navigationbar_pop")
//        navigationItem.titleView = nil
        titleBtn.setTitle("我是谁", for: .normal)
        titleBtn.addTarget(self, action: #selector(self.titleBtnClick(titleBtn:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

//MARK: ------- 事件点击
extension HomeViewController {
    @objc fileprivate func titleBtnClick(titleBtn : TitleBtn){
//        1.创建弹出控制器
        let poperView = PoperViewController()
//        防止弹出试图后,首页的tab等内容被移除,设置model样式
        poperView.modalPresentationStyle = .custom
        //自定义转场动画
//        1.设置转场代理
        poperView.transitioningDelegate = popoverAnimation
        popoverAnimation.presentedFrame = CGRect(x: 100, y: 55, width: 180, height: 250)
        present(poperView, animated: true, completion: nil)
    }
}


