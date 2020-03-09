//
//  KDSerciceListVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import Toast_Swift

class KDSerciceListVC: UIViewController {
    @IBOutlet weak var tblViewss: UITableView!
    private var serviceList: [ServiceList] = []
    @IBOutlet var btnMenu: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)

        tblViewss.registerCells([ServiceCell.self])
        loadServiceList()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    
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

extension KDSerciceListVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ServiceCell.self, for: indexPath)
        cell.setCellData(service: serviceList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 264.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDListCoachVC") as? KDListCoachVC else {
            return
        }
        vc.serviceSelect = serviceList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
   


