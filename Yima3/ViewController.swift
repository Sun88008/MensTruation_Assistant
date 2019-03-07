//
//  ViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/3.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
import SnapKit

class ViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var text : String?
    @IBAction func Sign(_ sender: Any) {
    }
    
    @IBAction func ConfirmMentruationDate(_ sender: Any) {
        //SetTime.isEnabled = false //使文本框无法编辑
    }
    
    @IBOutlet weak var ReceiveValue: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //启动界面延时
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        Thread.sleep(forTimeInterval: 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func back(segue: UIStoryboardSegue) {
        print("closed")
    }
    

}

