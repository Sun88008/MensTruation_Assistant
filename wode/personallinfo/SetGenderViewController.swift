//
//  SetGenderViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/7.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud

class SetGenderViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var txtGender: UITextField!
    var pickView = UIPickerView()
    var pickerDateToolbar = UIToolbar()
    let Gender = NSArray(objects:"女","男")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        
        let currentUser = LCUser.current!//初始化当前用户信息
        let ID = currentUser.objectId?.stringValue//获取objectId
        let query = LCQuery(className: "_User")//选择所在类
        let _ = query.get(ID!) { (result) in
            switch result {
            case .success(object: let object):
                
                print("get gender succeed!")
                
                // get value by string key
                let gender = object.get("gender")?.stringValue
                //let telNum = object.get("telNum")?.stringValue
                
                if(gender == "" || gender == nil){
                    self.txtGender.text = "小姐姐还是小哥哥鸭"
                }else{
                    self.txtGender.text = String(describing: gender!)
                }
                print("性别为："+"\(String(describing: gender))")
                
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
        txtGender.inputView = pickView
        self.txtGender.inputAccessoryView = pickerDateToolbar

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String{
        return (Gender.object(at: row) as? String)!
    }
    
    @objc func toolBarCancelClick(){
        self.view.endEditing(true)
    }
    
    @objc func toolBarDoneClick(){
        let row = pickView.selectedRow(inComponent: 0) //获取当前行
        let value = Gender.object(at: row) as! String //获取行内数据
        self.txtGender.text = value
        self.view.endEditing(true)
    }
    
    @IBAction func finishGenderUpdate(_ sender: UIBarButtonItem) {
        let currentUser = LCUser.current!
        
        // 修改当前用户的性别
        currentUser.set("gender", value: txtGender.text)
        
        currentUser.save { result in
            switch result {
            case .success:
                print("gender setted!")
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
