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

    var Date = UIDatePicker()
    var SetTime = UITextField()
    @IBAction func Sign(_ sender: Any) {
    }
    
    @IBAction func ConfirmMentruationDate(_ sender: Any) {
        //SetTime.isEnabled = false //使文本框无法编辑
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // 选择框样式
        SetTime.frame = CGRect(x: self.view.frame.origin.x + 65, y: self.view.frame.origin.y + 100, width: self.view.frame.width * 2 / 3, height: 40)
        SetTime.layer.cornerRadius = 5.0
        SetTime.layer.borderWidth = 0.7
        SetTime.layer.borderColor = UIColor.darkGray.cgColor
        SetTime.textAlignment = .center
        SetTime.placeholder = "还记得上一次来姨妈吗？"
        SetTime.endEditing(false)
        
        // 日期选择器属性及样式
        Date.locale = NSLocale(localeIdentifier: "zh_cn") as Locale
        Date.timeZone = NSTimeZone.system
        Date.datePickerMode = UIDatePickerMode.date
        Date.addTarget(self, action: #selector(getDate), for: UIControlEvents.valueChanged)
        Date.layer.backgroundColor = UIColor.white.cgColor
        Date.layer.masksToBounds = true
        
        // 重点的一句
        SetTime.inputView = Date
        
        self.view.addSubview(SetTime)
        //启动界面延时
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        Thread.sleep(forTimeInterval: 2)
    }
    
    @objc func getDate(Date: UIDatePicker) {
        let formatter = DateFormatter()
        let date = Date.date
        formatter.dateFormat = "YYYY年 MM月 dd日"
        let dateStr = formatter.string(from: date)
        self.SetTime.text = dateStr
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func back(segue: UIStoryboardSegue) {
        print("closed")
    }
    

}

