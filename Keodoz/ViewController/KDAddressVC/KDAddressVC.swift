//
//  KDAddressVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 26/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

protocol SelectAddressDelegate : class {
    func selectAddress(payment : String)
}

class KDAddressVC: UIViewController {
    
    @IBOutlet weak var txtAddress: UITextField!
//    @IBOutlet weak var btnDefaultLoc: UIButton!
    weak var delegate : SelectAddressDelegate?
    var userAddress : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnMakeDefualt(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        txtAddress.text = ""
        userAddress = DEVICE_ADDRESS
    }
  
    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        if txtAddress.text!.count > 0 {
            userAddress = txtAddress.text
            delegate?.selectAddress(payment: userAddress ?? " ")
            self.navigationController?.popViewController(animated: true)

        } else {
            userAddress = DEVICE_ADDRESS
            delegate?.selectAddress(payment: userAddress ?? " ")
            self.navigationController?.popViewController(animated: true)

        }
     }
}
