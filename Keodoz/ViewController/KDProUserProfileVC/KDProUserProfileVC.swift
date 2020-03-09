//
//  KDProUserProfileVC.swift
//  Keudoz
//
//  Created by Ahmed Durrani on 13/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import TagListView

class KDProUserProfileVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var coach : UserInfo?
    var tagsArray : [String] = []
    @IBOutlet var btnMenu: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.registerCells([KDServiceHeaderCellss.self , HeaderCellForServicesss.self , ServicesCollectionCellss.self , ReviewCell.self])
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)

//        tblView.delegate = self
//        tblView.dataSource = self
        tblView.estimatedRowHeight = 50.0
        tblView.rowHeight = UITableView.automaticDimension
        loadProfile()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(true, animated: true)
          
    }
    
      func loadProfile() {
        let endPoint = AuthEndpoint.profile
        let context = (self)
        showProgressIndicator(view: self.view)
        NetworkLayer.fetch(endPoint, with: Profile.self) {[weak self] (result) in
        switch result {
         case .success(let response):
          hideProgressIndicator(view: context.view)
         if response.status == true {
          
          context.coach = response.data
              context.tblView.delegate = self
              context.tblView.dataSource = self
              context.tblView.reloadData()
          
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
    
    @IBAction private func btnEditPRofile_Pressed(_ sender : UIButton) {
        guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDProUserEditProfileVC") as? KDProUserEditProfileVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension KDProUserProfileVC  : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?   {
        if section == 0 {
            return nil
        } else if section == 1 {
            let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCellForServicesss") as! HeaderCellForServicesss
            headerCell.lblHeaderTitle.text = "Services"
            headerCell.btnEdit.isHidden = true
            return headerCell.contentView
        } else {
            let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCellForServicesss") as! HeaderCellForServicesss
             headerCell.lblHeaderTitle.text = "Reviews"
            headerCell.btnEdit.isHidden = false
            headerCell.btnEdit.setTitle("See All", for: .normal)
            return headerCell.contentView
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        else {
//            return self.coach?.serviceDetail?.reviewList?.count ?? 0
             return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(with: KDServiceHeaderCellss.self, for: indexPath)
            cell.setCellDataOrder(obj: coach!)
          return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(with: ServicesCollectionCellss.self, for: indexPath)
            if tagsArray.count != coach?.userDetail?.servicesPerform?.count {
                for (_ , service) in ((coach?.userDetail?.servicesPerform?.enumerated())!) {
                    cell.serviceTag.addTag(service.name!)
                    tagsArray.append(service.name!)
                }
            }
            cell.serviceTag.isUserInteractionEnabled = false
            cell.serviceTag.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(with: ReviewCell.self, for: indexPath)
//            cell.setCellData(obj: (coach?.serviceDetail?.reviewList![indexPath.row])!)
            return cell

        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 416.0
        } else {
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0 {
            return 0
        } else {
            return 50.0
        }
    }
}

extension KDProUserProfileVC : TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

