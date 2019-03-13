//
//  SearchTableView.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/13.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
protocol SearchTableViewDelegate {
    
    func hideKeyBoard()
    
}
class SearchTableView: UITableView {
    var mDelegate:SearchTableViewDelegate!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  
        if mDelegate != nil{
            mDelegate.hideKeyBoard()
        }
    }
        
        

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
