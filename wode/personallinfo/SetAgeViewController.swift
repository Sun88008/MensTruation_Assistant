//
//  SetAgeViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/7.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud

class SetAgeViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var txtAge: UITextField!
    var pickView = UIPickerView()
    var pickerDateToolbar = UIToolbar()
    let Age = NSArray(objects:"12岁","13岁","14岁","15岁","16岁","17岁","18岁","19岁","20岁","21岁","22岁","23岁","24岁","25岁","26岁","27岁","28岁","29岁","30岁","31岁","32岁","33岁","34岁","35岁","36岁","37岁","38岁","39岁","40岁")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        
        let currentUser = LCUser.current!//初始化当前用户信息
        let ID = currentUser.objectId?.stringValue//获取objectId
        let query = LCQuery(className: "_User")//选择所在类
        let _ = query.get(ID!) { (result) in
            switch result {
            case .success(object: let object):
                
                print("get age succeed!")
                
                // get value by string key
                let age = object.get("age")?.stringValue
                //let telNum = object.get("telNum")?.stringValue
                
                if(age == "" || age == nil){
                    self.txtAge.text = "方便透露一下年龄吗"
                }else{
                    self.txtAge.text = String(describing: age!)
                }
                print("年龄为："+"\(String(describing: age))")
                
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
        
        pickView.delegate = self
        pickView.dataSource = self
        pickView.layer.backgroundColor = UIColor.white.cgColor
        pickView.layer.masksToBounds = true
        pickView.showsSelectionIndicator = true
        
        pickerDateToolbar = UIToolbar.init(frame: CGRect(x: 0,y: 0,width: 320, height: 44))
        pickerDateToolbar.barStyle = UIBarStyle.blackOpaque
        pickerDateToolbar.sizeToFit()
        
        let barItems = NSMutableArray.init()
        
        let cancelBtn = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarCancelClick))
        barItems.add(cancelBtn)
        
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        barItems.add(flexSpace)
        
        let doneBtn = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarDoneClick))
        barItems.add(doneBtn)
        
        
        pickerDateToolbar.setItems(barItems as? [UIBarButtonItem], animated: true)
        pickerDateToolbar.tintColor = UIColor.black
        pickerDateToolbar.barTintColor = UIColor.white
        
        // 重点的一句
        txtAge.inputView = pickView
        self.txtAge.inputAccessoryView = pickerDateToolbar
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Age.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String{
        return (Age.object(at: row) as? String)!
    }
    
    @objc func toolBarCancelClick(){
        self.view.endEditing(true)
    }
    
    @objc func toolBarDoneClick(){
        let row = pickView.selectedRow(inComponent: 0) //获取当前行
        let value = Age.object(at: row) as! String //获取行内数据
        self.txtAge.text = value
        self.view.endEditing(true)
    }
    
    @IBAction func finishAgeUpdate(_ sender: UIBarButtonItem) {
        let currentUser = LCUser.current!
        
        // 修改当前用户的年龄
        currentUser.set("age", value: txtAge.text)
        
        currentUser.save { result in
            switch result {
            case .success:
                print("age setted!")
                //成功则跳转到changeInfoView处
                let first = self.storyboard
                let secondView:UIViewController = first?.instantiateViewController(withIdentifier: "changeInfoView") as! UIViewController
                self.present(secondView, animated: true, completion: nil)
                break
            case .failure(let error):
                print(error)
            }
        }
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

