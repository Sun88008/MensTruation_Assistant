//
//  cellLableTableViewCell.swift
//  Yima3
//
//  Created by Dsssss on 2019/4/5.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud

class nameLableTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let currentUser = LCUser.current!//初始化当前用户信息
        let ID = currentUser.objectId?.stringValue//获取objectId
        let query = LCQuery(className: "_User")//选择所在类
        let _ = query.get(ID!) { (result) in
            switch result {
            case .success(object: let object):
                
                print("get name succeed!")
                
                // get value by string key
                let name = object.get("name")?.stringValue
                
                if(name == "" || name == nil){
                    self.nameLable.text = "起一个响亮的名字吧"
                }else{
                    self.nameLable.text = String(describing: name!)
                }
                print("昵称为："+"\(String(describing: name))")
                
            case .failure(error: let error):
                // handle error
                print(error)
                break
            }
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
