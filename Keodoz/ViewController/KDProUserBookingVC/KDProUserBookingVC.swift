//
//  KDProUserBookingVC.swift
//  Keudoz
//
//  Created by Ahmed Durrani on 13/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDProUserBookingVC: UIViewController {
    @IBOutlet weak var tblViewss: UITableView!
    @IBOutlet var btnMenu: UIButton!
    private var ordeRList : [OrderList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        tblViewss.registerCells([MyBookingCell.self])
        loadOrderList()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.setNavigationBarHidden(true, animated: true)
       
       }

    func loadOrderList() {
        let endPoint = AuthEndpoint.orders
        let context = (self)
        showProgressIndicator(view: self.view)
        NetworkLayer.fetch(endPoint, with: Order.self) {[weak self] (result) in
        switch result {
         case .success(let response):
          hideProgressIndicator(view: context.view)

         if response.status == true {
          context.ordeRList = response.data ?? []
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

extension KDProUserBookingVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if  ordeRList.isEmpty == false {
            numOfSections = 1
            tblViewss.backgroundView = nil
        }  else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblViewss.bounds.size.width, height: tblViewss.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Booking ."
            noDataLabel.textColor = UIColor.lightGray
            noDataLabel.textAlignment = .center
            tblViewss.backgroundView = noDataLabel
            tblViewss.separatorStyle = .none
        }
        return numOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordeRList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MyBookingCell.self, for: indexPath)
        
        cell.setCellData(order: ordeRList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDAcceptBookingVC") as? KDAcceptBookingVC else {
            return
        }
        vc.coach = ordeRList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
   
