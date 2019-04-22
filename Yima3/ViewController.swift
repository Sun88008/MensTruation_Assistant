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
    
    @IBOutlet weak var tipsView: UIView!
    @IBOutlet weak var titleView: DNSPageTitleView!
    
    @IBOutlet weak var contentView: DNSPageContentView!
    
    var text : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //视图背景色
        self.view.backgroundColor = UIColor.white
        tipsView.layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
        
        //加阴影
        contentView.layer.shadowColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1).cgColor//shadowColor阴影颜色
        contentView.layer.shadowOffset = CGSize.init(width: 0, height: 3)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        contentView.layer.shadowOpacity = 0.8//阴影透明度，默认0

        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.titleViewBackgroundColor = UIColor.red
        style.isShowCoverView = true
        
        // 设置标题内容
        let titles = ["状态", "图表", "数据"]
        
        // 设置默认的起始位置
        let startIndex = 0
        
        // 对titleView进行设置
        titleView.titles = titles
        titleView.style = style
        titleView.currentIndex = startIndex
        
        // 最后要调用setupUI方法
        titleView.setupUI()
        
        
        // 创建每一页对应的controller
        let controller1 = UIViewController()
        controller1.view.backgroundColor = UIColor.white
        controller1.view.layer.cornerRadius = 15
        addChildViewController(controller1)
        
        let controller2 = UIViewController()
        controller2.view.backgroundColor = UIColor.black
        controller2.view.layer.cornerRadius = 15
        addChildViewController(controller2)
        
        let controller3 = UIViewController()
        controller3.view.backgroundColor = UIColor.blue
        controller3.view.layer.cornerRadius = 15
        addChildViewController(controller3)
        
        let childViewControllers: [UIViewController] = [controller1,controller2,controller3]
        
//        // 创建每一页对应的controller
//        let childViewControllers: [UIViewController] = titles.map { _ -> UIViewController in
//            let controller = UIViewController()
//            addChildViewController(controller)
//            return controller
//        }
        
        // 对contentView进行设置
        contentView.childViewControllers = childViewControllers
        contentView.currentIndex = startIndex
        contentView.style = style
        
        // 最后要调用setupUI方法
        contentView.setupUI()
        
        // 让titleView和contentView进行联系起来
        titleView.delegate = contentView
        contentView.delegate = titleView
        
        //启动界面延时
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        Thread.sleep(forTimeInterval: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

