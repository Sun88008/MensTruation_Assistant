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
    var dateStr: String = ""
    var getCycle: [Double] = []
    var getDays: [Double] = []
    var getMenstrualArray: [String] = []
    var showCycle: String = ""
    var showDays: String = ""
    var cyc: Int = 0
    var day: Int = 0
    let controller2 = UIViewController()
    open var chartModel: AAChartModel?
    open var aaChartView: AAChartView?

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
        let startIndex = 1
        
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
        
        
        controller2.view.backgroundColor = UIColor.white
        controller2.view.layer.cornerRadius = 15
        
        
                self.setUpAAChartView()

                
        
        
        addChildViewController(controller2)
        
        let controller3 = UIViewController()
        controller3.view.backgroundColor = UIColor.white
        controller3.view.layer.cornerRadius = 15
        addChildViewController(controller3)
        
        let childViewControllers: [UIViewController] = [controller1,controller2,controller3]
        
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
    
    func setUpAAChartView() {
        
        //获取横坐标
        let currentUser = LCUser.current!//初始化当前用户信息
        let ID = currentUser.objectId?.stringValue//获取objectId
        let query = LCQuery(className: "_User")//选择所在类
        
        let _ = query.get(ID!) { (result) in
            switch result {
            case .success(object: let object):
                self.showCycle = ""
                self.showDays = ""
                // get value by string key
                if(object.get("Cycle") == nil){
                    self.getCycle = []
                }else{
                    self.getCycle = object.get("Cycle")?.arrayValue as! [Double]
                    for itemCycle in self.getCycle{
                        self.cyc = Int(itemCycle)
                        self.showCycle += " \(self.cyc)天"
                    }
                }
                if(object.get("Days") == nil){
                    self.getDays = []
                }else{
                    self.getDays = object.get("Days")?.arrayValue as! [Double]
                    for itemDays in self.getDays{
                        self.day = Int(itemDays)
                        self.showDays += " \(self.day)天"
                    }
                }
                print(self.getCycle)
                print(self.getDays)
                self.getMenstrualArray = []
                let getMenstrual = object.get("Menstrual_Day")?.arrayValue
                print("fir:\(getMenstrual)")
                if(getMenstrual != nil){
                    for date in getMenstrual!{
                        if(getMenstrual?.isEmpty)!{
                            
                        }else{
                            if(self.getMenstrualArray.isEmpty){
                                self.getMenstrualArray = [date as! String]
                            }else{
                                self.getMenstrualArray.append(date as! String)
                            }
                        }
                    }

                    
                }else{
                    self.getMenstrualArray = []
                }
                print("fir:\(self.getMenstrualArray)")
                print(self.getCycle)
                print(self.getDays)
                //初始化标图
                let chartViewWidth: CGFloat  = 320
                let chartViewHeight: CGFloat = 340
                self.aaChartView = AAChartView()
                self.aaChartView?.frame = CGRect(x:10,y:0,width:chartViewWidth,height:chartViewHeight)
                // 设置 aaChartView 的内容高度(content height)
                self.aaChartView?.contentHeight = 330
                
                let subLabel = UILabel()
                subLabel.frame = CGRect(x: 20,
                                        y:0,
                                        width: 5,
                                        height: 5)
                subLabel.text = "不要将 AAChartView 作为第一个子视图添加到 ViewController 上,否则会有 bug,不信你试试注释掉我"
                self.controller2.view.addSubview(subLabel)
                
                self.controller2.view.addSubview(self.aaChartView!)
                
                self.chartModel = AAChartModel()
                    .chartType(.column)//图表类型
                    .title("月经周期：\(self.showCycle)")//图表主标题
                    .subtitle("月经期：\(self.showDays)")//图表副标题
                    .inverted(false)//是否翻转图形
                    .yAxisTitle("天数")// Y 轴标题
                    .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
                    .tooltipValueSuffix("天")//浮动提示框单位后缀
                    .categories(self.getMenstrualArray)
                    .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])//主题颜色数组
                    .series([
                        AASeriesElement()
                            .name("月经周期")
                            .data(self.getCycle)
                            .toDic()!,
                        AASeriesElement()
                            .name("月经期")
                            .data(self.getDays)
                            .toDic()!,])
                self.aaChartView?.aa_drawChartWithChartModel(self.chartModel!)
                print("get succeed!")
                
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpAAChartView()
//        self.aaChartView?.aa_refreshChartWholeContentWithChartModel(self.chartModel!)//刷新
    }
    @IBAction func back(segue: UIStoryboardSegue) {
        print("closed")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

