//
//  SignViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/4.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
import SnapKit
import Alamofire

class SignViewController: UIViewController, UITextFieldDelegate, SearchTableViewDelegate {
    //收起键盘
    func hideKeyBoard() {
        self.txtUser.resignFirstResponder()
        self.txtPwd.resignFirstResponder()
    }
    
    
    var txtUser: UITextField! //用户名输入框
    var txtPwd: UITextField! //密码输入款
    var formView: UIView! //登陆框视图
    var horizontalLine: UIView! //分隔线
    var confirmButton: UIButton! //登录按钮
    var register: UIButton! //注册按钮
    var titleLabel: UILabel! //标题标签
    var imgLogin: UIImageView!
    var alert: UIAlertController! //密码错误提示框
    
    var topConstraint: Constraint? //登录框距顶部距离约束

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser: AVUser! = AVUser.current()
        if (currentUser != nil) {
            // 跳转到首页
            let first = self.storyboard
            let secondView:UIViewController = first?.instantiateViewController(withIdentifier: "TarBar") as! UIViewController
            self.present(secondView, animated: true, completion: nil)
        } else {
            //缓存用户对象为空时，可打开用户注册界面…
        }
                
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tap)
        //视图背景色
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        
        /*//登录框高度
        let formViewHeight = 90
        //登录框背景
        self.formView = UIView()
        self.formView.layer.borderWidth = 0.5
        self.formView.layer.borderColor = UIColor.lightGray.cgColor
        self.formView.backgroundColor = UIColor.white
        self.formView.layer.cornerRadius = 5
        self.view.addSubview(self.formView)
        //最常规的设置模式
        self.formView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            //存储top属性
            self.topConstraint = make.centerY.equalTo(self.view).constraint
            make.height.equalTo(formViewHeight)
        }
        
        //分隔线
        self.horizontalLine =  UIView()
        self.horizontalLine.backgroundColor = UIColor.lightGray
        self.formView.addSubview(self.horizontalLine)
        self.horizontalLine.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.centerY.equalTo(self.formView)
        }
        
        //用户名图标
        let imgLock1 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock1.image = UIImage(named:"icon_zhanghao")
        
        //密码图标
        let imgLock2 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock2.image = UIImage(named:"mima")*/
        
        //用户名输入框
        /*self.txtUser = UITextField()
        self.txtUser.delegate = self
        self.txtUser.placeholder = "用户名"
        self.txtUser.tag = 100
        self.txtUser.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        self.txtUser.leftViewMode = UITextFieldViewMode.always
        self.txtUser.returnKeyType = UIReturnKeyType.next*/
        
        //用户名输入框左侧图标
        /*self.txtUser.leftView!.addSubview(imgLock1)
        self.formView.addSubview(self.txtUser)
        
        //布局
        self.txtUser.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(self.formView).offset(-formViewHeight/4)
        }
        
        //密码输入框
        self.txtPwd = UITextField()
        self.txtPwd.delegate = self
        self.txtPwd.placeholder = "密码"
        self.txtPwd.tag = 101
        self.txtPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        self.txtPwd.leftViewMode = UITextFieldViewMode.always
        self.txtPwd.returnKeyType = UIReturnKeyType.next
        
        //密码输入框左侧图标
        self.txtPwd.leftView!.addSubview(imgLock2)
        self.formView.addSubview(self.txtPwd)
        
        //布局
        self.txtPwd.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(self.formView).offset(formViewHeight/4)
        }
        
        //登录按钮
        self.confirmButton = UIButton()
        self.confirmButton.setTitle("登录", for: UIControlState())
        self.confirmButton.setTitleColor(UIColor.black,
                                         for: UIControlState())
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1,alpha: 0.5)
        self.confirmButton.addTarget(self, action: #selector(loginConfrim),for: .touchUpInside)
        self.view.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.top.equalTo(self.formView.snp.bottom).offset(20)
            make.right.equalTo(-15)
            make.height.equalTo(44)
        }*/
        
        /*//标题label
        self.titleLabel = UILabel()
        self.titleLabel.text = ""//"姨妈助手"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 36)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.formView.snp.top).offset(-20)
            make.centerX.equalTo(self.view)
            make.height.equalTo(44)
        }*/
        
        //获取屏幕尺寸
        let mainSize = UIScreen.main.bounds.size
        
        //猫头鹰头部
        self.imgLogin = UIImageView(frame: CGRect(x: mainSize.width/2-211/2, y: 100, width: 211, height: 109))
        imgLogin.image = UIImage(named:"owl-login")
        imgLogin.layer.masksToBounds = true
        self.view.addSubview(imgLogin)
        
        
        //猫头鹰左手(遮眼睛的)
        let rectLeftHand = CGRect(x:61 - offsetLeftHand, y:90, width:40, height:65)
        imgLeftHand = UIImageView(frame:rectLeftHand)
        imgLeftHand.image = UIImage(named:"owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        //猫头鹰右手(遮眼睛的)
        let rectRightHand = CGRect(x:imgLogin.frame.size.width / 2 + 60, y:90, width:40, height:65)
        imgRightHand = UIImageView(frame:rectRightHand)
        imgRightHand.image = UIImage(named:"owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        
        //登录框背景
        let vLogin =  UIView(frame:CGRect(x:15, y:200, width:mainSize.width - 30, height:160))
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.cornerRadius = 10 //四周角的尖锐度
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        vLogin.backgroundColor = UIColor.white
        self.view.addSubview(vLogin)
        
        //登录按钮
        self.confirmButton = UIButton()
        self.confirmButton.setTitle("登录", for: UIControlState())
        self.confirmButton.setTitleColor(UIColor.black,
                                         for: UIControlState())
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1,alpha: 0.5)
        self.confirmButton.addTarget(self, action: #selector(loginConfrim),for: .touchUpInside)
        self.view.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.top.equalTo(vLogin.snp.bottom).offset(20)
            make.right.equalTo(-15)
            make.height.equalTo(44)
        }
        
        //注册按钮
        self.register = UIButton()
        self.register.setTitle("注册", for: UIControlState())
        self.register.setTitleColor(UIColor.black,
                                         for: UIControlState())
        self.register.layer.cornerRadius = 5
        self.register.backgroundColor = UIColor(red: 1, green: 1, blue: 1,alpha: 0.5)
        self.register.addTarget(self, action: #selector(registerbtm),for: .touchUpInside)
        self.view.addSubview(self.register)
        self.register.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.top.equalTo(confirmButton.snp.bottom).offset(20)
            make.right.equalTo(-15)
            make.height.equalTo(44)
        }
        
        //用户名框
        txtUser = UITextField(frame:CGRect(x:30, y:30, width:vLogin.frame.size.width - 60, height:44))
        txtUser.delegate = self
        txtUser.placeholder = "用户名"
        txtUser.layer.cornerRadius = 5
        txtUser.layer.borderColor = UIColor.lightGray.cgColor
        txtUser.layer.borderWidth = 0.5
        txtUser.leftView = UIView(frame:CGRect(x:0, y:0, width:44, height:44))
        txtUser.leftViewMode = UITextFieldViewMode.always
        
        let imgUser =  UIImageView(frame:CGRect(x:11, y:11, width:22, height:22))
        imgUser.image = UIImage(named:"icon_zhanghao")
        txtUser.leftView!.addSubview(imgUser)
        vLogin.addSubview(txtUser)
        
        //密码输入框
        txtPwd = UITextField(frame:CGRect(x:30, y:90, width:vLogin.frame.size.width - 60, height:44))
        txtPwd.delegate = self
        txtPwd.placeholder = "密码"
        txtPwd.layer.cornerRadius = 5
        txtPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtPwd.layer.borderWidth = 0.5
        //txtPwd.secureTextEntry = true
        txtPwd.leftView = UIView(frame:CGRect(x:0, y:0, width:44, height:44))
        txtPwd.leftViewMode = UITextFieldViewMode.always
        txtPwd.isSecureTextEntry = true //密码栏遮挡
        
        //密码输入框左侧图标
        let imgPwd =  UIImageView(frame:CGRect(x:11, y:11, width:22, height:22))
        imgPwd.image = UIImage(named:"mima")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
        
        //密码错误提示框
        alert = UIAlertController(title: "提示", message: "用户名或密码错误，请重新输入", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        
        //猫头鹰左手(圆形的)
        let rectLeftHandGone = CGRect(x:mainSize.width / 2 - 100,
                                      y:vLogin.frame.origin.y - 22, width:40, height:40)
        imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgLeftHandGone)
        
        //猫头鹰右手(圆形的)
        let rectRightHandGone = CGRect(x:mainSize.width / 2 + 62,
                                       y:vLogin.frame.origin.y - 22, width:40, height:40)
        imgRightHandGone = UIImageView(frame:rectRightHandGone)
        imgRightHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgRightHandGone)
        
        
    }
    
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: -125)
            self.view.layoutIfNeeded()
        })
        
        //如果当前是用户名输入
        if textField.isEqual(txtUser){
            if (showType != LoginShowType.PASS)
            {
                showType = LoginShowType.USER
                return
            }
            showType = LoginShowType.USER
            
            //播放不遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRect(
                    x:self.imgLeftHand.frame.origin.x - self.offsetLeftHand,
                    y:self.imgLeftHand.frame.origin.y + 30,
                    width:self.imgLeftHand.frame.size.width, height:self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x:self.imgRightHand.frame.origin.x + 48,
                    y:self.imgRightHand.frame.origin.y + 30,
                    width:self.imgRightHand.frame.size.width, height:self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x:self.imgLeftHandGone.frame.origin.x - 70,
                    y:self.imgLeftHandGone.frame.origin.y, width:40, height:40)
                self.imgRightHandGone.frame = CGRect(
                    x:self.imgRightHandGone.frame.origin.x + 30,
                    y:self.imgRightHandGone.frame.origin.y, width:40, height:40)
            })
        }
            //如果当前是密码名输入
        else if textField.isEqual(txtPwd){
            if (showType == LoginShowType.PASS)
            {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.PASS
            
            //播放遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRect(
                    x:self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
                    y:self.imgLeftHand.frame.origin.y - 30,
                    width:self.imgLeftHand.frame.size.width, height:self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x:self.imgRightHand.frame.origin.x - 48,
                    y:self.imgRightHand.frame.origin.y - 30,
                    width:self.imgRightHand.frame.size.width, height:self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x:self.imgLeftHandGone.frame.origin.x + 70,
                    y:self.imgLeftHandGone.frame.origin.y, width:0, height:0)
                self.imgRightHandGone.frame = CGRect(
                    x:self.imgRightHandGone.frame.origin.x - 30,
                    y:self.imgRightHandGone.frame.origin.y, width:0, height:0)
            })
        }
        
    }
    
    //输入框返回时操作
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        let tag = textField.tag
        switch tag {
        case 100:
            self.txtPwd.becomeFirstResponder()
        case 101:
            loginConfrim()
        default:
            print(textField.text!)
        }
        return true
    }
    
    
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
    
    //登录按钮点击
    @objc func loginConfrim(){
        //收起键盘
        self.view.endEditing(true)
        
        LCUser.logIn(username: txtUser.text!, password: txtPwd.text!) { result in
            switch result {
            case .success(let user):
                print("Login succeed")
                //成功则跳转到TabBar处
                let first = self.storyboard
                let secondView:UIViewController = first?.instantiateViewController(withIdentifier: "TarBar") as! UIViewController
                self.present(secondView, animated: true, completion: nil)
                
                break
            case .failure(let error):
                self.present(self.alert, animated: true, completion: nil)//登录失败弹出提示框
                print(error)
            }
        }
        
        //视图约束恢复初始设置
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        })
    }
    
    //注册按钮
    @objc func registerbtm(){
        //收起键盘
        self.view.endEditing(true)
        let first = self.storyboard
        let secondView:UIViewController = first?.instantiateViewController(withIdentifier: "ZhuceView") as! UIViewController
        self.present(secondView, animated: true, completion: nil)
    }
    
    @IBAction func back(segue: UIStoryboardSegue) {
        print("closed")
    }
    
    //左手离脑袋的距离
    var offsetLeftHand:CGFloat = 60
    
    //左手图片,右手图片(遮眼睛的)
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    
    //左手图片,右手图片(圆形的)
    var imgLeftHandGone:UIImageView!
    var imgRightHandGone:UIImageView!
    
    //登录框状态
    var showType:LoginShowType = LoginShowType.NONE
    
    enum LoginShowType {
        case NONE
        case USER
        case PASS
    }
}

