//
//  photoInCellTableViewCell.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/28.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit

class photoInCellTableViewCell: UITableViewCell {

    @IBOutlet weak var Touxiang1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        Touxiang1.layer.masksToBounds = true
                Touxiang1.layer.cornerRadius = Touxiang1.frame.size.width/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
