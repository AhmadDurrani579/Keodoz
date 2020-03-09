//
//  KDBookingVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 01/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDBookingVC: UIViewController {
    
    @IBOutlet weak var tblViewss: UITableView!
    private var coachList : [CoachList] = []
    @IBOutlet var btnMenu: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        tblViewss.registerCells([BookingCell.self])
        loadBooking()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    
    }


    
    func loadBooking() {
        let endPoint = AuthEndpoint.getBookings
        let context = (self)
        showProgressIndicator(view: self.view)

        NetworkLayer.fetch(endPoint, with: ServiceCoach.self) {[weak self] (result) in
            switch result {
            case .success(let response):
                hideProgressIndicator(view: context.view)

                if response.status == true {
        
                    context.coachList = response.data ?? []
                    context.tblViewss.delegate = self
                    context.tblViewss.dataSource = self
                    context.tblViewss.reloadData()
        
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

extension KDBookingVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coachList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: BookingCell.self, for: indexPath)
        cell.setCellData(coach: coachList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDOrderEndVC") as? KDOrderEndVC else {
           return
        }
        vc.coach = coachList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
   


