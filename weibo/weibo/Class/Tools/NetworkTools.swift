//
//  NetworkTools.swift
//  AFNTools
//
//  Created by 2020 on 2020/7/26.
//  Copyright © 2020 2020. All rights reserved.
//

import AFNetworking
enum RequestType {
    case GET
    case POST
}
class NetworkTools: AFHTTPSessionManager {
    //let 线程安全
//    单利
    static let shareInstance : NetworkTools = {
       let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
}
//MARK: -------  封装请求方法
extension NetworkTools {
    func request(httpType : RequestType,urlString : String,parameters:[String : Any],finished:@escaping(_ result : Any?,_ error : Error?) -> ()) {
        //成功闭包
        let successCallBack = { (task:URLSessionDataTask, result:Any) in
                finished(result, nil)
            }
//        失败闭包
        let failureCallback = { (task:URLSessionDataTask? , error:Error) in
            finished(nil, error)
        }
        //发送网络请求
        if httpType == .GET  {
            
            get(urlString, parameters: parameters, headers: nil, progress: nil, success: successCallBack, failure: failureCallback)
        }else {
            post(urlString, parameters: parameters, headers: nil, progress: nil, success: successCallBack, failure: failureCallback)
        }
    }
}
//MARK: ------- 获取令牌
extension NetworkTools {
    func loadAccessToken(code : String, finished : @escaping(_ result : [String : Any]?,_ error : Error?)->()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let param = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_url, "code" : code]
        request(httpType: .POST, urlString: urlString, parameters: param) { (result, error) in
            finished(result as? [String : Any],error)
        }
    }
}

//MARK: ------- 请求用户信息
extension NetworkTools {
//    https://api.weibo.com/2/users/show.json
    func loadUserInfo(access_token : String,uid : String, finished : @escaping(_ result : [String : Any]?,_ error : Error?)->()) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        let param = ["access_token" : access_token,"uid" : uid]
    
        request(httpType: .GET, urlString: urlString, parameters: param) { (result, error) in
          
            finished(result as? [String : Any],error)
        }
    }
}
extension NetworkTools {
    func loadStatuses(finished : @escaping(_ result:[[String : Any]]?,_ error : Error?) -> ()) {
//
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["access_token" : (UserAccountViewModel.sharIntance.account?.access_token)!]
        request(httpType: .GET, urlString: urlString, parameters: parameters) { (result, error) in
//            获取字典数据
            guard let resultDict = result as? [String : Any] else {
                finished(nil,error)
                return
            }
            finished(resultDict["statuses"] as? [[String : Any]],error)
        }
        
        
    }
}
