//
//  BookingCell.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 01/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class BookingCell: UITableViewCell {
    
    @IBOutlet weak var coachImage: UIImageView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var coachServiceType: UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblJobActiveOrEnd : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(coach : CoachList) {
        let firstName = coach.serviceDetail?.userInfo?.firstName
        let lastName = coach.serviceDetail?.userInfo?.lastName
        coachName.text = "\(firstName!) \(lastName!)"
        coachServiceType.text = coach.serviceDetail?.serviceCategoryName
        
        if coach.status == "1" {
            lblJobActiveOrEnd.text = "Active"
        } else {
            lblJobActiveOrEnd.text = "Ended"
        }
        
        let startDate = self.getFormattedDate(string: coach.startDate!)
        let endDate = self.getFormattedDate(string: coach.endDate!)

        lblDate.text = "\(startDate) - \(endDate)"
        
        guard  let profile = coach.serviceDetail?.userInfo?.profilePictureLink else {
            return
        }
        coachImage.setImage(with: profile, placeholder: UIImage(named: "upload_photo"))

    }
    
    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }


}
