//
//  KDOrderEndVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 02/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import TagListView
class KDOrderEndVC: UIViewController {
    @IBOutlet var tblView : UITableView!
    var coach : CoachList?
    var tagsArray : [String] = []
    var selectTag : [String] = []

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
    
    @IBAction private func btnEndOrder_Pressed(_ sender : UIButton) {
//        let orderId = coach?.id  ?? 0
//        let endPoint = AuthEndpoint.updateOrderStatus(orderId: "\(orderId)")
//        let context = (self)
//        showProgressIndicator(view: self.view)
//        NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result) in
//            switch result {
//            case .success(let response):
//                hideProgressIndicator(view: context.view)
//                if response.status == true {
//                    context.showToast(response.message)
//                    self?.navigationController?.popToRootViewController(animated: true)
//            } else {
//                    context.showToast(response.message)
//           }
//        case .failure(_):
//            hideProgressIndicator(view: context.view)
//
//            context.showToast("Server Error")
//            break
//        }
//
//    }
  }


}

extension KDOrderEndVC  : UITableViewDelegate , UITableViewDataSource {
    
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
        
        if tagsArray.count != coach?.serviceDetail?.servicesPerform?.count {
            for (_ , service) in ((coach?.serviceDetail?.servicesPerform?.enumerated())!) {
                cell.serviceTag.addTag(service.name!)
                tagsArray.append(service.name!)
            }
        }
        cell.serviceTag.delegate = self

//        if tagsArray.count != tagsArrayss.count {
//            for (_ , service) in ((tagsArray.enumerated())) {
//                cell.serviceTag.addTag(service)
//                tagsArrayss.append(service)
//
//            }
//          }
            
            return cell
      } else {
        
        let cell = tableView.dequeueReusableCell(with: TotalPayBillCell.self, for: indexPath)
        let startDate = self.getFormattedDate(string: (coach?.startDate!)!)
        let endDate = self.getFormattedDate(string: (coach?.endDate!)!)
        cell.lblDateSelect.text = "\(startDate) - \(endDate)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let startDates = dateFormatter.date(from:coach!.startDate!)!
        let endDates = dateFormatter.date(from:coach!.endDate!)!
        
        let numberOfDays =  endDates.interval(ofComponent: .day, fromDate: startDates)

        cell.lbltimeSelect.text = coach?.time
        cell.lblAddress.text = coach?.address
        let rate = coach?.serviceDetail?.rate
        let dayOrMonth = coach?.serviceDetail?.rateBasis
//        let numbeROfRatr = coach?.noOfRateBasis
        cell.lblSerVicePerdayCharge.text = "$\(rate!)/\(dayOrMonth!)"
        cell.lblTotalDay.text = "\(numberOfDays) days"
        
        guard let subtotal = Int((coach?.serviceDetail!.rate)!) else {
            return cell
            // either return or throw an error
        }
        
        var totalCharges = subtotal * numberOfDays
        
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

extension KDOrderEndVC : TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
//        print("Tag pressed: \(title), \(sender)")
//        tagView.isSelected = !tagView.isSelected
//        if selectTag.contains(title) == true {
//            selectTag = selectTag.filter{$0 != title}
//
//        } else {
//            selectTag.append(title)
//        }
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}


