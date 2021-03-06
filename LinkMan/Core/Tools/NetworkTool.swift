//
//  YMNetworkTool.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/7/30.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit
import AFNetworking
import MJRefresh
import MJExtension
import MBProgressHUD

class ETError: NSObject {
    
    var code:    String?
    var error:   String?
    var message: String?
}

class ETSuccess: NSObject {
    
    var success: String?
    var message: String?
}

class ImageData: NSObject {
    
    var url: String?
    var uri: String?
}

class NetworkTool: NSObject {
    /// 单例
    static let shareNetworkTool = NetworkTool()
    
    static let manager = AFHTTPSessionManager()
    
    func isRequestSuccess(_ result: NSDictionary) -> Bool {
        
        let string = result.object(forKey: "status") as! String
        let status = "ok"
        if string == status {
            return true
        }
        return false
    }
    
    /**
     判断网络是否可用
     
     - returns: true 可用 false 不可用
     */
    func judgeNetWork() ->String {
        
        AFNetworkReachabilityManager.shared().startMonitoring()
        var message:String!
        switch AFNetworkReachabilityManager.shared().networkReachabilityStatus{
        case .unknown:
            message = messageUnknown
            break
        case .notReachable:
            message = messageNotReachable
            break
        case .reachableViaWWAN:
            message = messageViaWWAN
            break
        case .reachableViaWiFi:
            message = messageViaWiFi
            break
        }

        return message
    }
    //个人信息详情请求
    func userInfoRequest(_ token: String, finishedSel:@escaping (_ data: MemberData)->(),failedSel:@escaping (_ error: ETError)->()){
        
        let url = BASE_URL+"/user/self"
        let params = ["token": token]
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters: params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                //json 转化成字典 并进行数据解析
                let data = result?.object(forKey: "data")
                // 字典转模型(MJExtension)
                let loginData = MemberData.mj_object(withKeyValues: data)
                finishedSel(loginData!)
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }

