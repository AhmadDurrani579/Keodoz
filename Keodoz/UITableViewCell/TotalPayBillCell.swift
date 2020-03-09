//
//  TotalPayBillCell.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 26/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class TotalPayBillCell: UITableViewCell {

    @IBOutlet weak var lblDateSelect: UILabel!
    @IBOutlet weak var lbltimeSelect: UILabel!
    @IBOutlet weak var lblAddress: UILabel!

    @IBOutlet weak var lblSerVicePerdayCharge: UILabel!
    
    @IBOutlet weak var lblTotalDay: UILabel!
    
    @IBOutlet weak var lblSubTotal: UILabel!
    
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var lblTotalBill: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
