//
//  KDServiceCreateVC.swift
//  Keudoz
//
//  Created by Ahmed Durrani on 12/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class KDServiceCreateVC: UIViewController {
    private var serviceList: [ServiceList] = []
    @IBOutlet weak var btnChoseService: UIButton!
    var email : String?
    var type : String?
    var password : String?
    var firstName : String?
    var lastName : String?
    @IBOutlet var txtServiceName : UITextField!
    @IBOutlet var txtServiceDetail: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtServiceName.setLeftPaddingPoints(15.0)
        txtServiceDetail.setLeftPaddingPoints(15.0)

        loadServiceList()
        // Do any additional setup after loading the view.
    }
    
      func loadServiceList() {
        let endPoint = AuthEndpoint.serviceCategories
        let context = (self)
        showProgressIndicator(view: self.view)

        NetworkLayer.fetch(endPoint, with: ServiceResponse.self) {[weak self] (result) in
        switch result {
         case .success(let response):
          hideProgressIndicator(view: context.view)

         if response.status == true {
            context.serviceList = response.data ?? []
         } else {
          context.showToast(response.message)
         }
          case .failure(_):
              hideProgressIndicator(view: context.view)

              context.showToast("Server Error")
              break
          }
      }
    }
    

    @IBAction func btnChooseCountry_Pressed(_ sender: UIButton) {
        
        var allCategoriesList = [String]()
        
        for (_ , info) in (self.serviceList.enumerated()) {
            allCategoriesList.append(info.name!)
        }

        ActionSheetStringPicker.show(withTitle: "Choose Service", rows: allCategoriesList, initialSelection: 0 , doneBlock: {[weak self] (picker, index, value) in
            self!.btnChoseService.setTitle(value as? String , for: .normal)
            return
        }, cancel: { (actionStrin ) in
            
        }, origin: sender)

    }

    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDUserDetailVC") as? KDUserDetailVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
