//
//  ViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/3.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
import SnapKit

class ViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var text : String?
    
    
    @IBAction func Sign(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let currentUser = LCUser.current {
            let email = currentUser.email // 当前用户的邮箱
            let username = currentUser.username // 当前用户名
            
            // 请注意，以下代码无法获取密码
            let password = currentUser.password
        }
        let randomUser = LCUser()
        
        randomUser.username = LCString("Tom")
        randomUser.password = LCString("cat!@#123")
        
        randomUser.signUp()
        //视图背景色
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,
                                            alpha: 1)
        
        //启动界面延时
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        Thread.sleep(forTimeInterval: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func back(segue: UIStoryboardSegue) {
        print("closed")
    }
    

}

