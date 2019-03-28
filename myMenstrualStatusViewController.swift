//
//  myMenstrualStatusViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/28.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import SnapKit
import LeanCloud
import AVOSCloud
import Alamofire

class myMenstrualStatusViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var finishbtm: UIButton!
    @IBOutlet weak var mentrualCycle: UIView!
    @IBOutlet weak var menturalTime: UIView!
    
    var Date = UIDatePicker()
    @IBOutlet weak var SetTime1: UITextField!
    @IBOutlet weak var SetTime2: UITextField!
    
    var pickView = UIPickerView()
    let Date1 = NSArray(objects:"15天","16天","17天","18天","19天","20天","21天","22天","23天","24天","25天","26天","27天","28天","29天","30天","31天","32天","33天","34天","35天","36天","37天","38天","39天","40天","41天","42天","43天","44天","45天","46天","47天","48天","49天","50天")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        self.finishbtm.layer.cornerRadius = 10
        self.mentrualCycle.layer.cornerRadius = 10
        self.menturalTime.layer.cornerRadius = 10
        
        pickView.delegate = self
        pickView.dataSource = self
        pickView.layer.backgroundColor = UIColor.white.cgColor
        pickView.layer.masksToBounds = true
        
        
        
        // 重点的一句
        SetTime1.inputView = pickView
        self.view.addSubview(SetTime1)
        
        // Do any additional setup after loading the view.
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Date1.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Date1.object(at: row) as! String
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
