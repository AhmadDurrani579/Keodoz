//
//  KDSettingVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 04/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDSettingVC: UIViewController {
    @IBOutlet var btnMenu: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction private func btnChangePAssword_Pressed(_ sender : UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDChangePasswordVC") as? KDChangePasswordVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func btnEndableReceiveNotification_Pressed(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected

    }
    
    @IBAction private func btnReceiveNewsLetter_Pressed(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected

    }
    
    @IBAction private func btnReceiveSpecialOffer_Pressed(_ sender : UIButton) {
           sender.isSelected = !sender.isSelected

       }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
