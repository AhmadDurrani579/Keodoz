//
//  ServicesCollectionCellss.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import TagListView

class ServicesCollectionCellss: UITableViewCell {

    @IBOutlet weak var serviceTag: TagListView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
