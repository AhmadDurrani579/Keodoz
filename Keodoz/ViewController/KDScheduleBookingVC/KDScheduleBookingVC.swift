//
//  KDScheduleBookingVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 26/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import TagListView
import EAAlertView
class KDScheduleBookingVC: UIViewController {
    
    @IBOutlet var tblView : UITableView!
    var coach : CoachList?
    var tagsArray : [String] = []
    var startDate : String?
    var endDate  : String?
    var payments : String?
    var timeSelect : String?
    var addressSelect : String?

    var tagsArrayss : [String] = []
    var combineDate : String?
    var choseStartDate : Date?
    
    var numberOFDays : Int?
    
    var finalStartate : String?
    var finalEndDate : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.registerCells([BookingOrderCell.self , ServicesCollectionCellss.self , DateAndPaymentCell.self ])
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()

        // Do any additional setup after loading the view.
    }
 
 func chooseStartDate() {
    
    let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.8, height: 200))
    picker.datePickerMode = UIDatePicker.Mode.date
    let appearance = EAAlertView.EAAppearance(kButtonHeight: 60, showCloseButton: false, shouldAutoDismiss: false)
    let alert = EAAlertView(appearance: appearance)
    alert.customSubview = picker
    _ = alert.addButton(backgroundImage: UIImage(named: "gradient_btn"), "Select") {
                                        let formatter = DateFormatter()
                                        formatter.dateFormat = "yyyy-MM-dd"
                                        let dateValue = formatter.string(from: picker.date)
                                        self.finalStartate = dateValue
                                        self.startDate =  self.getFormattedDate(string: dateValue)
                                        self.choseStartDate = picker.date
                                        self.startDate = dateValue
                                        alert.hideView()
                                        self.chooseEndDate()
    }
    _ = alert.show("Start Date", subTitle: " ")

//        let currentDate = Date()
//        var dateComponents = DateComponents()
//        dateComponents.month = 1970
//        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
//        let datePicker = DatePickerDialog(textColor: .black,
//                                          buttonColor: .black,
//                                          font: UIFont.boldSystemFont(ofSize: 17),
//                                          showCancelButton: false)
//        datePicker.show("Choose Start Date",
//                        doneButtonTitle: "Done",
//                        minimumDate: threeMonthAgo,
//                        maximumDate: currentDate,
//                        datePickerMode: .date) { (date) in
//                            if let dt = date {
//                                let formatter = DateFormatter()
//                                formatter.dateFormat = "yyyy-MM-dd"
//                                let dateValue = formatter.string(from: dt)
//                                self.finalStartate = dateValue
//                                self.startDate =  self.getFormattedDate(string: dateValue)
//                                self.choseStartDate = dt
////                                self.startDate = dateValue
//                                self.chooseEndDate()
//
//            }
//        }
    }
    
    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }

    
    func chooseEndDate() {
        
        
        let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.8, height: 200))
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.minimumDate = choseStartDate
        let appearance = EAAlertView.EAAppearance(kButtonHeight: 60, showCloseButton: false, shouldAutoDismiss: false)
        let alert = EAAlertView(appearance: appearance)
        alert.customSubview = picker
        _ = alert.addButton(backgroundImage: UIImage(named: "gradient_btn"), "Select") {
                                                    let formatter = DateFormatter()
                                                formatter.dateFormat = "yyyy-MM-dd"
                                                self.numberOFDays = picker.date.interval(ofComponent: .day, fromDate: self.choseStartDate!)
                                               let dateValue = formatter.string(from: picker.date)
                                               self.finalEndDate = dateValue
                                            
                                                                            self.endDate =  self.getFormattedDate(string: dateValue)
                                                    self.startDate = self.getFormattedDate(string: self.startDate!)
                                                                            self.tblView.reloadData()
                                            alert.hideView()
        }
        _ = alert.show("End Date", subTitle: " ")

//        let currentDate = Date()
//        var dateComponents = DateComponents()
//        dateComponents.month = 1970
//        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
//        let datePicker = DatePickerDialog(textColor: .black,
//                                          buttonColor: .black,
//                                          font: UIFont.boldSystemFont(ofSize: 17),
//                                          showCancelButton: false)
//        datePicker.show("Choose End Date",
//                        doneButtonTitle: "Done",
//                        minimumDate: threeMonthAgo,
//                        maximumDate: currentDate,
//                        datePickerMode: .date) { (date) in
//                            if let dt = date {
//                                let formatter = DateFormatter()
//                                formatter.dateFormat = "yyyy-MM-dd"
//
//                                self.numberOFDays = dt.interval(ofComponent: .day, fromDate: self.choseStartDate!)
//                                let dateValue = formatter.string(from: dt)
//                                self.finalEndDate = dateValue
//
//                                self.endDate =  self.getFormattedDate(string: dateValue)
//                                self.tblView.reloadData()
//
//            }
//        }
    }

    func choseTime() {
        
        let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.8, height: 200))
        picker.datePickerMode = UIDatePicker.Mode.time
        let appearance = EAAlertView.EAAppearance(kButtonHeight: 60, showCloseButton: false, shouldAutoDismiss: false)
        let alert = EAAlertView(appearance: appearance)
        alert.customSubview = picker
        _ = alert.addButton(backgroundImage: UIImage(named: "gradient_btn"), "Select") {
                                            let formatter = DateFormatter()
                                            formatter.dateFormat = "h:mm:ss a"
                                            let dateValue = formatter.string(from: picker.date)
                                            self.timeSelect =  dateValue
                                            self.tblView.reloadData()
                                            alert.hideView()
        }
        _ = alert.show("Start Time", subTitle: " ")
        
