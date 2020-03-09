//
//  KDAccountTypeSelectVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)

class KDAccountTypeSelectVC: UIViewController {
    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var imgOfPro: UIImageView!
    var typeSelect : String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction private func btnUserSelect_Pressed(_ sender : UIButton) {
        imgOfUser.isHidden = false
        imgOfPro.isHidden = true
        typeSelect = "0"
    }
    
    @IBAction private func btnProSelect_Pressed(_ sender : UIButton) {
        imgOfUser.isHidden = true
        imgOfPro.isHidden = false
        typeSelect = "1"
    }
    
    @IBAction private func btnContinue_PRessed(_ sender : UIButton) {
        guard (typeSelect != nil)  else {
            self.showToast("Please select option")
            return
        }
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDEnterEmailInfoVC") as? KDEnterEmailInfoVC else {
            return
        }
        vc.type = typeSelect
        self.navigationController?.pushViewController(vc, animated: true )

        
        
        
    }


   

}
