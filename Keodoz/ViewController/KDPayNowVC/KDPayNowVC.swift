//
//  KDPayNowVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 26/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDPayNowVC: UIViewController {
    
    @IBOutlet var tblView : UITableView!
    var coach : CoachList?
    
    var tagsArray : [String] = []
    var combineDate : String?
    var payments : String?
    var timeSelect : String?
    var addressSelect : String?
    var numberOfDays : Int?
    var tagsArrayss : [String] = []
    
    var finalStartate : String?
    var finalEndDate : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.registerCells([BookingOrderCell.self , ServicesCollectionCellss.self , TotalPayBillCell.self ])
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()

//        398
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnPayNow_Pressed(_ sender : UIButton) {
        
        let serviceId = coach?.serviceDetail?.id
        let servieProvide = coach?.serviceDetail?.serviceProvide
        let ratePerDay = coach?.serviceDetail?.rate

        let stringRepresentation = tagsArray.joined(separator: ",")
        let endPoint = AuthEndpoint.bookService(serviceId: "\(serviceId!)", serviceProvide: servieProvide!, startDate: finalStartate!, endDate: finalEndDate!, time: timeSelect, services: stringRepresentation , address: addressSelect!, noOfRateBasis: ratePerDay! , paymentType: payments!)
        showProgressIndicator(view: self.view)

        NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
            switch result {
            case .success(let response):
                hideProgressIndicator(view: self!.view)

            if response.code == 200 {
                self!.showToast(response.message!)
                self?.navigationController?.popToRootViewController(animated: true)
            } else {
                self!.showToast(response.message!)
                hideProgressIndicator(view: self!.view)
            }
            case .failure(_):
                
                hideProgressIndicator(view: self!.view)
                self!.showToast("Server Error")

                break
        
            }
            }
        
    }

   

}

extension KDPayNowVC  : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(with: BookingOrderCell.self, for: indexPath)
            cell.setCellData(obj: coach!)
          return cell
      } else if indexPath.section == 1  {
            let cell = tableView.dequeueReusableCell(with: ServicesCollectionCellss.self, for: indexPath)
        cell.serviceTag.isUserInteractionEnabled = false
        cell.serviceTag.tagBackgroundColor = UIColor(red: 85/255.0, green: 119/255.0, blue: 251/255.0, alpha: 1.0)
        cell.serviceTag.textColor = UIColor.white
        if tagsArray.count != tagsArrayss.count {
            for (_ , service) in ((tagsArray.enumerated())) {
                cell.serviceTag.addTag(service)
                tagsArrayss.append(service)

            }
          }
//            cell.serviceTag.delegate = self
            return cell
      } else {
        
        let cell = tableView.dequeueReusableCell(with: TotalPayBillCell.self, for: indexPath)
        cell.lblDateSelect.text = combineDate
        cell.lbltimeSelect.text = timeSelect
        cell.lblAddress.text = addressSelect
        
        let rate = coach?.serviceDetail?.rate
        let dayOrMonth = coach?.serviceDetail?.rateBasis
        cell.lblSerVicePerdayCharge.text = "$\(rate!)/\(dayOrMonth!)"
        cell.lblTotalDay.text = "\(numberOfDays!) days"
        
        guard let subtotal = Int((coach?.serviceDetail!.rate)!) else {
            return cell
            // either return or throw an error
        }
        
        var totalCharges = subtotal * numberOfDays!
        
        cell.lblSubTotal.text = "$\(totalCharges)"
        cell.lblDiscount.text = "Add promo"
        
        cell.lblTotalBill.text = "$\(totalCharges)"
        return cell

     }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
                return 182.0
        } else if indexPath.section == 1 {
                return UITableView.automaticDimension
        } else {
            return 398.0
        }
    }
}
