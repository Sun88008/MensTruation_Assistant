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
    let Date1 = NSArray(objects:"15天","16天","17天","18天","19天","20天","21天","22天","23天","24天","25天","26天","27天","28天","29天","30天","31天","32天","33天","34天","35天","36天","37天","38天","39天","40天","41天","42天","43天","44天","45天","46天","47天","48天","49天","50天")
    let Date2 = NSArray(objects:"1天","2天","3天","4天","5天","6天","7天","8天","9天","10天","11天","12天","13天","14天","15天")
    var btnOK = UIButton()
    
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
        // 重点的一句
        SetTime1.inputView = pickView1
        SetTime2.inputView = pickView2
        
        //let actionSheet = UIActionSheet.init(title: "", delegate: self as! UIActionSheetDelegate, cancelButtonTitle: nil, destructiveButtonTitle: nil)
        
        let pickerDateToolbar = UIToolbar.init(frame: CGRect(x: 0,y: 0,width: 320, height: 44))
        pickerDateToolbar.barStyle = UIBarStyle.blackOpaque
        pickerDateToolbar.sizeToFit()
        pickerDateToolbar.barTintColor = UIColor.white
        
        let barItems = NSMutableArray.init()
        
        let cancelBtn = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarCancelClick))
        barItems.add(cancelBtn)
        
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
        barItems.add(flexSpace)
        
        let doneBtn = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.done, target: self, action: #selector(toolBarDoneClick))
        barItems.add(doneBtn)
        
        pickerDateToolbar.setItems(barItems as! [UIBarButtonItem], animated: true)
        pickView1.addSubview(pickerDateToolbar)
        
//        btnOK.frame = CGRect(x:344, y:5, width:40, height:30)
//        btnOK.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
//        btnOK.setTitle("确定", for: UIControlState.normal)
//        btnOK.setTitleColor(UIColor.blue, for: UIControlState.normal)
//        btnOK.addTarget(self, action: #selector(pickerViewBtnOk), for: UIControlEvents.touchUpInside)
//        self.view.addSubview(btnOK)
        
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
            return Date1.object(at: row) as! String
        }else{
            return Date2.object(at: row) as! String
        }
    }
    
//    @objc func pickerViewBtnOk() {
//        let row = pickView1.selectedRow(inComponent: 0) //获取当前行
//        let value = Date1.object(at: row) as! String //获取行内数据
//        self.SetTime1.text = value
//    }
    
    @objc func toolBarCancelClick(){
        print("777")
        let row = pickView1.selectedRow(inComponent: 0) //获取当前行
        let value = Date1.object(at: row) as! String //获取行内数据
        self.SetTime1.text = value
    }
    
    @objc func toolBarDoneClick(){
        print("666")
        let row = pickView1.selectedRow(inComponent: 0) //获取当前行
        let value = Date1.object(at: row) as! String //获取行内数据
        self.SetTime1.text = value
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
