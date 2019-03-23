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
import SnapKit
import Alamofire

class WodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Touxiang: UIImageView!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var tbView2: UITableView!
    @IBOutlet weak var tbView3: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,
                                            alpha: 1)
        
        Touxiang.layer.masksToBounds = true
        Touxiang.layer.cornerRadius = Touxiang.frame.size.width/2
        

        // Do any additional setup after loading the view.
    }
    
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
        let cell = UITableViewCell()
        /*if(tableView == self.tbView){
            let cell = self.tbView.dequeueReusableCell(withIdentifier: "cell1_1", for: indexPath as IndexPath)
        }else if(tableView == self.tbView2){
            let cell = self.tbView.dequeueReusableCell(withIdentifier: "cell2_1", for: indexPath as IndexPath)
        }else if(tableView == self.tbView3){
            let cell = self.tbView.dequeueReusableCell(withIdentifier: "cell3_1", for: indexPath as IndexPath)
        }*/
        return cell
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
