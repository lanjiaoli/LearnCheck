//
//  ViewController.swift
//  MoyaTest
//
//  Created by L on 2020/2/22.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let NetProvider = MoyaProvider<LJNetworking>()
//        NetProvider.request(.channels) { (result) in
//                  if case let .success(response) = result { response.data
//                      //
//                      let data = try? response.mapJSON()  //请求response转化为JSON格式
////                      let json = JSON(data!)  //转化为JSON数据格式
////                      print("channels 接口数据:\(json["channels"].arrayValue)")
//                  }
//
//                  //主线程刷新UI
//                  DispatchQueue.main.async {
//                      // self.tableView.reloadData()
//                  }
//              }
//        Observable.of(1,2,3).subscribe({print($0)})
//        
//        ObservableSequence
        _ = Observable<String>.create({ (obserber) -> Disposable in
            obserber.onNext("RXSwift 学习")
            return Disposables.create()
        }).subscribe({ (text) in
            print("订阅到：\(text)")
        })
    }


}
//extension ObservableType {
//
//    public static func of(_ elements: Element ..., scheduler: ImmediateSchedulerType = CurrentThreadScheduler.instance) -> Observable<Element> {
//        return ObservableSequence(elements: elements, scheduler: scheduler)
//    }
//}
public enum LJNetworking {
    case channels                        //获取频道接口
    case playlist(String)                //获取歌曲接口
    case otherRequest                   // 其他接口,没有参数
}
extension LJNetworking: TargetType{
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "https://www.douban.com")!
            
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        case .otherRequest:
            return URL(string: "https://douban.fm/default.html")!
        }

    }
    
    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
            
        case .playlist(_):
            return "/j/mine/playlist"
            
        case .otherRequest:
            return "/default/otherRequest"
        }
    }
    
    
    //请求方式
    public var method: Moya.Method {
        switch self {
        case .channels:
            return .get
            
        case .playlist(_):
            return .get
            
        default:
            return .post
        }
    }
    
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        var param: [String: Any] = [:]
        switch self {
        case .playlist(let channel):
            param["channel"] = channel
            param["type"] = "n"
            param["from"] = "mainsite"
            break
        
        case .channels: break
            
        case .otherRequest:
            return .requestPlain
        }
        
        return .requestParameters(parameters: param, encoding: URLEncoding.default)
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8, allowLossyConversion: true)!
    }
    
    //请求头设置
    public var headers: [String : String]? {
        return nil
    }
}
