//
//  testViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/3.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit

class testViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "name"
        case 1:
            cell?.textLabel?.text = "gender"
        case 2:
            cell?.textLabel?.text = "Contatti Aziendali"
            cell?.textLabel?.font = UIFont(name: "AvenirNextCondensed-DemiBold", size:17.0)
        case 3:
            cell?.textLabel?.text = "Indirizzo:  "
        case 4:
            cell?.textLabel?.text = "Tel: "
        case 5:
            cell?.textLabel?.text = "Email: "
        case 6:
            cell?.textLabel?.text = "Sito: "
        case 7:
            cell?.textLabel?.text = "Fax:"
        default:
            cell?.textLabel?.text = ""
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)//点击cell后消除选中效果
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
