//
//  SetMenstruationViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/4.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import SnapKit
import LeanCloud
import AVOSCloud
import Alamofire

class SetMenstruationViewController: UIViewController, UIActionSheetDelegate {

    var Date = UIDatePicker()
    var SetTime = UITextField()
    var day:String = ""
    @IBAction func ConfirmValueAndPass(_ sender: Any) {
        //ViewController.text = MentruationTime
        if(self.SetTime.text == ""){
            
        }else{
            let date = Date.date
            let currentUser = LCUser.current!
            
            // 修改当前用户的周期
            let ID = currentUser.objectId?.stringValue//获取objectId
            let query = LCQuery(className: "_User")//选择所在类
            let _ = query.get(ID!) { (result) in
                switch result {
                case .success(object: let object):
                    
                    // get value by string key
                    var getMenstrual_Day = object.get("Menstrual_Day")?.arrayValue
    //                let Menstrual_Day = [date as! String]
                    print("get succeed!")
                    
                    if(getMenstrual_Day == nil){
                        // 修改当前用户的周期
                        let Menstrual_Day = [self.day]
                        currentUser.set("Menstrual_Day", value: Menstrual_Day)
                        
                        currentUser.save { result in
                            switch result {
                            case .success:
                                print("menstrual_Day setted!")
                                break
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }else{
                        getMenstrual_Day?.append(self.day)
                        currentUser.set("Menstrual_Day", value: getMenstrual_Day)
                        currentUser.save { result in
                            switch result {
                            case .success:
                                print("menstrual_Day update setted!")
                                break
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                    }
                case .failure(error: let error):
                    // handle error
                    print(error)
                    break
                }
            }
        
        
//        // 修改当前用户的周期
//        currentUser.set("Menstrual_Day", value: date)
//
//        currentUser.save { result in
//            switch result {
//            case .success:
//                print("Menstrual_Day setted!")
//                break
//            case .failure(let error):
//                print(error)
//            }
//        }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //视图背景色
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,
                                            alpha: 1)
        
        // 选择框样式
        SetTime.frame = CGRect(x: self.view.frame.origin.x + 65, y: self.view.frame.origin.y + 100, width: self.view.frame.width * 2 / 3, height: 40)
        SetTime.layer.cornerRadius = 5.0
        SetTime.layer.borderWidth = 0.7
        SetTime.layer.backgroundColor = UIColor.white.cgColor
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

        
        // Do any additional setup after loading the view.
        /*let datePicker = UIDatePicker()
        datePicker.center = CGPoint(x: 200, y: 250)
        datePicker.tag = 1
        self.view.addSubview(datePicker)
        let rect = CGRect(x: 70, y: 360, width: 280, height: 44)
        let button = UIButton(type: UIButtonType.roundedRect)
        button.frame = rect
        button.backgroundColor = UIColor.lightGray
        button.setTitle("最近一次姨妈日期", for: UIControlState())
        button.addTarget(self, action: #selector(SetMenstruationViewController.getDate), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        */
        
    }
    
    @objc func getDate(Date: UIDatePicker) {
        let formatter = DateFormatter()
        let date = Date.date
        formatter.dateFormat = "YYYY年 MM月 dd日"
        let dateStr = formatter.string(from: date)
        self.SetTime.text = dateStr
        //按月-日储存到leancloud
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MM月 dd日"
        let dateStr2 = formatter2.string(from: date)
        self.day = dateStr2
        
        let MentruationTime = date+1*60*60*24
        
        /*let MentruationTime = Calendar(identifier: .chinese)
        let year = MentruationTime.component(.year, from: date)
        let month = MentruationTime.component(.month, from: date)
        let day = MentruationTime.component(.day, from: date)
        print("year:\(year) month:\(month) day:\(day)")*///输出年月日不正确
        
        //print(date+1*60*60*24) //对日期进行加减
    }
    
    /*@objc func getDate(){
        let datePicker = self.view.viewWithTag(1) as! UIDatePicker
        let date = datePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateAndTime = dateFormater.string(from: date)
        
        let alert = UIAlertController(title: "Information", message: dateAndTime, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }*/

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