//        let currentDate = Date()
//        var dateComponents = DateComponents()
//        dateComponents.month = 1970
//        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
//        let datePicker = DatePickerDialog(textColor: .black,
//                                          buttonColor: .black,
//                                          font: UIFont.boldSystemFont(ofSize: 17),
//                                          showCancelButton: false)
//        datePicker.show("Choose Time",
//                        doneButtonTitle: "Done",
//                        minimumDate: threeMonthAgo,
//                        maximumDate: currentDate,
//                        datePickerMode: .time) { (date) in
//                            if let dt = date {
//                                let formatter = DateFormatter()
//                                formatter.dateFormat = "h:mm:ss a"
//                                let dateValue = formatter.string(from: dt)
//                                self.timeSelect =  dateValue
//                                self.tblView.reloadData()
//
//            }
//        }
    }
    
    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        
        guard let dateSelect = startDate  else {
            return self.showToast("Please Select Date")
        }
        guard let paymentMethod = payments else {
            return self.showToast("Please Select Payment")

        }
        guard let timeSelect = payments else {
             return self.showToast("Please Select Payment")
        }
        guard let addRess = addressSelect else {
            return self.showToast("Please Select Address")

        }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDPayNowVC") as? KDPayNowVC else {
           return
        }
        vc.combineDate = combineDate
        vc.payments = self.payments
        vc.timeSelect = timeSelect
        vc.numberOfDays = numberOFDays
        vc.tagsArray = tagsArray
        vc.addressSelect = addressSelect
        vc.coach = coach
        vc.finalEndDate = finalEndDate
        vc.finalStartate = finalStartate
        self.navigationController?.pushViewController(vc, animated: true)

    }
   
}

extension KDScheduleBookingVC  : UITableViewDelegate , UITableViewDataSource {
    
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
            cell.serviceTag.delegate = self
            return cell
      } else {
        
        let cell = tableView.dequeueReusableCell(with: DateAndPaymentCell.self, for: indexPath)
        cell.delegate = self
//        cell.btnChoseDate.addTarget(self, action: #selector(chooseStartDate), for: .touchUpInside)
        guard let _ = startDate else {
            return cell
        }
        
        
        let startDatess = startDate
        let endDatess = endDate
        combineDate = "\(startDatess!) , \(endDatess!)"
        cell.btnChoseDate.setTitle(combineDate, for: .normal)
//        guard let pay =  else {
//            return cell
//        }
        cell.btnChosePayment.setTitle(payments ?? "Choose payment method", for: .normal)
        
//        guard let time = timeSelect ?? " " else {
//                   return cell
//        }
        cell.btnChoseTime.setTitle(timeSelect ?? "Choose time available" , for: .normal)
        
//        guard let add = addressSelect ?? " " else {
//                   return cell
//        }
        cell.lblAddress.text = addressSelect ?? "No address addedd"

        return cell

     }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
                return 182.0
        } else if indexPath.section == 1 {
                return UITableView.automaticDimension
        } else {
                return 343.0
        }
    }
}

extension KDScheduleBookingVC : TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

extension KDScheduleBookingVC : PaymentCellDelegate {
    
    func choseDate(cell : DateAndPaymentCell) {
        self.chooseStartDate()
    }
    
    func chosePayment(cell : DateAndPaymentCell) {
      guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDSelectPaymentMethodVC") as? KDSelectPaymentMethodVC else {
         return
      }
      vc.delegate = self
      self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func chooseTimeAvailable(cell : DateAndPaymentCell) {
        self.choseTime()
    }
    
    func chooseAddress(cell : DateAndPaymentCell) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDAddressVC") as? KDAddressVC else {
           return
        }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)

    }

}

extension KDScheduleBookingVC : PassPaymethodMethodDelegate {
   
    func selctPayment(payment : String) {
        payments = payment
        tblView.reloadData()
    }

}

extension KDScheduleBookingVC : SelectAddressDelegate {
   
    func selectAddress(payment : String) {
        addressSelect = payment
        tblView.reloadData()
    }

}

extension Date {

    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
}

