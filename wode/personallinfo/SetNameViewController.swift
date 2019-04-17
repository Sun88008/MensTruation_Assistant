//
//  SetNameViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/5.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud

class SetNameViewController: UIViewController {
    @IBOutlet weak var setNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        
        
        setNameTextField.clearButtonMode = UITextFieldViewMode.always
        //点击空白处收起键盘(暂时无效)
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        let currentUser = LCUser.current!//初始化当前用户信息
        let ID = currentUser.objectId?.stringValue//获取objectId
        let query = LCQuery(className: "_User")//选择所在类
        let _ = query.get(ID!) { (result) in
            switch result {
            case .success(object: let object):
                
                print("get name succeed!")
                
                // get value by string key
                let name = object.get("name")?.stringValue
                
                if(name == "" || name == nil){
                    self.setNameTextField.text = "起一个响亮的名字吧"
                }else{
                    self.setNameTextField.text = String(describing: name!)
                }
                print("昵称为："+"\(String(describing: name))")
                
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishNameUpdate(_ sender: UIBarButtonItem) {
        let currentUser = LCUser.current!
        
        // 修改当前用户的昵称
        currentUser.set("name", value: setNameTextField.text)
        
        currentUser.save { result in
            switch result {
            case .success:
                print("name setted!")
                //成功则跳转到changeInfoView处
                self.dismiss(animated: true, completion: nil)
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let viewController: UIViewController = segue.destination
//        (viewController as! ViewController).gender = (sender as! UITableViewCell).textLabel?.text
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
