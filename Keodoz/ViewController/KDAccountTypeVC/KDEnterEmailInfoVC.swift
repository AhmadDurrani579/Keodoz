//
//  KDEnterEmailInfoVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)

class KDEnterEmailInfoVC: UIViewController {
    @IBOutlet var txtEmail: UITextField!
    var presenter: RegistrationPresenter?
    var type : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
         presenter?.EmailInfo(email: txtEmail.text!)
     }


   
}

@available(iOS 13.0, *)
extension KDEnterEmailInfoVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showToast(message)
    }
    func registrationDidSucceed(){
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDPasswordInfoVC") as? KDPasswordInfoVC else {
            return
        }
        vc.email = txtEmail.text!
        vc.typeSelct = type
        self.navigationController?.pushViewController(vc, animated: true )

    }
    
    
}
