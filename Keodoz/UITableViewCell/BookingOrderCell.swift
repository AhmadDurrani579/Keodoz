//
//  BookingOrderCell.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class BookingOrderCell: UITableViewCell {

    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblServiceType: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setCellData(obj : CoachList ) {
        let firstName = obj.serviceDetail?.userInfo?.firstName ?? obj.firstName
        let lastName = obj.serviceDetail?.userInfo?.lastName ?? obj.lastName
        lblName.text = "\(firstName!) \(lastName!)"
        lblServiceType.text = obj.serviceDetail?.serviceCategoryName
        lblRating.text = "4.9/5.0"
        let rate = obj.serviceDetail?.rate
        let dayOrMonth = obj.serviceDetail?.rateBasis
        
        lblPrice.text = "$\(rate!)/\(dayOrMonth!)"
        guard  let profile = obj.serviceDetail?.userInfo?.profilePictureLink ?? obj.profilePictureLink else {
            return
        }
        imgOfUser.setImage(with: profile, placeholder: UIImage(named: "upload_photo"))
    }
    
    func setOrderCellData(obj : OrderList) {
        let firstName = obj.ownerOrder?.firstName
        let lastName = obj.ownerOrder?.lastName
        lblName.text = "\(firstName!) \(lastName!)"
        lblPrice.text = "Buisness Coach"
        lblRating.text = " "
//        let rate = obj.serviceDetail?.rate
//        let dayOrMonth = obj.serviceDetail?.rateBasis
//        lblPRice.text = "$\(rate!)/\(dayOrMonth!)"
//        lblDescription.text = obj.serviceDetail?.details
//        if obj.accountType == "1" {
//            imgOfPro.isHidden = false
//        } else {
//            imgOfPro.isHidden = true
//        }
        
        guard  let profile = obj.ownerOrder?.profilePictureLink else {
            return
        }
        imgOfUser.setImage(with: profile, placeholder: UIImage(named: "upload_photo"))
    }

    
}