    //登陆请求
    func loginRequest(_ phone: String, password: String, finishedSel:@escaping (_ data: MemberData)->(),failedSel:@escaping (_ error: ETError)->()){
        
        let url = BASE_URL+"/login"
        let params = ["mobile": phone,
                      "password": password]
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters: params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                //json 转化成字典 并进行数据解析
                let data = result?.object(forKey: "data")
                // 字典转模型(MJExtension)
                let loginData = MemberData.mj_object(withKeyValues: data)
                finishedSel(loginData!)
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    //组织结构请求
    func departmentRequest(_ params: [String:String], finishedSel:@escaping (_ data:[DepartmentData])->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/user/list"
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                //json 转化成字典 并进行数据解析
                let data = result?.object(forKey: "data") as! NSArray
                // 字典转模型(MJExtension)
                
                let departData = DepartmentData.mj_objectArray(withKeyValuesArray: data).mutableCopy() as! [DepartmentData]
                
                for i in 0...data.count-1 {
                    let dic = data[i] as! NSDictionary
                    let members = dic.object(forKey: "member") as! NSArray
                    let member = MemberData.mj_objectArray(withKeyValuesArray: members)
                    let depart = departData[i]
                    depart.members = member
                }
                finishedSel(departData)
                
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    //联系人列表请求
    func contactsRequest(_ token: String,finishedSel:@escaping (_ data:[MemberData])->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/user/user"
        let params = ["token": token]
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                //json 转化成字典 并进行数据解析
                let data = result?.object(forKey: "data") as! NSArray
                // 字典转模型(MJExtension)
                let memberData = MemberData.mj_objectArray(withKeyValuesArray: data).mutableCopy() as! [MemberData]
                
                finishedSel(memberData)
                
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    
    //新增联系人请求
    func addContactsRequest(_ params:[String:String],finishedSel:@escaping (_ data:ETSuccess)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/user/add"
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                
                let success = ETSuccess()
                success.message = "请求成功"
                finishedSel(success)
                
            }else{
                
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    //个人编辑联系人请求
    func editMyInfoRequest(_ params:[String:String],finishedSel:@escaping (_ data:ETSuccess)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/user/save"
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                
                let success = ETSuccess()
                success.message = "请求成功"
                finishedSel(success)
                
            }else{
                
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    //经理编辑联系人请求
    func editContactsRequest(_ params:[String:String],finishedSel:@escaping (_ data:ETSuccess)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/user/levelSave"
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                
                let success = ETSuccess()
                success.message = "请求成功"
                finishedSel(success)
                
            }else{
                
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }

    //删除联系人请求
    func deleteFriendsContactsRequest(_ token: String,id: String,finishedSel:@escaping (_ data:ETSuccess)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/user/delete"
        let params = ["token": token,"id": id]
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                let success = ETSuccess()
                success.message = "请求成功"
                finishedSel(success)
                
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }

    //请假列表请求
    func applyleaveListRequest(_ params :[String:Any],finishedSel:@escaping (_ data:[LeaveData])->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/leave/self"
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                //json 转化成字典 并进行数据解析
                let data = result?.object(forKey: "data") as! NSArray
                // 字典转模型(MJExtension)
                let leaveData = LeaveData.mj_objectArray(withKeyValuesArray: data).mutableCopy() as! [LeaveData]
                finishedSel(leaveData)
                
            }else{
                
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    //请假申请请求
    func addleaveRequest(_ token: String,started: String,ended: String,time: String,reason: String,finishedSel:@escaping (_ data:ETSuccess)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/leave/add"
        let params = ["token": token,"started": started,"ended": ended,"time": time,"reason": reason]
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                let success = ETSuccess()
                success.message = "请求成功"
                finishedSel(success)
                
            }else{
                
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    //请假审批列表请求
    func examinedAndApprovedLeaveRequest(_ token: String, status: Int, isMust: Bool,finishedSel:@escaping (_ data:[LeaveData])->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/leave/list"
        let params:[String : Any]
        if isMust == true {
            params = ["token": token,"status": status] as [String : Any]
        }else{
            params = ["token": token]
        }
        
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            let result = response as? NSDictionary
            print("result:\(result)")
            if self.isRequestSuccess(result!){
                //json 转化成字典 并进行数据解析
                let data = result?.object(forKey: "data") as! NSArray
                // 字典转模型(MJExtension)
                let leaveData = LeaveData.mj_objectArray(withKeyValuesArray: data).mutableCopy() as! [LeaveData]
                finishedSel(leaveData)
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
        }) { (task:URLSessionDataTask?, error:Error?) in
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    //请假审批请求
    func approvedLeaveRequest(_ token: String,status: Int,id: Int,finishedSel:@escaping (_ data:ETSuccess)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/leave/save"
        let params = ["token": token,"status": status,"id": id] as [String : Any]
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            
            let result = response as? NSDictionary
            print("result:\(result)")
            
            if self.isRequestSuccess(result!){
                
                let success = ETSuccess()
                success.message = "请求成功"
                finishedSel(success)
                
            }else{
                
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
            
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    //请假详情请求
    func leaveDetailsRequest(_ token: String,id: Int,finishedSel:@escaping (_ data:LeaveData)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/leave/detail"
        let params = ["token": token,"id": id] as [String : Any]
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            let result = response as? NSDictionary
            print("result:\(result)")
            if self.isRequestSuccess(result!){
                //json 转化成字典 并进行数据解析
                let data = result?.object(forKey: "data")
                // 字典转模型(MJExtension)
                let leaveData = LeaveData.mj_object(withKeyValues: data) as LeaveData
                finishedSel(leaveData)
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
        }) { (task:URLSessionDataTask?, error:Error?) in
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    //删除请假请求
    func deleteleaveRequest(_ token: String,id: Int,finishedSel:@escaping (_ data:ETSuccess)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/leave/delete"
        let params = ["token": token,"id": id] as [String : Any]
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            let result = response as? NSDictionary
            print("result:\(result)")
            if self.isRequestSuccess(result!){
                let success = ETSuccess()
                success.message = "请求成功"
                finishedSel(success)
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
        }) { (task:URLSessionDataTask?, error:Error?) in
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    //请假详情请求
    func destroyleaveDetailsRequest(_ token: String,id: Int,finishedSel:@escaping (_ data:LeaveData)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/leave/detail"
        let params = ["token": token,"id": id] as [String : Any]
        print("url: \(url)")
        print("params: \(params)")
        
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            let result = response as? NSDictionary
            print("result:\(result)")
            if self.isRequestSuccess(result!){
                //json 转化成字典 并进行数据解析
                let data = result?.object(forKey: "data")
                // 字典转模型(MJExtension)
                let leaveData = LeaveData.mj_object(withKeyValues: data) as LeaveData
                finishedSel(leaveData)
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
        }) { (task:URLSessionDataTask?, error:Error?) in
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    //修改密码请求
    func editPasswordRequest(_ params: [String:String],finishedSel:@escaping (_ data:ETSuccess)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/user/savePassword"
        print("url: \(url)")
        print("params: \(params)")
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            let result = response as? NSDictionary
            print("result:\(result)")
            if self.isRequestSuccess(result!){
                let success = ETSuccess()
                success.message = "请求成功"
                finishedSel(success)
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
        }) { (task:URLSessionDataTask?, error:Error?) in
            print("加载失败...")
            
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }

    //头像上传请求
    func snapImageRequest(_ token: String,uri: String,finishedSel:@escaping (_ data:ETSuccess)->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/user/saveHeadImg"
        print("url: \(url)")
        let params = ["token": token,"url": uri]
        print("params: \(params)")
        NetworkTool.manager.get(url,parameters:params,success: { (task:URLSessionDataTask?, response:Any?) in
            let result = response as? NSDictionary
            print("result:\(result)")
            if self.isRequestSuccess(result!){
                let success = ETSuccess()
                success.message = "请求成功"
                finishedSel(success)
            }else{
                let errorDic = result?.object(forKey: "error")
                let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                failedSel(error)
            }
        }) { (task:URLSessionDataTask?, error:Error?) in
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    //图片上传请求
    func postImageRequest(_ images: NSArray,token: String,finishedSel:@escaping (_ data:[ImageData])->(),failedSel:@escaping (_ error:ETError)->()){
        let url = BASE_URL+"/uploadsurl"
        print("url: \(url)")
        let params = ["token": token]
        print("params: \(params)")
        let uploads = self.getImageDatasWithImages(images: images)
        
        NetworkTool.manager.post(url, parameters: params, constructingBodyWith: { (formData:AFMultipartFormData?) in
            
            for i in 0...uploads.count-1 {
                let proptys = uploads.object(at: i) as! NSArray
                let data = proptys[0] as! Data
                let type = proptys[1] as! String
                let fileName = String(format: "upload.%@", type)
                let contentType = String(format: "image/%@",type)
                formData?.appendPart(withFileData: data, name: "file[]", fileName: fileName, mimeType: contentType)
            }
            
            }, success: { (task:URLSessionDataTask?, response:Any?) in
                
                let result = response as? NSDictionary
                print("result:\(result)")
                if self.isRequestSuccess(result!){
                    //json 转化成字典 并进行数据解析
                    let data = result?.object(forKey: "data")
                    // 字典转模型(MJExtension)
                    let imageData = ImageData.mj_objectArray(withKeyValuesArray: data).mutableCopy() as! [ImageData]
                    finishedSel(imageData)
                }else{
                    let errorDic = result?.object(forKey: "error")
                    let error = ETError.mj_object(withKeyValues: errorDic) as ETError
                    failedSel(error)
                }
                
        }) { (task:URLSessionDataTask?, error:Error?) in
            
            print("加载失败...")
            let error = ETError()
            error.message = "服务器加载失败..."
            failedSel(error)
        }
    }
    
    
    func getImageDatasWithImages(images: NSArray) -> NSArray {
        
        let uploadDatas = NSMutableArray()
        for item in images {
            var data = Data()
            let meta = (item as AnyObject).firstObject as! UIImage
            let type = (item as AnyObject).lastObject as! String
            
            let image = meta;
            if "png" == type{
                data = self.compressImage(image: image, maxFileSize: 300000, isPngType: true)
            }else{
                data = self.compressImage(image: image, maxFileSize: 300000, isPngType: false)
            }
            uploadDatas.add([data,type])
        }
        return uploadDatas
    }
    func compressImage(image:UIImage, maxFileSize:NSInteger, isPngType:Bool) -> Data {
        
        var compression = 0.9
        let maxCompression = 0.1
        let scale = image.size.height/image.size.width;
        var size:CGSize
        var imageData = Data()
        if isPngType == true{
            imageData = UIImagePNGRepresentation(image)!
        }else{
            imageData = UIImageJPEGRepresentation(image, 1.0)!
        }
        //750宽或高的直接压缩到1280（720P）
        if image.size.height>1280||image.size.width>1280 {
            if(scale>1){
                size = CGSize(width: image.size.width*1280/image.size.height, height: 1280)
                if (scale>3) {
                    size = CGSize(width:image.size.width,height:image.size.height);
                }
            }else{
                size = CGSize(width:1280, height:image.size.height*1280/image.size.width);
            }
            imageData = self.scaledToSizeImage(image: image, newSize: size, compression: 1.0, isPngType: isPngType)
        }
        if imageData.count > maxFileSize && !isPngType{
            
            let imageTemp = UIImage(data: imageData)
            
            while (imageData.count > maxFileSize && compression > maxCompression) {
                
                imageData = UIImageJPEGRepresentation(imageTemp!, CGFloat(compression))!
                compression -= 0.1;
            }
        }
        return imageData;
    }
    func scaledToSizeImage(image:UIImage, newSize:CGSize, compression:CGFloat, isPngType:Bool) -> Data {
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if isPngType {
            return UIImagePNGRepresentation(newImage!)!
        }
        return UIImageJPEGRepresentation(newImage!, compression)!
    }
    
}
/*
 //注册请求
 func registerRequest(phone: String, password: String, finishedSel:(data: MemberData)->(),failedSel:(error: ETError)->()){
 
 let url = BASE_URL+"/a3/login/index"
 let params = ["mobile": phone,
 "password": password]
 print("url: \(url)")
 print("params: \(params)")
 Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
 guard response.result.isSuccess else {
 print("加载失败...")
 return
 }
 let result = response.result.value as? NSDictionary
 print("result: \(result)")
 if self.isRequestSuccess(result!){
 //json 转化成字典 并进行数据解析
 let data = result?.objectForKey("data")
 // 字典转模型(MJExtension)
 let loginData = MemberData.mj_objectWithKeyValues(data)
 finishedSel(data: loginData)
 }else{
 let errorDic = result?.objectForKey("error")
 let error = ETError.mj_objectWithKeyValues(errorDic) as ETError
 failedSel(error: error)
 } }
 
 }
 
 //组织架构
 func departmentRequest(finishedSel:(data:[DepartmentData])->(),failedSel:(error:ETError)->()){
 
 let url = BASE_URL+"/user/list"
 print("url: \(url)")
 Alamofire.request(.GET, url).responseJSON { (response) in
 guard response.result.isSuccess else {
 print("加载失败...")
 return
 }
 let result = response.result.value as? NSDictionary
 print("result: \(result)")
 if self.isRequestSuccess(result!){
 //json 转化成字典 并进行数据解析
 let data = result?.objectForKey("data")
 
 // 字典转模型(MJExtension)
 let dataArray = DepartmentData.mj_objectArrayWithKeyValuesArray(data).mutableCopy() as! [DepartmentData]
 
 for departmentData:DepartmentData in dataArray {
 
 print("members\(departmentData.members)")
 }
 
 finishedSel(data: dataArray)
 }else{
 let errorDic = result?.objectForKey("error")
 let error = ETError.mj_objectWithKeyValues(errorDic) as ETError
 failedSel(error: error)
 }
 }
 }
 */
/*
 
 /// ------------------------ 首 页 -------------------------
 //
 /// 获取首页顶部标题内容(和视频内容使用一个接口)
 func loadHomeTitlesData(finished:(topTitles: [YMHomeTopTitle])->()) {
 let url = BASE_URL + "article/category/get_subscribed/v1/?"
 let params = ["device_id": device_id,
 "aid": 13,
 "iid": IID]
 Alamofire
 .request(.GET, url, parameters: params)
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 let dataDict = json["data"].dictionary
 if let data = dataDict!["data"]!.arrayObject {
 var topics = [YMHomeTopTitle]()
 for dict in data {
 let title = YMHomeTopTitle(dict: dict as! [String: AnyObject])
 topics.append(title)
 }
 finished(topTitles: topics)
 }
 }
 }
 }
 
 /// 获取首页不同分类的新闻内容(和视频内容使用一个接口)
 func loadHomeCategoryNewsFeed(category: String, tableView: UITableView, finished:(nowTime: NSTimeInterval,newsTopics: [YMNewsTopic])->()) {
 let url = BASE_URL + "api/news/feed/v39/?"
 let params = ["device_id": device_id,
 "category": category,
 "iid": IID]
 tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
 let nowTime = NSDate().timeIntervalSince1970
 Alamofire
 .request(.GET, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 tableView.mj_header.endRefreshing()
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 let datas = json["data"].array
 var topics = [YMNewsTopic]()
 for data in datas! {
 let content = data["content"].stringValue
 let contentData: NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
 do {
 let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
 print(dict)
 let topic = YMNewsTopic(dict: dict as! [String : AnyObject])
 topics.append(topic)
 } catch {
 SVProgressHUD.showErrorWithStatus("获取数据失败!")
 }
 
 }
 finished(nowTime: nowTime, newsTopics: topics)
 }
 }
 })
 tableView.mj_header.automaticallyChangeAlpha = true //根据拖拽比例自动切换透
 tableView.mj_header.beginRefreshing()
 }
 
 /// 获取首页不同分类的新闻内容
 func loadHomeCategoryMoreNewsFeed(category: String, lastRefreshTime: NSTimeInterval, tableView: UITableView, finished:(moreTopics: [YMNewsTopic])->()) {
 let url = BASE_URL + "api/news/feed/v39/?"
 let params = ["device_id": device_id,
 "category": category,
 "iid": IID,
 "last_refresh_sub_entrance_interval": lastRefreshTime]
 tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
 Alamofire
 .request(.GET, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 tableView.mj_footer.endRefreshing()
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 let datas = json["data"].array
 var topics = [YMNewsTopic]()
 for data in datas! {
 let content = data["content"].stringValue
 let contentData: NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
 do {
 let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
 let topic = YMNewsTopic(dict: dict as! [String : AnyObject])
 topics.append(topic)
 } catch {
 SVProgressHUD.showErrorWithStatus("获取数据失败!")
 }
 }
 finished(moreTopics: topics)
 }
 }
 })
 }
 
 /// 首页 -> 『+』点击，添加标题，获取推荐标题内容
 func loadRecommendTopic(finished:(recommendTopics: [YMHomeTopTitle]) -> ()) {
 let url = "https://lf.snssdk.com/article/category/get_extra/v1/?"
 let params = ["device_id": device_id,
 "aid": 13,
 "iid": IID]
 Alamofire
 .request(.GET, url, parameters: params)
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let data = json["data"].arrayObject {
 var topics = [YMHomeTopTitle]()
 for dict in data {
 let title = YMHomeTopTitle(dict: dict as! [String: AnyObject])
 topics.append(title)
 }
 finished(recommendTopics: topics)
 }
 }
 }
 }
 
 /// -------------------------- 视 频 --------------------------
 //
 /// 获取视频顶部标题内容
 func loadVideoTitlesData(finished:(topTitles: [YMVideoTopTitle])->()) {
 // version_code 表示今日头条的版本号，经过测试 >= 5.6 版本新增了『火山直播』
 // os_version 表示 iOS 的系统版本，经测试 >= 8.0 版本新增了『火山直播』
 let url = BASE_URL + "video_api/get_category/v1/?"
 let params = ["device_id": device_id,
 "version_code": "5.7.1",
 "iid": IID,
 "device_platform": "iphone",
 "os_version": "9.3.2"]
 Alamofire
 .request(.GET, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let data = json["data"].arrayObject {
 var titles = [YMVideoTopTitle]()
 for dict in data {
 let title = YMVideoTopTitle(dict: dict as! [String: AnyObject])
 titles.append(title)
 }
 finished(topTitles: titles)
 }
 }
 }
 }
 
 /// 获取发布用户的信息
 func loadVideoMediaEntry(entry_id: Int, finished:(mediaEntry: YMMediaEntry) -> ()) {
 let url = BASE_URL + "entry/profile/v1/?"
 let params = ["entry_id": entry_id]
 Alamofire
 .request(.GET, url, parameters: params)
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let data = json["data"].dictionaryObject {
 let media = YMMediaEntry(dict: data)
 finished(mediaEntry: media)
 }
 }
 }
 }
 
 /// -------------------------- 关 心 --------------------------
 //
 /// 获取新的 关心数据列表
 func loadNewConcernList(tableView: UITableView, finished:(topConcerns: [YMConcern], bottomConcerns: [YMConcern]) -> ()) {
 let url = BASE_URL + "concern/v1/concern/list/"
 let params = ["iid": IID,
 "count": 20,
 "offset": 0,
 "type": "manage"]
 tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
 Alamofire
 .request(.POST, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 tableView.mj_header.endRefreshing()
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let concern_list = json["concern_list"].arrayObject {
 var topConcerns = [YMConcern]()
 var bottomConcerns = [YMConcern]()
 for dict in concern_list {
 let concern = YMConcern(dict: dict as! [String: AnyObject])
 (concern.concern_time != 0) ? topConcerns.append(concern) : bottomConcerns.append(concern)
 }
 finished(topConcerns: topConcerns, bottomConcerns: bottomConcerns)
 }
 }
 }
 })
 tableView.mj_header.automaticallyChangeAlpha = true //根据拖拽比例自动切换透明度
 tableView.mj_header.beginRefreshing()
 }
 
 /// 获取新的 关心数据列表，不显示上拉刷新
 func loadNewConcernListHiddenPullRefresh(finished:(topConcerns: [YMConcern], bottomConcerns: [YMConcern]) -> ()) {
 let url = BASE_URL + "concern/v1/concern/list/"
 let params = ["iid": IID,
 "count": 20,
 "offset": 0,
 "type": "manage"]
 Alamofire
 .request(.POST, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let concern_list = json["concern_list"].arrayObject {
 var topConcerns = [YMConcern]()
 var bottomConcerns = [YMConcern]()
 for dict in concern_list {
 let concern = YMConcern(dict: dict as! [String: AnyObject])
 (concern.concern_time != 0) ? topConcerns.append(concern) : bottomConcerns.append(concern)
 }
 finished(topConcerns: topConcerns, bottomConcerns: bottomConcerns)
 }
 }
 }
 }
 
 /// 获取更多 关心数据列表
 func loadMoreConcernList(tableView: UITableView, outOffset: Int, finished:(inOffset: Int, topConcerns: [YMConcern], bottomConcerns: [YMConcern]) -> ()) {
 let url = BASE_URL + "concern/v1/concern/list/"
 let params = ["iid": IID,
 "count": 20,
 "offset": outOffset,
 "type": "recommend"]
 tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
 Alamofire
 .request(.POST, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 tableView.mj_footer.endRefreshing()
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 let inOffset = json["offset"].int!
 if let concern_list = json["concern_list"].arrayObject {
 var topConcerns = [YMConcern]()
 var bottomConcerns = [YMConcern]()
 for dict in concern_list {
 let concern = YMConcern(dict: dict as! [String: AnyObject])
 (concern.concern_time != 0) ? topConcerns.append(concern) : bottomConcerns.append(concern)
 }
 finished(inOffset: inOffset, topConcerns: topConcerns, bottomConcerns: bottomConcerns)
 }
 }
 }
 })
 }
 
 /// 关心界面 -> 底部 cell 的『关心』按钮 点击
 func bottomCellDidClickedCareButton(concernID: String, tableView: UITableView, finish:(topConcerns: [YMConcern], bottomConcerns: [YMConcern])->()) {
 let url = BASE_URL + "concern/v1/commit/care/"
 let params = ["iid": IID, "concern_id": concernID]
 Alamofire
 .request(.POST, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 YMNetworkTool.shareNetworkTool.loadNewConcernListHiddenPullRefresh({ (topConcerns, bottomConcerns) in
 finish(topConcerns: topConcerns, bottomConcerns: bottomConcerns)
 })
 }
 
 }
 
 /// 关心界面 -> 搜索关心类别和内容
 func loadSearchResult(keyword: String, finished:(keywords: [YMKeyword]) -> ()) {
 let url = BASE_URL + "2/article/search_sug/?keyword=\(keyword)"
 Alamofire
 .request(.GET, url)
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let datas = json["data"].arrayObject {
 var keywords = [YMKeyword]()
 for data in datas {
 let keyword = YMKeyword(dict: data  as! [String: AnyObject])
 keywords.append(keyword)
 }
 finished(keywords: keywords)
 }
 }
 }
 }
 */
