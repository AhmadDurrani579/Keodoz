//
//  BookServiceHeaderCell.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class BookServiceHeaderCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblPrice: UILabel!

    @IBOutlet weak var btnChoseService: UIButton!
    @IBOutlet weak var btnServiceWant: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj : CoachList ) {
        let firstName = obj.firstName
        let lastName = obj.lastName
        lblUserName.text = "\(firstName!) \(lastName!)"
        lblService.text = obj.serviceDetail?.serviceCategoryName
        lblRating.text = "4.9/5.0"
        let rate = obj.serviceDetail?.rate
        let dayOrMonth = obj.serviceDetail?.rateBasis
        
        lblPrice.text = "$\(rate!)/\(dayOrMonth!)"
        
        let serviceWant = obj.serviceDetail?.serviceProvide
        btnServiceWant.setTitle(serviceWant, for: .normal)
        btnChoseService.setTitle(serviceWant, for: .normal)

        guard  let profile = obj.profilePictureLink else {
            return
        }
        imgOfUser.setImage(with: profile, placeholder: UIImage(named: "upload_photo"))
    }
}
