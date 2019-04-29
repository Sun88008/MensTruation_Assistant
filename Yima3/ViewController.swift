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


class ViewController: UIViewController, UIGestureRecognizerDelegate, UIWebViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tipsView: UIView!
    @IBOutlet weak var titleView: DNSPageTitleView!
    @IBOutlet weak var contentView: DNSPageContentView!
    //图表数据
    var text : String?
    var dateStr: String = ""
    var getCycle: [Double] = []
    var getDays: [Double] = []
    var getMenstrualArray: [String] = []
    var showCycle: String = ""
    var showDays: String = ""
    var cyc: Int = 0
    var day: Int = 0
    let controller1 = UIViewController()
    let controller2 = UIViewController()
    let controller3 = UIViewController()
    open var chartModel: AAChartModel?
    open var aaChartView: AAChartView?
    //获得时间
    let locolDate = NSDate()
    let txtView = UIView()
    let txtlocolDate = UILabel()
    //绘图
    let centerX = 168.0
    let centerY = 155.0
    let R = 110.0
    var menstrualDay = String()
    var cycle = 30.0
    var yimaqi = Double()
    var imageX = Double()
    var imageY = Double()
    var yImage = [UIImageView]()
    let nowDayView = UIView()
    var nowDay = UILabel()
    
    //第三个图
    let avCycleLable = UILabel()
    let avDaysLable = UILabel()
    let excTable = UITableView()
    let excTableCell = UITableViewCell()
    
    var num1 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //视图背景色
        self.view.backgroundColor = UIColor.white
        tipsView.layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
        
        //加阴影
        contentView.layer.shadowColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1).cgColor
        //shadowColor阴影颜色
        contentView.layer.shadowOffset = CGSize.init(width: 0, height: 3)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        contentView.layer.shadowOpacity = 0.8//阴影透明度，默认0

        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.titleViewBackgroundColor = UIColor.red
        style.isShowCoverView = true
        
        // 设置标题内容
        let titles = ["状态", "图表", "数据"]
        
        // 设置默认的起始位置
        let startIndex = 2
        
        // 对titleView进行设置
        titleView.titles = titles
        titleView.style = style
        titleView.currentIndex = startIndex
        
        // 最后要调用setupUI方法
        titleView.setupUI()
        
        
        // 创建每一页对应的controller
        controller1.view.backgroundColor = UIColor.white
        controller1.view.layer.cornerRadius = 15
        self.setUpFirstView()
        addChildViewController(controller1)
        
        controller2.view.backgroundColor = UIColor.white
        controller2.view.layer.cornerRadius = 15
        self.setUpAAChartView()
        addChildViewController(controller2)
        
        controller3.view.backgroundColor = UIColor.white
        controller3.view.layer.cornerRadius = 15
        self.setUpThirdView()
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
    
    func setUpFirstView(){
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "MM月dd日"
        let strNowTime = timeFormatter.string(from: locolDate as Date) as String
        txtView.frame = CGRect(x:130,y:10,width:90,height:20)
        txtView.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        txtView.layer.cornerRadius = 10
        txtlocolDate.text = strNowTime
        txtlocolDate.textColor = UIColor.white
        txtlocolDate.endEditing(true)
        txtlocolDate.frame = CGRect(x:8,y:5,width:80,height:10)
        txtView.addSubview(txtlocolDate)
        
        //获取信息
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
                print("fir:\(String(describing: getMenstrual))")
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
                self.cycle = self.getCycle[self.getCycle.endIndex-1]
                self.yimaqi = self.getDays[self.getDays.endIndex-1]
                self.menstrualDay = self.getMenstrualArray[self.getMenstrualArray.endIndex-1]
                var numMenstrualDay = self.menstrualDay.replacingOccurrences(of: "月", with: "")
                numMenstrualDay = numMenstrualDay.replacingOccurrences(of: "日", with: "")
                numMenstrualDay = numMenstrualDay.replacingOccurrences(of: " ", with: "")
                print(numMenstrualDay)
                let date = self.string2Date(numMenstrualDay)
                let date1 = date + self.yimaqi*24*60*60
                let strdate1 = self.date2String(date1, dateFormat: "MM月 dd日")
                let date2 = date + self.cycle*24*60*60 - 14*24*60*60
                let strdate2 = self.date2String(date2, dateFormat: "MM月 dd日")
                let date3 = date2 + 5*24*60*60
                let strdate3 = self.date2String(date3, dateFormat: "MM月 dd日")
                //比较当前日期和各个阶段日期
                if(self.locolDate.compare(date) == .orderedDescending && self.locolDate.compare(date1) == .orderedAscending){
                    self.nowDayView.frame = CGRect(x:self.centerX-30,y:self.centerY-5,width:80,height:35)
                    self.nowDayView.layer.cornerRadius = 10
                    self.nowDayView.backgroundColor = UIColor(red: 251/255, green: 109/255, blue: 157/255,alpha: 1)//粉
                    self.nowDay.text = "姨妈期"
                    self.nowDay.font = UIFont.italicSystemFont(ofSize: 20)
                    self.nowDay.frame = CGRect(x:9,y:-8,width:150,height:50)
                    self.nowDay.textColor = UIColor.white
                    self.nowDayView.addSubview(self.nowDay)
                    self.controller1.view.addSubview(self.nowDayView)
                }else if(self.locolDate.compare(date3-10*24*60*60) == .orderedDescending && self.locolDate.compare(date3) == .orderedAscending){
                    self.nowDayView.frame = CGRect(x:self.centerX-30,y:self.centerY-5,width:80,height:35)
                    self.nowDayView.layer.cornerRadius = 10
                    self.nowDayView.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 48/255,alpha: 1)//红
                    self.nowDay.text = "危险期"
                    self.nowDay.font = UIFont.italicSystemFont(ofSize: 20)
                    self.nowDay.frame = CGRect(x:9,y:-8,width:150,height:50)
                    self.nowDay.textColor = UIColor.white
                    self.nowDayView.addSubview(self.nowDay)
                    self.controller1.view.addSubview(self.nowDayView)
                }else{
                    self.nowDayView.frame = CGRect(x:self.centerX-30,y:self.centerY-5,width:80,height:35)
                    self.nowDayView.layer.cornerRadius = 10
                    self.nowDayView.backgroundColor = UIColor(red: 113/255, green: 220/255, blue: 112/255,alpha: 1)//绿
                    self.nowDay.text = "安全期"
                    self.nowDay.font = UIFont.italicSystemFont(ofSize: 20)
                    self.nowDay.frame = CGRect(x:9,y:-8,width:150,height:50)
                    self.nowDay.textColor = UIColor.white
                    self.nowDayView.addSubview(self.nowDay)
                    self.controller1.view.addSubview(self.nowDayView)
                }
                
                for i in 0...Int(self.cycle-1){
                    self.getXY1(i: Double(i))
                    let yyImage = UIImageView()
                    if(i>=0 && i<Int(self.yimaqi)){
                        if(i==0){
                            let xiangshang = UIImageView.init(image: #imageLiteral(resourceName: "向上箭头"))
                            xiangshang.frame = CGRect(x:self.imageX,y:self.imageY+14,width:15,height:13)
                            self.controller1.view.addSubview(xiangshang)
                            let firstDay = UILabel()
                            firstDay.text = self.menstrualDay
                            firstDay.textColor = UIColor(red: 251/255, green: 109/255, blue: 157/255,alpha: 1)//粉
                            firstDay.frame = CGRect(x:self.imageX-3,y:self.imageY+25,width:50,height:8)
                            firstDay.adjustsFontSizeToFitWidth = true
                            self.controller1.view.addSubview(firstDay)
                        }
                        yyImage.image = #imageLiteral(resourceName: "姨妈期")
                    }else if(i>Int(self.cycle-14)-6 && i<Int(self.cycle-14)+5 && i != Int(self.cycle-14)){
                        yyImage.image = #imageLiteral(resourceName: "排卵期")
                    }else if(i == Int(self.cycle-14)){
                        let xiangshang = UIImageView.init(image: #imageLiteral(resourceName: "向下箭头"))
                        xiangshang.frame = CGRect(x:self.imageX+5,y:self.imageY-9,width:8,height:8)
                        self.controller1.view.addSubview(xiangshang)
                        let firstDay = UILabel()
                        firstDay.text = strdate2
                        firstDay.textColor = UIColor(red: 251/255, green: 109/255, blue: 157/255,alpha: 1)//粉
                        firstDay.frame = CGRect(x:self.imageX-3,y:self.imageY-22,width:50,height:8)
                        firstDay.adjustsFontSizeToFitWidth = true
                        self.controller1.view.addSubview(firstDay)
                        yyImage.image = #imageLiteral(resourceName: "排卵日")
                    }else{
                        if(i==Int(self.yimaqi)){
                            let xiangyou = UIImageView.init(image: #imageLiteral(resourceName: "向右箭头"))
                            xiangyou.frame = CGRect(x:self.imageX-10,y:self.imageY+5,width:10,height:8)
                            self.controller1.view.addSubview(xiangyou)
                            let firstDay = UILabel()
                            firstDay.text = strdate1
                            firstDay.textColor = UIColor(red: 113/255, green: 220/255, blue: 112/255,alpha: 1)//绿
                            firstDay.frame = CGRect(x:self.imageX-60,y:self.imageY+3,width:50,height:8)
                            firstDay.adjustsFontSizeToFitWidth = true
                            self.controller1.view.addSubview(firstDay)
                        }else if(i == Int(self.cycle-9)){
                            let xiangyou = UIImageView.init(image: #imageLiteral(resourceName: "向左箭头"))
                            xiangyou.frame = CGRect(x:self.imageX+15,y:self.imageY+5,width:10,height:8)
                            self.controller1.view.addSubview(xiangyou)
                            let firstDay = UILabel()
                            firstDay.text = strdate3
                            firstDay.textColor = UIColor(red: 113/255, green: 220/255, blue: 112/255,alpha: 1)//绿
                            firstDay.frame = CGRect(x:self.imageX+28,y:self.imageY+3,width:50,height:8)
                            firstDay.adjustsFontSizeToFitWidth = true
                            self.controller1.view.addSubview(firstDay)
                        }
                        yyImage.image = #imageLiteral(resourceName: "安全期")
                    }
                    yyImage.frame = CGRect(x:self.imageX,y:self.imageY,width:15,height:15)
                    self.yImage.append(yyImage)
                    self.controller1.view.addSubview(self.yImage[i])
                }
                
                print(self.menstrualDay)
                print(self.yimaqi)
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
        
 
        let shiyitu = UIImageView.init(image: #imageLiteral(resourceName: "示意图"))
        shiyitu.frame = CGRect(x:50,y:290,width:250,height:30)
        controller1.view.addSubview(shiyitu)
        
        controller1.view.addSubview(txtView)
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
                print("fir:\(String(describing: getMenstrual))")
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
    
    func setUpThirdView(){
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
                print("fir:\(String(describing: getMenstrual))")
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
                
                var avCycle = Int()
                var avDays = Int()
                for itemCycle in self.getCycle{
                    avCycle += Int(itemCycle)/self.getCycle.count
                }
                for itemCycle in self.getDays{
                    avDays += Int(itemCycle)/self.getDays.count
                }
                self.avCycleLable.text = "平均周期："+String(avCycle)
                self.avDaysLable.text = "平均天数："+String(avDays)
                self.avCycleLable.frame = CGRect(x:50,y:20,width:150,height:30)
                self.avDaysLable.frame = CGRect(x:190,y:20,width:150,height:30)
                self.avCycleLable.font = UIFont.systemFont(ofSize: 15)
                self.avDaysLable.font = UIFont.systemFont(ofSize: 15)
                self.controller3.view.addSubview(self.avCycleLable)
                self.controller3.view.addSubview(self.avDaysLable)
                
                
                self.excTable.frame = CGRect(x:5,y:70,width:320,height:180)
                self.excTableCell.frame = CGRect(x:0,y:0,width:320,height:30)
                self.controller3.view.addSubview(self.excTable)
//                self.excTable.addSubview(self.excTableCell)
//                self.excTable.dataSource = self
//                self.excTable.delegate = self

            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return part1.count//数组的长度
        return 6
    }
    
    //添加一个代理方法，用来初始化或复用表格视图中的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "excTableCell")
        return cell!//返回设置好的单元格对象
//        if(indexPath.row == 0){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "excTableCell", for: indexPath)
//            cell.textLabel?.text = "头像"
//            //初始化imageview
//            let itemSize = CGSize(width:40,height:40)
//            UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
//            let imageRect = CGRect(x:0,y:0,width:itemSize.width,height:itemSize.height)
//            cell.imageView?.image?.draw(in: imageRect)
//            cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsGetCurrentContext()
//            //设置圆角
//            let cellImageLayer = cell.imageView?.layer
//            cellImageLayer?.cornerRadius = 23.0
//            cellImageLayer?.masksToBounds = true
//            cell.imageView?.image = #imageLiteral(resourceName: "touxiang")
//            return cell
//        }else if(indexPath.row == 1){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "excTableCell", for: indexPath)
//            cell.textLabel?.text = "昵称"
//            return cell
//        }else if(indexPath.row == 2){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "excTableCell", for: indexPath)
//            cell.textLabel?.text = "性别"
//            return cell
//        }else if(indexPath.row == 3){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "excTableCell", for: indexPath)
//            cell.textLabel?.text = "年龄"
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "excTableCell", for: indexPath)
//            cell.textLabel?.text = "手机号码"
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)//点击cell后消除选中效果
    }
    
    //获得下一个小圆圈的xy
    func getXY1(i:Double){
        imageX = centerX + sin(((360.0/cycle)*Double.pi/180)*i)*R
        imageY = centerY - cos(((360.0/cycle)*Double.pi/180)*i)*R
    }
    //日期转字符串
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    //字符串转日期
    func string2Date(_ string:String, dateFormat:String = "MMdd") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpAAChartView()
        setUpFirstView()
        setUpThirdView()
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

