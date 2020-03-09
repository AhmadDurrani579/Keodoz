//
//  KDProUserEditProfileVC.swift
//  Keudoz
//
//  Created by Ahmed Durrani on 14/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDProUserEditProfileVC: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNum: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let persistence = Persistence(with: .user)
        userObj  = persistence.load()
        txtFirstName.text = userObj?.firstName!
        txtLastName.text = userObj?.lastName!
        txtEmail.text = userObj?.email
        txtPhoneNum.text = userObj?.phoneNumber

        
        // Do any additional setup after loading the view.
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
