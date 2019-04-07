//
//  ageLableTableViewCell.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/7.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
class ageLableTableViewCell: UITableViewCell {

    @IBOutlet weak var ageLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //let currentUser = LCUser.current!
        let query = LCQuery(className: "_User")
        let _ = query.get("5c95f5c0fe88c2006f319988") { (result) in
            switch result {
            case .success(object: let object):
                
                print("get succeed!")
                
                // get value by string key
                let age = object.get("age")?.stringValue
                //let telNum = object.get("telNum")?.stringValue
                
                if(age == nil){
                    self.ageLable.text = "方便透露一下年龄吗"
                }else{
                    self.ageLable.text = String(describing: age!)
                }
                print("年龄为："+"\(String(describing: age))")
                
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
        //        print(nameLable.text)
        //        print(currentUser.name!)
        //        print(currentUser.username!)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

