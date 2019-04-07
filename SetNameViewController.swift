//
//  SetNameViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/5.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud

class SetNameViewController: UIViewController {
    @IBOutlet weak var setNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishNameUpdate(_ sender: UIBarButtonItem) {
        let currentUser = LCUser.current!
        
        // 修改当前用户的昵称
        currentUser.set("name", value: setNameTextField.text)
        
        currentUser.save { result in
            switch result {
            case .success:
                print(String(describing: currentUser.objectId?.stringValue)+"***")
                print("name setted!")
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let viewController: UIViewController = segue.destination
//        (viewController as! ViewController).gender = (sender as! UITableViewCell).textLabel?.text
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
