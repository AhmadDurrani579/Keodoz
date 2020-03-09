//
//  KDLoginVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class KDLoginVC: UIViewController {

    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtPassword: UITextField!
    var presenter: RegistrationPresenter?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.setLeftPaddingPoints(15.0)
        txtPassword.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)
//        ahmed@gmail.com
//        testing
        
        // User Account
//        txtEmail.text = "ahmad@gmail.com"
//        txtPassword.text = "12345678"
        
        // Pro Account

//        txtEmail.text = "khan@yahoo.com"
//        txtPassword.text = "testing"

        // Do any additional setup after loading the view.
    }
    
    
//    func login(email: String?, password: String?, deviceToken: String?) {
//       
//    }

    
    @IBAction private func btnSignIn_Pressed(_ sender : UIButton) {
        presenter?.signIn(email: txtEmail.text!, password: txtPassword.text!)
    }

    



}

@available(iOS 13.0, *)
extension KDLoginVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showToast(message)
    }
    func registrationDidSucceed(){
        let persistence = Persistence(with: .user)
        showProgressIndicator(view: self.view)
        let context = (self)
        let endPoint = AuthEndpoint.login(email: txtEmail.text! , password: txtPassword.text! , deviceToken: "3d5d943946b39461fffd2a99e2b0d7734ec137cecae2f1d3153c3c2d9bf2231a")
        NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
            switch result {
            case .success(let response):
            if response.code == 200 {
                persistence.save(response.data)
                hideProgressIndicator(view: context.view)
//                self?.appDelegate.loadSideMenu()
                
                if response.data?.accountType == "1" {
                     let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
                     let homeVC = storyboard.instantiateViewController(withIdentifier: "KDProUserBookingVC")
                     let side = storyboard.instantiateViewController(withIdentifier: "KDSideMenuVC")
                     let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: homeVC), leftMenuViewController: side)
                     sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
                     sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
                     sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
                    let nav = UINavigationController(rootViewController: sideMenu)
                    nav.isNavigationBarHidden = true
                    UIApplication.shared.keyWindow?.rootViewController = nav

                } else {
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

                }

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
