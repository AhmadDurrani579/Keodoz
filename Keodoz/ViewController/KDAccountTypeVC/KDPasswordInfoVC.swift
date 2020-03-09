//
//  KDPasswordInfoVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class KDPasswordInfoVC: UIViewController {

    @IBOutlet var txtPassword: UITextField!
    var presenter: RegistrationPresenter?
    var typeSelct : String?
    var email : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPassword.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
         presenter?.passwordInf(password : txtPassword.text!)
     }
}

@available(iOS 13.0, *)
extension KDPasswordInfoVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showToast(message)
    }
    func registrationDidSucceed(){
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDAccountCreateVC") as? KDAccountCreateVC else {
            return
        }
        vc.email = email
        vc.type = typeSelct
        vc.password = txtPassword.text!
        self.navigationController?.pushViewController(vc, animated: true )

    }
    
    
}

