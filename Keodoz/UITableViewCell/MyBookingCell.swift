//
//  MyBookingCell.swift
//  Keudoz
//
//  Created by Ahmed Durrani on 13/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class MyBookingCell: UITableViewCell {

    @IBOutlet weak var lblOrderNum: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblDatw: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(order : OrderList) {
        let orderNumber = order.id
        lblOrderNum.text = "Order #\(orderNumber!)"
        let totalPayment = order.totalPayment
        lblPrice.text = "$\(totalPayment!)"
        
        let startDate = self.getFormattedDate(string: order.startDate!)
        let endDate = self.getFormattedDate(string: order.endDate!)
        
        lblDatw.text = "\(startDate) - \(endDate)"

        if order.status == "1"{
            lblStatus.text = "Ended"
            lblStatus.textColor = UIColor(red: 235/255.0, green: 131/255.0, blue: 148/255.0, alpha: 1.0)

        } else {
            lblStatus.text = "Pending"
            lblStatus.textColor = UIColor(red: 235/255.0, green: 170/255.0, blue: 56/255.0, alpha: 1.0)

//            lblStatus.textColor = UIColor(red: 235/255.0, green: 131/255.0, blue: 148/255.0, alpha: 1.0)
        }
        
        
    }
    
    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }


}
