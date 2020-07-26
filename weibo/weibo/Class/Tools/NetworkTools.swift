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
