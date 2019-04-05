//
//  photoInCellTableViewCell.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/28.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit

class photoInCellTableViewCell: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //@IBOutlet weak var txtAge: UITextField!
//    var pickView = UIPickerView()
//    let Age = NSArray(objects:"12岁","13岁","14岁","15岁","16岁","17岁","18岁","19岁","20岁","21岁","22岁","23岁","24岁","25岁","26岁","27岁","28岁","29岁","30岁","31岁","32岁","33岁","34岁","35岁","36岁","37岁","38岁","39岁","40岁")
    //@IBOutlet weak var Touxiang1: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        pickView.delegate = self
//        pickView.dataSource = self
//        pickView.layer.backgroundColor = UIColor.white.cgColor
//        pickView.layer.masksToBounds = true
//        pickView.showsSelectionIndicator = true
//        self.contentView.addSubview(pickView)
//
//        txtAge.tintColor = UIColor.lightGray
//        self.contentView.addSubview(txtAge)
//        txtAge.inputView = pickView
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        //fatalError("init(coder:) has not been implemented")
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
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
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)//点击cell后消除选中效果
    }
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//            return Age.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//            return Age.object(at: row) as? String
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }

}
