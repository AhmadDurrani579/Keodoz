//
//  ServiceCell.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class ServiceCell: UITableViewCell {

    @IBOutlet weak var imgOfService: UIImageView!
    @IBOutlet weak var lblServiceNam: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(service : ServiceList) {
        lblServiceNam.text = service.name
        guard  let profile = service.image else {
            return
        }
        imgOfService.setImage(with: profile, placeholder: UIImage(named: "upload_photo"))

    }
    
    
}
