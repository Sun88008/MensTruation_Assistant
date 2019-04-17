//
//  SetTouXiangViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/14.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud

class SetTouXiangViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    @IBAction func changeTouXiangbtm(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "更换照片", message: nil,
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let cameraAction = UIAlertAction(title: "拍照", style: .default, handler: {
            (a:UIAlertAction)in
            
            let pickerController = UIImagePickerController.init()
            pickerController.delegate = self
            pickerController.allowsEditing = true
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            self.present(pickerController, animated: true, completion: nil)
        })
        let selectPhotoAction = UIAlertAction(title: "从手机相册选择", style: .default, handler: {
            (a:UIAlertAction)in
            
            let pickerController = UIImagePickerController.init()
            pickerController.delegate = self
            pickerController.allowsEditing = true
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        })
        let savePhotoAction = UIAlertAction(title: "保存图片", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(selectPhotoAction)
        alertController.addAction(savePhotoAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBOutlet weak var touXiang: UIImageView!
    //选取照片代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        touXiang.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        touXiang.isUserInteractionEnabled = true
        let data=UIImagePNGRepresentation((touXiang?.image!)!)
        let file=AVFile(data: data!)
        
//        var obj: AVObject?
//        obj?.setObject(file, forKey: "portrait")

        
//        let user=LCUser()
//        user.username=LCString("Ds")
//        user.password=LCString("123")
        let users = AVUser.current()
        users?.setValue(file, forKey: "protrait")
        
//        let user = LCUser.current!//初始化当前用户信息
//        user.setValue(file, forKey: "protrait")
//        user.setValue(touXiang.image, forKey: "protrait")
//        user.save { result in
//            switch result {
//            case .success:
//                print("protrait setted!")
//                break
//            case .failure(let error):
//                print(error)
//            }
//        }
//        LCUser.logIn(username: "Ds", password: "123") { (result) in
//            switch result {
//            case .success(let user):
//                print("success!\n\n\n\n\n\n\n")
//
//                let obj = AVObject(className: "_User", objectId: "5cb52c34c8959c0075a414a8")
////                let obj = AVObject(className: "_User")//选择所在类
//                obj.setObject(file, forKey: "protrait")
//                obj.saveInBackground({ (resultbool, error) in
//                    if(resultbool){
//                        print("save protrait succeed")
//                    }else{
//                        print(error)
//                    }
//                })
//                break
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        touXiang.image = #imageLiteral(resourceName: "touxiang")
        
//        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
//        let documentsDirectory: NSString = paths.object(at: 0) as! NSString
//        let imagePath: NSString = documentsDirectory.strings(byAppendingPaths: ["LeanCLoud.png"]) as! NSString
//        let error: NSError = NSError.init()
//        let file: AVFile = AVFile.localPath(imagePath)
        
//        if let url = Bundle.main.url(forResource: "LeanCloud", withExtension: "png") {
//            let file = LCFile(payload: .fileURL(fileURL: url))
//            file.save(
//                progress: { progress in
//                    print(progress)
//            },
//                completion: { result in
//                    switch result {
//                    case .success:
//                        break
//                    case .failure(let error):
//                        break
//                    }
//            })
//        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