/*//用户密码输入框
 
 //左手离脑袋的距离
 var offsetLeftHand:CGFloat = 60
 
 //左手图片,右手图片(遮眼睛的)
 var imgLeftHand:UIImageView!
 var imgRightHand:UIImageView!
 
 //左手图片,右手图片(圆形的)
 var imgLeftHandGone:UIImageView!
 var imgRightHandGone:UIImageView!
 
 //登录框状态
 var showType:LoginShowType = LoginShowType.NONE
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 //获取屏幕尺寸
 let mainSize = UIScreen.main.bounds.size
 
 //猫头鹰头部
 self.imgLogin = UIImageView(frame: CGRect(x: mainSize.width/2-211/2, y: 100, width: 211, height: 109))
 //UIImageView(frame:CGRectMake(, 100, 211, 109))
 imgLogin.image = UIImage(named:"owl-login")
 imgLogin.layer.masksToBounds = true
 self.view.addSubview(imgLogin)
 
 
 //猫头鹰左手(遮眼睛的)
 let rectLeftHand = CGRect(x:61 - offsetLeftHand, y:90, width:40, height:65)
 imgLeftHand = UIImageView(frame:rectLeftHand)
 imgLeftHand.image = UIImage(named:"owl-login-arm-left")
 imgLogin.addSubview(imgLeftHand)
 
 //猫头鹰右手(遮眼睛的)
 let rectRightHand = CGRect(x:imgLogin.frame.size.width / 2 + 60, y:90, width:40, height:65)
 imgRightHand = UIImageView(frame:rectRightHand)
 imgRightHand.image = UIImage(named:"owl-login-arm-right")
 imgLogin.addSubview(imgRightHand)
 
 //登录框背景
 let vLogin =  UIView(frame:CGRect(x:15, y:200, width:mainSize.width - 30, height:160))
 vLogin.layer.borderWidth = 0.5
 vLogin.layer.borderColor = UIColor.lightGray.cgColor
 vLogin.backgroundColor = UIColor.white
 self.view.addSubview(vLogin)
 
 //用户名框
 txtUser = UITextField(frame:CGRect(x:30, y:30, width:vLogin.frame.size.width - 60, height:44))
 txtUser.delegate = self
 txtUser.layer.cornerRadius = 5
 txtUser.layer.borderColor = UIColor.lightGray.cgColor
 txtUser.layer.borderWidth = 0.5
 txtUser.leftView = UIView(frame:CGRect(x:0, y:0, width:44, height:44))
 txtUser.leftViewMode = UITextFieldViewMode.always
 
 let imgUser =  UIImageView(frame:CGRect(x:11, y:11, width:22, height:22))
 imgUser.image = UIImage(named:"icon_zhanghao")
 txtUser.leftView!.addSubview(imgUser)
 vLogin.addSubview(txtUser)
 
 //密码输入框
 txtPwd = UITextField(frame:CGRect(x:30, y:90, width:vLogin.frame.size.width - 60, height:44))
 txtPwd.delegate = self
 txtPwd.layer.cornerRadius = 5
 txtPwd.layer.borderColor = UIColor.lightGray.cgColor
 txtPwd.layer.borderWidth = 0.5
 //txtPwd.secureTextEntry = true
 txtPwd.leftView = UIView(frame:CGRect(x:0, y:0, width:44, height:44))
 txtPwd.leftViewMode = UITextFieldViewMode.always
 
 //密码输入框左侧图标
 let imgPwd =  UIImageView(frame:CGRect(x:11, y:11, width:22, height:22))
 imgPwd.image = UIImage(named:"mima")
 txtPwd.leftView!.addSubview(imgPwd)
 vLogin.addSubview(txtPwd)
 
 
 //猫头鹰左手(圆形的)
 let rectLeftHandGone = CGRect(x:mainSize.width / 2 - 100,
 y:vLogin.frame.origin.y - 22, width:40, height:40)
 imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
 imgLeftHandGone.image = UIImage(named:"icon_hand")
 self.view.addSubview(imgLeftHandGone)
 
 //猫头鹰右手(圆形的)
 let rectRightHandGone = CGRect(x:mainSize.width / 2 + 62,
 y:vLogin.frame.origin.y - 22, width:40, height:40)
 imgRightHandGone = UIImageView(frame:rectRightHandGone)
 imgRightHandGone.image = UIImage(named:"icon_hand")
 self.view.addSubview(imgRightHandGone)
 }
 
 //输入框获取焦点开始编辑
 func textFieldDidBeginEditing(textField:UITextField)
 {
 //如果当前是用户名输入
 if textField.isEqual(txtUser){
 if (showType != LoginShowType.PASS)
 {
 showType = LoginShowType.USER
 return
 }
 showType = LoginShowType.USER
 
 //播放不遮眼动画
 UIView.animate(withDuration: 0.5, animations: { () -> Void in
 self.imgLeftHand.frame = CGRect(
 x:self.imgLeftHand.frame.origin.x - self.offsetLeftHand,
 y:self.imgLeftHand.frame.origin.y + 30,
 width:self.imgLeftHand.frame.size.width, height:self.imgLeftHand.frame.size.height)
 self.imgRightHand.frame = CGRect(
 x:self.imgRightHand.frame.origin.x + 48,
 y:self.imgRightHand.frame.origin.y + 30,
 width:self.imgRightHand.frame.size.width, height:self.imgRightHand.frame.size.height)
 self.imgLeftHandGone.frame = CGRect(
 x:self.imgLeftHandGone.frame.origin.x - 70,
 y:self.imgLeftHandGone.frame.origin.y, width:40, height:40)
 self.imgRightHandGone.frame = CGRect(
 x:self.imgRightHandGone.frame.origin.x + 30,
 y:self.imgRightHandGone.frame.origin.y, width:40, height:40)
 })
 }
 //如果当前是密码名输入
 else if textField.isEqual(txtPwd){
 if (showType == LoginShowType.PASS)
 {
 showType = LoginShowType.PASS
 return
 }
 showType = LoginShowType.PASS
 
 //播放遮眼动画
 UIView.animate(withDuration: 0.5, animations: { () -> Void in
 self.imgLeftHand.frame = CGRect(
 x:self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
 y:self.imgLeftHand.frame.origin.y - 30,
 width:self.imgLeftHand.frame.size.width, height:self.imgLeftHand.frame.size.height)
 self.imgRightHand.frame = CGRect(
 x:self.imgRightHand.frame.origin.x - 48,
 y:self.imgRightHand.frame.origin.y - 30,
 width:self.imgRightHand.frame.size.width, height:self.imgRightHand.frame.size.height)
 self.imgLeftHandGone.frame = CGRect(
 x:self.imgLeftHandGone.frame.origin.x + 70,
 y:self.imgLeftHandGone.frame.origin.y, width:0, height:0)
 self.imgRightHandGone.frame = CGRect(
 x:self.imgRightHandGone.frame.origin.x - 30,
 y:self.imgRightHandGone.frame.origin.y, width:0, height:0)
 })
 }
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 }
 }
 
 //登录框状态枚举
 enum LoginShowType {
 case NONE
 case USER
 case PASS
 }*/





























