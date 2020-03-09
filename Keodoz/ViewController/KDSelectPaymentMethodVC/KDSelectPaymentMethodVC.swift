//
//  KDSelectPaymentMethodVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 26/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

protocol PassPaymethodMethodDelegate : class {
    func selctPayment(payment : String)
}

class KDSelectPaymentMethodVC: UIViewController {
    
    @IBOutlet weak var btnPayPal: UIButton!
    @IBOutlet weak var btnCashOnDelivery: UIButton!
    @IBOutlet weak var btnPayWithCard: UIButton!
    weak var delegate : PassPaymethodMethodDelegate?
    var selectPayment : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction private func btnPaypal(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        btnPayPal.isSelected = true
        btnCashOnDelivery.isSelected = false
        btnPayWithCard.isSelected = false
        selectPayment = "PayPal"

    }
    
    @IBAction private func btnCashOnDelivery(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        btnPayPal.isSelected = false
        btnCashOnDelivery.isSelected = true
        btnPayWithCard.isSelected = false
        selectPayment = "Cash On Delivery"

    }
    
    @IBAction private func btnPayWithCard(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        btnPayPal.isSelected = false
        btnCashOnDelivery.isSelected = false
        btnPayWithCard.isSelected = true
        selectPayment = "Credit Card"



    }
    
    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        delegate?.selctPayment(payment: selectPayment ?? " ")
        self.navigationController?.popViewController(animated: true)
    }
}
