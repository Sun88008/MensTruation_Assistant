//
//  CellViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/3.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit

class CellViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var txtAge: UITextField!
    var pickView = UIPickerView()
    let Age = NSArray(objects:"12岁","13岁","14岁","15岁","16岁","17岁","18岁","19岁","20岁","21岁","22岁","23岁","24岁","25岁","26岁","27岁","28岁","29岁","30岁","31岁","32岁","33岁","34岁","35岁","36岁","37岁","38岁","39岁","40岁")
    @IBOutlet weak var Touxiang1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickView.delegate = self
        pickView.dataSource = self
        pickView.layer.backgroundColor = UIColor.white.cgColor
        pickView.layer.masksToBounds = true
        pickView.showsSelectionIndicator = true
        self.view.addSubview(pickView)
        Touxiang1.layer.cornerRadius = 10
        self.view.addSubview(Touxiang1)
        txtAge.tintColor = UIColor.lightGray
        self.view.addSubview(txtAge)
        txtAge.inputView = pickView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Age.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return Age.object(at: row) as? String
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
