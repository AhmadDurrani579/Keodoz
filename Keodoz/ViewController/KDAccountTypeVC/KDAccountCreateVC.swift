//
//  KDAccountCreateVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class KDAccountCreateVC: UIViewController {
    
    @IBOutlet var txtFirstName : UITextField!
    @IBOutlet var txtLastName : UITextField!
    var presenter: RegistrationPresenter?
    var email : String?
    var type : String?
    var password : String?
//    let appDelegate = UIApplication.shared.delegate as! SceneDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFirstName.setLeftPaddingPoints(15.0)
        txtLastName.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnCreateAccount_Pressed(_ sender : UIButton) {
        presenter?.createAccountInfo(firstName: txtFirstName.text!, lastName: txtLastName.text!)
    }
}

@available(iOS 13.0, *)
extension KDAccountCreateVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showToast(message)
    }
    func registrationDidSucceed(){
        if type == "1" {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDServiceCreateVC") as? KDServiceCreateVC else {
                return
            }
            vc.firstName = txtFirstName.text
            vc.lastName = txtLastName.text
            vc.email = email
            vc.type = type
            vc.password = password
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let persistence = Persistence(with: .user)
            showProgressIndicator(view: self.view)
            let context = (self)
            let endPoint = AuthEndpoint.signUp(firstName: txtFirstName.text!, lastName: txtLastName.text! , email: email! , password: password! , type: type!, deviceType: "iOS", deviceToken: "3d5d943946b39461fffd2a99e2b0d7734ec137cecae2f1d3153c3c2d9bf2231a", latitude: "\(DEVICE_LAT)", longitude: "\(DEVICE_LONG)")
            NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
                switch result {
                case .success(let response):
                    
                if response.status == true {
                    persistence.save(response.data)
                    hideProgressIndicator(view: context.view)
                                     let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
                                     let homeVC = storyboard.instantiateViewController(withIdentifier: "KDSerciceListVC")
                                     let side = storyboard.instantiateViewController(withIdentifier: "KDSideMenuVC")

                                     let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: homeVC), leftMenuViewController: side)
                                     sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
                                     sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
                                     sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
                                    let nav = UINavigationController(rootViewController: sideMenu)
                                    nav.isNavigationBarHidden = true
                                    UIApplication.shared.keyWindow?.rootViewController = nav


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
    
    
}
