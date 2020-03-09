//
//  CoachListCell.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class CoachListCell: UITableViewCell {

    @IBOutlet weak var coachImage: UIImageView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var coachServiceType: UILabel!
    @IBOutlet weak var coachRating: UILabel!
    @IBOutlet weak var coachDistance: UILabel!
    
    @IBOutlet weak var imgOfPro: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellData(obj : CoachList ) {
        let firstName = obj.firstName
        let lastName = obj.lastName
        coachName.text = "\(firstName!) \(lastName!)"
        coachServiceType.text = obj.serviceDetail?.name
        coachRating.text = obj.serviceDetail?.rate
        coachDistance.text = "\(obj.distance!) km away"
        
        if obj.accountType == "1" {
            imgOfPro.isHidden = false
        } else {
            imgOfPro.isHidden = true
        }
        guard  let profile = obj.profilePictureLink else {
            return
        }
        coachImage.setImage(with: profile, placeholder: UIImage(named: "upload_photo"))
    }
    
}
