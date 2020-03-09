//
//  KDAcceptBookingVC.swift
//  Keudoz
//
//  Created by Ahmed Durrani on 13/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDAcceptBookingVC: UIViewController {
    @IBOutlet var tblView : UITableView!
    var coach : OrderList?
    var tagsArray : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.registerCells([BookingOrderCell.self , ServicesCollectionCellss.self , TotalPayBillCell.self ])
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
    }

    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }

    @IBAction private func btnAcceptOrder_Pressed(_ sender : UIButton) {
                let orderId = coach?.id  ?? 0
                let endPoint = AuthEndpoint.updateOrderStatus(orderId: "\(orderId)")
                let context = (self)
                showProgressIndicator(view: self.view)
                NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result) in
                    switch result {
                    case .success(let response):
                        hideProgressIndicator(view: context.view)
                        if response.status == true {
                            context.showToast(response.message)
                            self?.navigationController?.popToRootViewController(animated: true)
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
   

}

extension KDAcceptBookingVC  : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(with: BookingOrderCell.self, for: indexPath)
          cell.setOrderCellData(obj: coach!)
          return cell
      } else if indexPath.section == 1  {
       let cell = tableView.dequeueReusableCell(with: ServicesCollectionCellss.self, for: indexPath)
        cell.serviceTag.isUserInteractionEnabled = false
        cell.serviceTag.tagBackgroundColor = UIColor(red: 85/255.0, green: 119/255.0, blue: 251/255.0, alpha: 1.0)
        cell.serviceTag.textColor = UIColor.white
//        if tagsArray.count != tagsArrayss.count {
//            for (_ , service) in ((tagsArray.enumerated())) {
//                cell.serviceTag.addTag(service)
//                tagsArrayss.append(service)
//
//            }
//          }
        cell.serviceTag.addTag("EMyth")
        cell.serviceTag.addTag("Building Champions")

//        tagsArray.append("EMyth")
//        tagsArray.append("Building Champions")

//        cell.serviceTag.delegate = self
            return cell
      } else {
        
        let cell = tableView.dequeueReusableCell(with: TotalPayBillCell.self, for: indexPath)
        
        let startDatess  =  self.getFormattedDate(string: self.coach!.startDate!)
        
        let endDate  =  self.getFormattedDate(string: self.coach!.endDate!)
        let noOfRateBasis  = self.coach!.payment!
        let totalDay  = self.coach!.noOfRateBasis!
        cell.lblDateSelect.text = "\(startDatess) - \(endDate)"
        cell.lbltimeSelect.text = "8:00 am"
        cell.lblAddress.text = coach?.address
        cell.lblSerVicePerdayCharge.text = "$\(noOfRateBasis)"
//
        cell.lblTotalDay.text = "+\(totalDay) days"
        guard let subtotal = Int((coach?.noOfRateBasis)!) else {
            return cell
            // either return or throw an error
        }

        let totalCharges = Int(totalDay)! * Int(subtotal)

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
