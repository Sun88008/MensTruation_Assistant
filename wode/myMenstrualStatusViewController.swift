//
//  myMenstrualStatusViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/28.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import SnapKit
import LeanCloud
import AVOSCloud
import Alamofire

class myMenstrualStatusViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var finishbtm: UIButton!
    @IBOutlet weak var mentrualCycle: UIView!
    @IBOutlet weak var menturalTime: UIView!
    
    @IBOutlet weak var SetTime1: UITextField!
    @IBOutlet weak var SetTime2: UITextField!
    
    var pickView1 = UIPickerView()
    var pickView2 = UIPickerView()
    var pickerDateToolbar1 = UIToolbar()
    var pickerDateToolbar2 = UIToolbar()
    let Date1 = NSArray(objects:"15天","16天","17天","18天","19天","20天","21天","22天","23天","24天","25天","26天","27天","28天","29天","30天","31天","32天","33天","34天","35天","36天","37天","38天","39天","40天","41天","42天","43天","44天","45天","46天","47天","48天","49天","50天")
    let Date2 = NSArray(objects:"1天","2天","3天","4天","5天","6天","7天","8天","9天","10天","11天","12天","13天","14天","15天")
    var num1 = 0
    var num2 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        self.finishbtm.layer.cornerRadius = 10
        self.mentrualCycle.layer.cornerRadius = 10
        self.menturalTime.layer.cornerRadius = 10
        
        pickView1.delegate = self
        pickView1.dataSource = self
        pickView1.layer.backgroundColor = UIColor.white.cgColor
        pickView1.layer.masksToBounds = true
        pickView1.showsSelectionIndicator = true
        
        pickView2.delegate = self
        pickView2.dataSource = self
        pickView2.layer.backgroundColor = UIColor.white.cgColor
        pickView2.layer.masksToBounds = true
        pickView2.showsSelectionIndicator = true
        
        SetTime1.tintColor = UIColor.lightGray
        SetTime2.tintColor = UIColor.lightGray
        
        pickerDateToolbar1 = UIToolbar.init(frame: CGRect(x: 0,y: 0,width: 320, height: 44))
        pickerDateToolbar1.barStyle = UIBarStyle.blackOpaque
        pickerDateToolbar1.sizeToFit()
        
        pickerDateToolbar2 = UIToolbar.init(frame: CGRect(x: 0,y: 0,width: 320, height: 44))
        pickerDateToolbar2.barStyle = UIBarStyle.blackOpaque
        pickerDateToolbar2.sizeToFit()
        
        let barItems1 = NSMutableArray.init()
        let barItems2 = NSMutableArray.init()
        
        let cancelBtn1 = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarCancelClick))
        barItems1.add(cancelBtn1)
        let cancelBtn2 = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarCancelClick))
        barItems2.add(cancelBtn2)
        
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        barItems1.add(flexSpace)
        barItems2.add(flexSpace)
        
        let doneBtn1 = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarDoneClick1))
        barItems1.add(doneBtn1)
        
        let doneBtn2 = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarDoneClick2))
        barItems2.add(doneBtn2)

        pickerDateToolbar1.setItems(barItems1 as? [UIBarButtonItem], animated: true)
        pickerDateToolbar1.tintColor = UIColor.black
        pickerDateToolbar1.barTintColor = UIColor.white
        
        pickerDateToolbar2.setItems(barItems2 as? [UIBarButtonItem], animated: true)
        pickerDateToolbar2.tintColor = UIColor.black
        pickerDateToolbar2.barTintColor = UIColor.white
        
        // 重点的一句
        SetTime1.inputView = pickView1
        self.SetTime1.inputAccessoryView = pickerDateToolbar1
        SetTime2.inputView = pickView2
        self.SetTime2.inputAccessoryView = pickerDateToolbar2
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView == self.pickView1){
            return Date1.count
        }else{
            return Date2.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == self.pickView1){
            return Date1.object(at: row) as? String
        }else{
            return Date2.object(at: row) as? String
        }
    }
    
    @objc func toolBarCancelClick(){
        self.view.endEditing(true)
    }
    
    @objc func toolBarDoneClick1(){
        let row = pickView1.selectedRow(inComponent: 0) //获取当前行
        let value = Date1.object(at: row) as! String //获取行内数据
        self.SetTime1.text = value
        
        let scanner1 = Scanner(string: SetTime1.text!)
        scanner1.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
        scanner1.scanInt(&num1)
        print(num1)
        
        self.view.endEditing(true)
    }
    @objc func toolBarDoneClick2(){
        let row = pickView2.selectedRow(inComponent: 0) //获取当前行
        let value = Date2.object(at: row) as! String //获取行内数据
        self.SetTime2.text = value
        
        let scanner2 = Scanner(string: SetTime2.text!)
        scanner2.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
        scanner2.scanInt(&num2)
        print(num2)
        
        self.view.endEditing(true)
    }
    
    @IBAction func finishSetMenstrual(_ sender: UIButton) {
        let currentUser = LCUser.current!//初始化当前用户信息
        let ID = currentUser.objectId?.stringValue//获取objectId
        let query = LCQuery(className: "_User")//选择所在类
        let _ = query.get(ID!) { (result) in
            switch result {
            case .success(object: let object):
                
                // get value by string key
                var getCycle = object.get("Cycle")?.arrayValue
                let cycle = [self.num1]
                var getDays = object.get("Days")?.arrayValue
                let days = [self.num2]
                
                print("get succeed!")
                
                if(getCycle == nil){
                    // 修改当前用户的周期
                    currentUser.set("Cycle", value: cycle)
                    
                    currentUser.save { result in
                        switch result {
                        case .success:
                            print("cycle setted!")
                            break
                        case .failure(let error):
                            print(error)
                        }
                    }
                }else{
                    getCycle?.append(self.num1)
                    currentUser.set("Cycle", value: getCycle)
                    currentUser.save { result in
                        switch result {
                        case .success:
                            print("cycle update setted!")
                            break
                        case .failure(let error):
                            print(error)
                        }
                    }

                }
                
                if(getDays == nil){
                    // 修改当前用户的周期
                    currentUser.set("Days", value: days)
                    
                    currentUser.save { result in
                        switch result {
                        case .success:
                            print("days setted!")
                            break
                        case .failure(let error):
                            print(error)
                        }
                    }
                }else{
                    getDays?.append(self.num2)
                    currentUser.set("Days", value: getDays)
                    currentUser.save { result in
                        switch result {
                        case .success:
                            print("days update setted!")
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
        
        
        // 修改当前用户的周期
        currentUser.set("Days", value: num2)
        
        currentUser.save { result in
            switch result {
            case .success:
                print("Days setted!")
                break
            case .failure(let error):
                print(error)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
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
