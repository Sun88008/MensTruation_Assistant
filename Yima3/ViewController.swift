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


class ViewController: UIViewController, UIGestureRecognizerDelegate, UIWebViewDelegate, UITextFieldDelegate{
    
//    @IBOutlet weak var zhuYeWeb: UIWebView!
//    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var tipsView: UIView!
    
    var text : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //视图背景色
        self.view.backgroundColor = UIColor.white
        tipsView.layer.cornerRadius = 15
        
//        self.myScrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:1000)
//        self.myScrollView.contentSize = CGSize(width:self.view.frame.width, height:2000)
//        
//        self.myScrollView.isUserInteractionEnabled = true
//        zhuYeWeb.delegate = self
//
//        //载入输入的请求
//        let aUrl = NSURL(string: ("https://nv.99.com.cn"))
//        let urlRequest = NSURLRequest(url: aUrl! as URL)
//        zhuYeWeb.loadRequest(urlRequest as URLRequest)
        
        //启动界面延时
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        Thread.sleep(forTimeInterval: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

