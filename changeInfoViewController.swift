//
//  changeInfoViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/28.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit

class changeInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1) 
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        // Configure the cell...
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)//点击cell后消除选中效果
    }
    @IBAction func backToTouxiang(segue: UIStoryboardSegue) {
        print("closed for Touxiang")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
