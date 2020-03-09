//
//  KDBookNowVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import TagListView

class KDBookNowVC: UIViewController {
    
    @IBOutlet var tblView: UITableView!
    var coach : CoachList?
    var tagsArray : [String] = []
    
    var selectTag : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.registerCells([BookServiceHeaderCell.self , ServicesCollectionCellss.self ])
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnNext_Pressed(_ sender : UIButton) {
//        selectTag
        if selectTag.count != 0 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDScheduleBookingVC") as? KDScheduleBookingVC else {
                return
            }
            vc.tagsArray = selectTag
            vc.coach = coach
            self.navigationController?.pushViewController(vc, animated: true )

        } else {
            self.showToast("Select Service")
        }
    }
    
}

extension KDBookNowVC  : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(with: BookServiceHeaderCell.self, for: indexPath)
            cell.setCellData(obj: coach!)
          return cell
        } else  {
            let cell = tableView.dequeueReusableCell(with: ServicesCollectionCellss.self, for: indexPath)
            if tagsArray.count != coach?.serviceDetail?.servicesPerform?.count {
                for (_ , service) in ((coach?.serviceDetail?.servicesPerform?.enumerated())!) {
                    cell.serviceTag.addTag(service.name!)
                    tagsArray.append(service.name!)
                }
            }
            cell.serviceTag.delegate = self
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 304.0
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension KDBookNowVC : TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
        if selectTag.contains(title) == true {
            selectTag = selectTag.filter{$0 != title}

        } else {
            selectTag.append(title)
        }
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

