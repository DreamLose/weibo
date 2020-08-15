//
//  HomeViewController.swift
//  weibo
//
//  Created by 2020 on 2020/7/24.
//  Copyright © 2020 2020. All rights reserved.
//


import UIKit
class HomeViewController: BaseViewController {
    fileprivate lazy var statusesViewModel : [StatusViewModel] = [StatusViewModel]()
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
        
        loadStatues()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
       
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



extension HomeViewController {
    fileprivate func loadStatues() {
        NetworkTools.shareInstance.loadStatuses { (result, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            guard let resultArr = result else {
                return
            }
            for dict in resultArr {
                let status = StatusModel(dict: dict)
                let viewModel = StatusViewModel(status: status)
                self.statusesViewModel.append(viewModel)
            }
            self.tableView.reloadData()
        }
    }
}

//MARK: ------- tableView datasourceDelegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusesViewModel.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellId", for: indexPath) as! HomeViewCell
        cell.viewModel = statusesViewModel[indexPath.row]
        return cell
    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
}
