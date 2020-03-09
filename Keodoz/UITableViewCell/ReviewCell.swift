//
//  ReviewCell.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblRate: UILabel!
    
    @IBOutlet weak var lblComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj : ReviewOnService ) {
        lblName.text = "Ahmad"
        lblComment.text = "Ahmad is ok"
        lblRate.text = "3/5"

//        let firstNAme = obj.userReview?.firstName
//        let lastName  = obj.userReview?.lastName
//        lblName.text =  "\(firstNAme!) \(lastName!)"
//        let rating = obj.rating
//        lblRate.text = "\(rating!)/5"
//        lblComment.text =  obj.review
    }
    
    
    
}
