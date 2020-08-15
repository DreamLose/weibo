//
//  OauthController.swift
//  weibo
//
//  Created by 2020 on 2020/7/27.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
class OauthController: UIViewController {
    @IBOutlet weak var oauthWeb: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oauthWeb.navigationDelegate = self
        setNavgitionBar()
        loadPage()
//        https://api.weibo.com/oauth2/authorize?client_id=283339824&redirect_uri=http://www.baidu.com#
//        oauthWeb.load(URLRequest(url: URL(string: "http://www.baidu.com")!))
    }
}
extension OauthController {
    fileprivate func setNavgitionBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(self.closeClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(self.fillClick))
        title = "登录"
    }
    fileprivate func loadPage(){
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_url)"
//        创建url
        guard let url = URL(string: urlString) else {return}
//        创建request
        let request = URLRequest(url: url)
        oauthWeb.load(request)
    }
}

//MARK: ------- 事件点击
extension OauthController {
    @objc fileprivate func closeClick() {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func fillClick(){
//        书写js代码
        let jscode = "document.getElementById('userId').value='18518327828';document.getElementById('passwd').value='zhuimeng870224'"
        oauthWeb.evaluateJavaScript(jscode) { (data, error) in
            print("填充完成")
        }
    }
}


//MARK: ------- webview代理
extension OauthController : WKNavigationDelegate {
//    开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
//    网页加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
//    网页加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let urlString = navigationAction.request.url?.absoluteString else {
            decisionHandler(WKNavigationActionPolicy.allow);
            return
        }
        guard urlString.contains("code") else {
             decisionHandler(WKNavigationActionPolicy.allow)
            return
        }
        let result = urlString.components(separatedBy: "code=").last!
        loadAccessToken(code: result)
        decisionHandler(WKNavigationActionPolicy.cancel);

    }

    
    
    
}
//MARK: -------   获取accessToken
//["remind_in": 157679999, "access_token": 2.00uiKdQG0KdrK_84df6760ea5rRjdE, "expires_in": 157679999, "isRealName": true, "uid": 5742554384]
extension OauthController {
    fileprivate func loadAccessToken(code:String){
        NetworkTools.shareInstance.loadAccessToken(code: code) { (result, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            guard let accountDict = result else {
                print("没有获取到授权数据")
                return
            }
            let account = UserAccount(dict: accountDict)
            self.loadUserInfo(account: account)
            
        }
    }
}
//MARK: -------    请求用户信息
extension OauthController {
    fileprivate func loadUserInfo(account : UserAccount) {
        guard let accessToken = account.access_token else {
            return
        }
        guard let uid = account.uid else {
            return
        }
        NetworkTools.shareInstance.loadUserInfo(access_token: accessToken, uid: uid) { (result, error) in
            if error != nil {
                return
            }
            guard let userInfoDict = result else {
                return
            }
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
//            将account 对象保存
//             获取沙盒路径
            NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountViewModel.sharIntance.accountPath)
//            将account 设置到单利对象
            UserAccountViewModel.sharIntance.account = account
//            退出当前控制器
            self.dismiss(animated: false) {
//                显示欢迎界面
                UIApplication.shared.keyWindow?.rootViewController = WelComeController()
            }
        }
    }
}
