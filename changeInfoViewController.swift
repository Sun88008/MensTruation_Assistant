//
//  changeInfoViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/28.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit

class changeInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var txtAge = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        
        txtAge.frame = CGRect(x:280,y:6,width:50,height:30)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.isScrollEnabled = false //禁止上下滑动
        // Configure the cell...
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            cell.textLabel?.text = "头像"
            //初始化imageview
            let itemSize = CGSize(width:40,height:40)
            UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
            let imageRect = CGRect(x:0,y:0,width:itemSize.width,height:itemSize.height)
            cell.imageView?.image?.draw(in: imageRect)
            cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsGetCurrentContext()
            //设置圆角
            let cellImageLayer = cell.imageView?.layer
            cellImageLayer?.cornerRadius = 23.0
            cellImageLayer?.masksToBounds = true
            cell.imageView?.image = #imageLiteral(resourceName: "touxiang")
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
            cell.textLabel?.text = "昵称"
            return cell
        }else if(indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
            cell.textLabel?.text = "性别"
            return cell
        }else if(indexPath.row == 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath)
            cell.textLabel?.text = "年龄"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell5", for: indexPath)
            cell.textLabel?.text = "手机号码"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)//点击cell后消除选中效果
    }
    @IBAction func backToInfo(segue: UIStoryboardSegue) {
        print("closed for Info")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
