//
//  KDSelectLoginOrSignVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 22/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class KDSelectLoginOrSignVC: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let session: Session = Persistence(with: .user).load(), let token = session.token {
//                appDelegate.loadSideMenu()
            
            if session.accountType == "1" {
                 let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
                 let homeVC = storyboard.instantiateViewController(withIdentifier: "KDProUserBookingVC")
                 let side = storyboard.instantiateViewController(withIdentifier: "KDSideMenuVC")

                 let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: homeVC), leftMenuViewController: side)
                 sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
                 sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
                 sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
                 appDelegate.window?.rootViewController = sideMenu
                appDelegate.window?.makeKeyAndVisible()

            } else {
                 let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
                 let homeVC = storyboard.instantiateViewController(withIdentifier: "KDSerciceListVC")
                 let side = storyboard.instantiateViewController(withIdentifier: "KDSideMenuVC")

                 let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: homeVC), leftMenuViewController: side)
                 sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
                 sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
                 sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
                 appDelegate.window?.rootViewController = sideMenu
                appDelegate.window?.makeKeyAndVisible()

            }

//                  let story = UIStoryboard(name: "Home", bundle: nil)
//                  let vc = story.instantiateViewController(withIdentifier: "KDSerciceListVC")
//                  let nav = UINavigationController(rootViewController: vc)
//                  nav.isNavigationBarHidden = true
//                  UIApplication.shared.keyWindow?.rootViewController = nav
              } else {
                  
              }

        // Do any additional setup after loading the view.
    }
    
    
    // Button Action
    @IBAction private func btnSignIn_Pressed(_ sender : UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDLoginVC") as? KDLoginVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true )

    }
    
    @IBAction private func btnSignUp_Pressed(_ sender : UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDAccountTypeSelectVC") as? KDAccountTypeSelectVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true )


    }

    


}
