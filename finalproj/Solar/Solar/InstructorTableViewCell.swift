//
//  InstructorTableViewCell.swift
//  Solar
//
//  Created by mac on 2020/7/4.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class InstructorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var code:UILabel!
    @IBOutlet weak var credit:UILabel!
    @IBOutlet weak var instructor:UILabel!
    @IBOutlet weak var category:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
