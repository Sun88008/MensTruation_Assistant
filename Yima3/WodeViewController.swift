//
//  WodeViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/16.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud

class WodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Touxiang: UIImageView!
    @IBOutlet weak var myName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        
        Touxiang.layer.masksToBounds = true
        Touxiang.layer.cornerRadius = Touxiang.frame.size.width/2
        
        let currentUser = LCUser.current!//初始化当前用户信息
        let ID = currentUser.objectId?.stringValue//获取objectId
        let query = LCQuery(className: "_User")//选择所在类
        let _ = query.get(ID!) { (result) in
            switch result {
            case .success(object: let object):

                print("name get succeed!")

                // get value by string key
                let name = object.get("name")?.stringValue

                if(name == "" || name == nil){
                    self.myName.text = "起一个响亮的名字吧"
                }else{
                    self.myName.text = String(describing: name!)
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
    
    //添加一个代理方法，用来设置表格视图拥有的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return part1.count//数组的长度
        return 1
    }
    
    //添加一个代理方法，用来初始化或复用表格视图中的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        return cell!//返回设置好的单元格对象
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)//点击cell后消除选中效果
    }
    @IBAction func backToWode(segue: UIStoryboardSegue) {
        print("closed for Wode")
    }
    /*
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var count: Int!
        if(tableView == self.tbView){
            count = 3
        }
        if(tableView == self.tbView2){
            count = 1
        }
        if(tableView == self.tbView3){
            count = 1
        }
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView3.dequeueReusableCell(withIdentifier: "cell3_1", for: indexPath) as! tTableViewCell
        /*if(tableView == self.tbView){
            let cell = self.tbView.dequeueReusableCell(withIdentifier: "cell1_1", for: indexPath as IndexPath)
        }else if(tableView == self.tbView2){
            let cell = self.tbView.dequeueReusableCell(withIdentifier: "cell2_1", for: indexPath as IndexPath)
        }else if(tableView == self.tbView3){
            let cell = self.tbView.dequeueReusableCell(withIdentifier: "cell3_1", for: indexPath as IndexPath)
        }*/
        return cell
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
