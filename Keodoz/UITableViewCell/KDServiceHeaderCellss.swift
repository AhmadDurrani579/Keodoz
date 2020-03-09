//
//  KDServiceHeaderCellss.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDServiceHeaderCellss: UITableViewCell {
    
    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var imgOfPro: UIImageView!
    @IBOutlet weak var lblPRice: UILabel!
    @IBOutlet weak var lblNameOfUser: UILabel!
    @IBOutlet weak var lblServiceType: UILabel!
    @IBOutlet weak var lblRatingPercentage: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var viewOfPrice: UIView!
    
    @IBOutlet weak var viewOFPRo: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj : CoachList ) {
        viewOfPrice.backgroundColor = UIColor(red: 85/255.0, green: 119/255.0, blue: 251/255.0, alpha: 1.0)
        viewOFPRo.backgroundColor = UIColor(red: 85/255.0, green: 119/255.0, blue: 251/255.0, alpha: 1.0)

        let firstName = obj.firstName
        let lastName = obj.lastName
        lblNameOfUser.text = "\(firstName!) \(lastName!)"
        lblServiceType.text = obj.serviceDetail?.serviceCategoryName
        lblRatingPercentage.text = obj.serviceDetail?.rate
        let rate = obj.serviceDetail?.rate
        let dayOrMonth = obj.serviceDetail?.rateBasis
        lblPRice.text = "$\(rate!)/\(dayOrMonth!)"
        lblDescription.text = obj.serviceDetail?.details
        if obj.accountType == "1" {
            imgOfPro.isHidden = false
            viewOFPRo.isHidden = false
        } else {
            imgOfPro.isHidden = true
            viewOFPRo.isHidden = true

        }
        guard  let profile = obj.profilePictureLink else {
            return
        }
        imgOfUser.setImage(with: profile, placeholder: UIImage(named: "upload_photo"))
    }
    
    func setCellDataOrder(obj : UserInfo ) {
        viewOfPrice.backgroundColor = UIColor(red: 233/255.0, green: 122/255.0, blue: 139/255.0, alpha: 1.0)
        
        viewOFPRo.backgroundColor = UIColor(red: 233/255.0, green: 122/255.0, blue: 139/255.0, alpha: 1.0)
        let firstName = obj.firstName
        let lastName = obj.lastName
        lblNameOfUser.text = "\(firstName!) \(lastName!)"
        lblServiceType.text = obj.userDetail?.serviceCategoryName
        lblRatingPercentage.text = obj.userDetail?.rate
        let rate = obj.userDetail?.rate
        let dayOrMonth = obj.userDetail?.rateBasis
        lblPRice.text = "$\(rate!)/\(dayOrMonth!)"
        lblDescription.text = obj.userDetail?.details
        if obj.accountType == "1" {
            imgOfPro.isHidden = false
            viewOFPRo.isHidden = false

        } else {
            imgOfPro.isHidden = true
            viewOFPRo.isHidden = true
        }
        guard  let profile = obj.profilePicture else {
            return imgOfUser.image = UIImage(named: "adult_cute")
        }
        imgOfUser.setImage(with: profile, placeholder: UIImage(named: "adult_cute"))
    }

    
}
