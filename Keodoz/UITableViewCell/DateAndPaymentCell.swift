//
//  DateAndPaymentCell.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
protocol PaymentCellDelegate : class {
    func choseDate(cell : DateAndPaymentCell)
    func chosePayment(cell : DateAndPaymentCell)
    func chooseTimeAvailable(cell : DateAndPaymentCell)
    func chooseAddress(cell : DateAndPaymentCell)
}

class DateAndPaymentCell: UITableViewCell {
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnChoseDate: UIButton!
    @IBOutlet weak var btnChosePayment: UIButton!
    @IBOutlet weak var btnChoseTime: UIButton!
    weak var delegate : PaymentCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnChooseDate_Pressed(_ sender: UIButton) {
        delegate?.choseDate(cell: self)
    }
    
    @IBAction func btnPaymentMethod_Pressed(_ sender: UIButton) {
        delegate?.chosePayment(cell: self)
    }
    @IBAction func btnChooseTime_Pressed(_ sender: UIButton) {
        delegate?.chooseTimeAvailable(cell: self)
    }
    
    @IBAction func btnAddAddress_Pressed(_ sender: UIButton) {
        delegate?.chooseAddress(cell: self)
    }
    
    
}
