//
//  NetworkManager.swift
//  NetPictures
//
//  Created by Metalien on 2026/6/25.
//

import Foundation
import Alamofire

// MARK: 统一响应模型
class NetworkResponse: NSObject {
    var statusCode: Int = -1
    var error: Error?
    var responseObject: Any?
}

// MARK: 核心网络管理器
class NetworkManager: NSObject {
    
    var requestURL: String = ""
    var headers: [String: Any]?
    var params: [String: Any]?
    
    private(set) var session: Session
    var currentRequest: Request?
    var taskIdentifier: Int = 0
    
    override init() {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 15
        self.session = Session(configuration: config)
        super.init()
    }
    
    convenience init(formSerializer: Void) {
        self.init()
    }
    
    convenience init(jsonSerializer: Void) {
        self.init()
    }
    
    // MARK: Form表单请求
    class func getFormRequest(url: String,
                              headers: [String: Any]?,
                              params: [String: Any]?,
                              complete: @escaping (NetworkResponse) -> Void) -> NetworkManager {
        let manager = NetworkManager(formSerializer: ())
        manager.requestURL = url
        manager.headers = headers
        manager.params = params
        manager.startRequest(method: .get, encoding: URLEncoding.default, complete: complete)
        return manager
    }
    
    class func postFormRequest(url: String,
                               headers: [String: Any]?,
                               params: [String: Any]?,
                               complete: @escaping (NetworkResponse) -> Void) -> NetworkManager {
        let manager = NetworkManager(formSerializer: ())
        manager.requestURL = url
        manager.headers = headers
        manager.params = params
        manager.startRequest(method: .post, encoding: URLEncoding.default, complete: complete)
        return manager
    }
    
    // MARK: JSON请求
    class func getJsonRequest(url: String,
                              headers: [String: Any]?,
                              params: [String: Any]?,
                              complete: @escaping (NetworkResponse) -> Void) -> NetworkManager {
        let manager = NetworkManager(jsonSerializer: ())
        manager.requestURL = url
        manager.headers = headers
        manager.params = params
        manager.startRequest(method: .get, encoding: URLEncoding.default, complete: complete)
        return manager
    }
    
    class func postJsonRequest(url: String,
                               headers: [String: Any]?,
                               params: [String: Any]?,
                               complete: @escaping (NetworkResponse) -> Void) -> NetworkManager {
        let manager = NetworkManager(jsonSerializer: ())
        manager.requestURL = url
        manager.headers = headers
        manager.params = params
        manager.startRequest(method: .post, encoding: JSONEncoding.default, complete: complete)
        return manager
    }
    
    // MARK: 文件上传
    class func uploadFileRequest(url: String,
                                 filePath: String,
                                 progress: ((Progress?) -> Void)?,
                                 complete: @escaping (Any?, Error?) -> Void) {
        let fileUrl = URL(fileURLWithPath: filePath)
        AF.upload(fileUrl, to: url, method: .put)
            .uploadProgress { progressCallback in
                progress?(progressCallback)
            }
            .responseData { res in
                switch res.result {
                case .success(let data):
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data) {
                        complete(jsonObj, nil)
                    } else {
                        complete(data, nil)
                    }
                case .failure(let err):
                    complete(nil, err)
                }
            }
    }
    
    class func uploadDataRequest(url: String,
                                 data: Data,
                                 progress: ((Progress?) -> Void)?,
                                 complete: @escaping (Any?, Error?) -> Void) {
        AF.upload(data, to: url, method: .put)
            .uploadProgress { progressCallback in
                progress?(progressCallback)
            }
            .responseData { res in
                switch res.result {
                case .success(let data):
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data) {
                        complete(jsonObj, nil)
                    } else {
                        complete(data, nil)
                    }
                case .failure(let err):
                    complete(nil, err)
                }
            }
    }
    
    // MARK: 取消任务
    func cancelCurrentTask() {
        currentRequest?.cancel()
        taskIdentifier = -1
    }
    
    func cancelAllTasks() {
        session.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
        taskIdentifier = -1
    }
    
    // MARK: 私有请求核心
    private func startRequest(method: HTTPMethod, encoding: ParameterEncoding, complete: @escaping (NetworkResponse) -> Void) {
        var httpHeaders = HTTPHeaders()
        if let headerDic = headers {
            headerDic.forEach { key, value in
                httpHeaders.add(name: "\(key)", value: "\(value)")
            }
        }
        
        let request = session.request(
            requestURL,
            method: method,
            parameters: params,
            encoding: encoding,
            headers: httpHeaders
        )
        // 先保存请求对象
        self.currentRequest = request
        // 提前从request拿到taskIdentifier，不需要在回调里取
        self.taskIdentifier = request.task?.taskIdentifier ?? -1
        
        request.responseData { afResponse in
            let result = NetworkResponse()
            result.statusCode = afResponse.response?.statusCode ?? -1
            
            switch afResponse.result {
            case .success(let data):
                if let jsonObj = try? JSONSerialization.jsonObject(with: data) {
                    result.responseObject = jsonObj
                } else {
                    result.responseObject = data
                }
                result.error = nil
            case .failure(let err):
                result.error = err
                result.responseObject = nil
            }
            complete(result)
        }
    }
}
