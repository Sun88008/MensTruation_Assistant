//
//  SetMenstruationViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/4.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import SnapKit

class SetMenstruationViewController: UIViewController, UIActionSheetDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*let datePicker = UIDatePicker()
        datePicker.center = CGPoint(x: 200, y: 250)
        datePicker.tag = 1
        self.view.addSubview(datePicker)
        let rect = CGRect(x: 70, y: 360, width: 280, height: 44)
        let button = UIButton(type: UIButtonType.roundedRect)
        button.frame = rect
        button.backgroundColor = UIColor.lightGray
        button.setTitle("最近一次姨妈日期", for: UIControlState())
        button.addTarget(self, action: #selector(SetMenstruationViewController.getDate), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        */
        
    }
    /*@objc func getDate(){
        let datePicker = self.view.viewWithTag(1) as! UIDatePicker
        let date = datePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateAndTime = dateFormater.string(from: date)
        
        let alert = UIAlertController(title: "Information", message: dateAndTime, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
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
