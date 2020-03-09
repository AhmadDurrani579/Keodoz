//
//  KDServiceDetailVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import TagListView

class KDServiceDetailVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var coach : CoachList?
    var tagsArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.registerCells([KDServiceHeaderCellss.self , HeaderCellForServicesss.self , ServicesCollectionCellss.self , ReviewCell.self])
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 50.0
        tblView.rowHeight = UITableView.automaticDimension

        tblView.reloadData()
    }
    
    @IBAction private func btnBookNow_Pressed(_ sender : UIButton) {
        guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDBookNowVC") as? KDBookNowVC else {
            return
        }
        vc.coach = coach
        self.navigationController?.pushViewController(vc, animated: true)

    }

}

extension KDServiceDetailVC  : UITableViewDelegate , UITableViewDataSource {
    
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
            return self.coach?.serviceDetail?.reviewList?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(with: KDServiceHeaderCellss.self, for: indexPath)
            cell.setCellData(obj: coach!)
          return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(with: ServicesCollectionCellss.self, for: indexPath)
            if tagsArray.count != coach?.serviceDetail?.servicesPerform?.count {
                for (_ , service) in ((coach?.serviceDetail?.servicesPerform?.enumerated())!) {
                    cell.serviceTag.addTag(service.name!)
                    tagsArray.append(service.name!)
                }
            }
            cell.serviceTag.isUserInteractionEnabled = false
            cell.serviceTag.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(with: ReviewCell.self, for: indexPath)
            cell.setCellData(obj: (coach?.serviceDetail?.reviewList![indexPath.row])!)
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

extension KDServiceDetailVC : TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

