//
//  SetTelNumViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/7.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud

class SetTelNumViewController: UIViewController {
    @IBOutlet weak var txtTelNum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        let currentUser = LCUser.current!//初始化当前用户信息
        let ID = currentUser.objectId?.stringValue//获取objectId
        let query = LCQuery(className: "_User")//选择所在类
        let _ = query.get(ID!) { (result) in
            switch result {
            case .success(object: let object):
                
                print("telNum get succeed!")
                
                // get value by string key
                let telNum = object.get("telNum")?.stringValue
                if(telNum == "" || telNum == nil){
                    self.txtTelNum.text = "请输入您的电话号码"
                }else{
                    self.txtTelNum.text = String(describing: telNum!)
                }
                print("电话号码为："+"\(String(describing: telNum))")
                
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishtelNumUpdate(_ sender: UIBarButtonItem) {
        let currentUser = LCUser.current!//初始化当前用户信息
        // 修改当前用户的电话号码
        currentUser.set("telNum", value: txtTelNum.text)
        
        currentUser.save { result in
            switch result {
            case .success:
                print("telNum setted!")
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
