//
//  textTableViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/25.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit

class textTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var weeks = ["修改信息", "添加状态", "添加提醒"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        // Do any additional setup after loading the view, typically from a nib.
        let rect = CGRect(x: 0, y: 40, width: 414, height: 132)//创建一个显示区域 每个cell44
        let tableView = UITableView(frame: rect)//初始化一个表格视图，并设置其位置和尺寸
        tableView.delegate = self//设置表格视图的代理为当前的视图控制器类
        tableView.dataSource = self//设置表格视图的数据源为当前的视图控制器类
        self.view.addSubview(tableView)//将表格视图添加到当前视图控制器的根视图中
    }
    
    //添加一个代理方法，用来设置表格视图拥有的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks.count//数组的长度
    }
    
    //添加一个代理方法，用来初始化或复用表格视图中的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reusedCell"//创建一个字符串，作为单元格的复用标识符
        //单元格的标识符可以看作是一种复用机制，此方法可以从所有已经开辟内存的单元格里面，选择一个具有同样标识符的、空闲的单元格
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        //如果在可重用单元格队列中，没有可以重复使用的单元格，则创建新的单元格。新单元格拥有一个复用标识符
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)
        }
        //索引路径用来标识单元格在表格中的位置，它有section和row两个属性，前者标识单元格处于第几个段落，后者表示在段落中第几行
        let rowNum = indexPath.row
        cell?.textLabel?.text = weeks[rowNum]//根据当前单元格的行数，从数组中获取对应位置的元素，作为当前单元格的标题文字
        return cell!//返回设置好的单元格对象
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
