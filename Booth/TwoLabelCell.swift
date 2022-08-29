//
//  TwoLabelCell.swift
//  Booth
//
//  Created by Veer M on 1/30/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit

class TwoLabelCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var cell_background: UIView!
    @IBOutlet weak var cell_separator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
