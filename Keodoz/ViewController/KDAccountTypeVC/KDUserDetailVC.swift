//
//  KDUserDetailVC.swift
//  Keudoz
//
//  Created by Ahmed Durrani on 13/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import TagListView

class KDUserDetailVC: UIViewController {
    
    @IBOutlet weak var txtPerformService: UITextField!
    @IBOutlet weak var txtHourlyRate: UITextField!
    
    @IBOutlet weak var btnUserVenue: UIButton!
    @IBOutlet weak var btnUserHome: UIButton!

    @IBOutlet weak var txtServiceEnter: UITextField!
    
    @IBOutlet weak var serviceItemList: TagListView!
    @IBOutlet weak var txtDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUserVenue(_ sender: UIButton) {
        
    }
    
    @IBAction func btnUserHome(_ sender: UIButton) {
        
    }
    
    @IBAction func btnNext_Pressed(_ sender: UIButton) {
        
    }
}

extension KDUserDetailVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            print(textField.text!)
        }
    }
}
