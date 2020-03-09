//
//  KDChangePasswordVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 04/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDChangePasswordVC: UIViewController {
    var presenter: RegistrationPresenter?
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtRetypePassword : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPassword.setLeftPaddingPoints(15.0)
        txtRetypePassword.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnChanegPassword_Pressed(_ sender : UIButton) {
        presenter?.validationOnChangePassword(password: txtPassword.text!, confirmPass: txtRetypePassword.text!)
    }
   
}

//@available(iOS 13.0, *)
extension KDChangePasswordVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showToast(message)
    }
    func registrationDidSucceed(){
//        let persistence = Persistence(with: .user)
        showProgressIndicator(view: self.view)
        let context = (self)

        let endPoint = AuthEndpoint.changePassword(changePass: txtPassword.text! , retypePass: txtRetypePassword.text!)
        NetworkLayer.fetch(endPoint, with: ServiceCoach.self) {[weak self] (result ) in
            switch result {
            case .success(let response):
            if response.code == 200 {
                hideProgressIndicator(view: context.view)
                context.navigationController?.popViewController(animated: true)
            } else {
                context.showToast(response.message!)
                hideProgressIndicator(view: context.view)
            }
            case .failure(_):
                hideProgressIndicator(view: context.view)
                context.showToast("Server Error")
                break
        
            }
            }
         }
    
    
}
