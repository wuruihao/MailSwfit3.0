//
//  MemberInfoController.swift
//  Mail
//
//  Created by Enjoytouch on 16/9/18.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class MemberInfoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    var isFullScreen: Bool = false
    
    @IBOutlet weak var sanpImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchChangegAction(_ sender: UITapGestureRecognizer) {
        
        switch (sender.view?.tag)! as Int {
            //头像编辑
        case 0:
            
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = true
            
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "照相机", style: .default, handler: { (action:UIAlertAction) in
                self.openCameraAction()
            }))
            alertController.addAction(UIAlertAction(title: "从相册选择", style: .default, handler: { (action:UIAlertAction) in
                
                self.openPhotoLibraryAction()
            }))
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            
            break
            //昵称编辑
        case 1:
            
            self.navigationController?.pushViewController(EditNickNameController(), animated: true)
            
            break
        case 2:
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "男", style: .default, handler: { (action:UIAlertAction) in
                
                self.sexLabel.text = "男"
                
            }))
            alertController.addAction(UIAlertAction(title: "女", style: .default, handler: { (action:UIAlertAction) in
                
                self.sexLabel.text = "女"
            }))
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            
            break
        case 3:
            
            break
        default:
            break
        }
        
    }
    
    
    func openPhotoLibraryAction(){
        
        //是否获得权限
        let authorizationStatus = ALAssetsLibrary.authorizationStatus()
        if (authorizationStatus == .denied || authorizationStatus == .restricted){
            //无权限
            // 展示提示语
            let mainInfoDictionary = Bundle.main.infoDictionary! as NSDictionary
            let appName = mainInfoDictionary.object(forKey: "CFBundleName")
            let alertView = UIAlertView(title: "无法访问相册", message: "请在设备的\"设置-隐私-照片\"选项中,允许\(appName)访问你的手机相册", delegate: self, cancelButtonTitle: "知道了")
            alertView.show()
            return
        }
        // 设置类型
        self.imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //改navigationBar背景色
        self.imagePickerController.navigationBar.barTintColor = UIColor(red: 171/255, green: 202/255, blue: 41/255, alpha: 1.0)
        //改navigationBar标题色
        self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //改navigationBar的button字体色
        self.imagePickerController.navigationBar.tintColor = UIColor.white
        self.present(self.imagePickerController, animated: true, completion: nil)
        
    }
    
    func openCameraAction(){
        
        //是否获得权限
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if (authStatus == .notDetermined || authStatus == .denied || authStatus == .restricted){
            //无权限
            let alertView = UIAlertView(title: "无法访问相机", message: "请在'设置->隐私->相机'设置为打开状态", delegate: self, cancelButtonTitle: "知道了")
            alertView.show()
            return
        }
        // 判断是否支持相机
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            //判断如果没有相机就调用图片库
            let alertView = UIAlertView(title: nil, message: "设备不支持照相功能", delegate: self, cancelButtonTitle: "知道了")
            alertView.show()
            return
        }
        // 设置类型
        self.imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    //实现ImagePicker delegate 事件
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        var image: UIImage!
        // 判断，图片是否允许修改
        if(picker.allowsEditing){
            //裁剪后图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //原始图片
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        /* 此处info 有六个值
         * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
         * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
         * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
         * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
         * UIImagePickerControllerMediaURL;       // an NSURL
         * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
         * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
         */
        // 保存图片至本地，方法见下文
        //self.saveImage(image, newSize: CGSize(width: 256, height: 256), percent: 0.5, imageName: "currentImage.png")
        let fullPath = NSHomeDirectory() + "/Documents/currentImage.png"
        print("fullPath=\(fullPath)")
        let savedImage: UIImage = UIImage(contentsOfFile: fullPath)!
        self.isFullScreen = false
        self.sanpImage.image = savedImage
        //在这里调用网络通讯方法，上传头像至服务器...
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //保存图片至沙盒
    func saveImage(_ currentImage: UIImage, newSize: CGSize, percent: CGFloat, imageName: String){
        //压缩图片尺寸
        UIGraphicsBeginImageContext(newSize)
        currentImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //高保真压缩图片质量
        //UIImageJPEGRepresentation此方法可将图片压缩，但是图片质量基本不变，第二个参数即图片质量参数。
        let imageData: Data = UIImageJPEGRepresentation(newImage, percent)!
        // 获取沙盒目录,这里将图片放在沙盒的documents文件夹中
        let fullPath = NSHomeDirectory() + "/Documents/currentImage.png"
        // 将图片写入文件
        try? imageData.write(to: URL(fileURLWithPath: fullPath), options: [])
    }
    
    //实现点击图片预览功能，滑动放大缩小，带动画
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.isFullScreen = !self.isFullScreen
        
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint  = touch.location(in: self.view)
        let imagePoint: CGPoint = self.sanpImage.frame.origin
        //touchPoint.x ，touchPoint.y 就是触点的坐标
        // 触点在imageView内，点击imageView时 放大,再次点击时缩小
        if(imagePoint.x <= touchPoint.x && imagePoint.x + self.sanpImage.frame.size.width >= touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.sanpImage.frame.size.height >= touchPoint.y){
            // 设置图片放大动画
            UIView.beginAnimations(nil, context: nil)
            // 动画时间
            UIView.setAnimationDuration(1)
            
            if (isFullScreen) {
                // 放大尺寸
                self.sanpImage.frame = CGRect(x: 0, y: 0, width: 480, height: 320)
            }
            else {
                // 缩小尺寸
                self.sanpImage.frame = CGRect(x: 100, y: 100, width: 128, height: 128)
            }
            // commit动画
            UIView.commitAnimations()
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
