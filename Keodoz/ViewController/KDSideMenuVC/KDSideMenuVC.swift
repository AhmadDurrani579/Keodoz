//
//  KDSideMenuVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDSideMenuVC: UIViewController {
    @IBOutlet weak var tblViewss: UITableView!
    var sections = [
        SideMenu(titl: "My profile", icon: "icon_my_profile_green") ,
        SideMenu(titl: "Services", icon: "icon_orders_green") ,
        SideMenu(titl: "Bookings", icon: "icon_orders_green") ,
        SideMenu(titl: "Chats", icon: "icon_payments_green") ,
        SideMenu(titl: "Settings", icon: "icon_settings_green") ,
        SideMenu(titl: "Contact", icon: "icon_contact_green") ,
        SideMenu(titl: "Log out", icon: "icon_sign_in_up_green") ,
    ]
    
    var proUserSideMenu = [
        SideMenu(titl: "My profile", icon: "my profileee") ,
        SideMenu(titl: "My Bookings", icon: "my bookingsss") ,
        SideMenu(titl: "Chat", icon: "Shape") ,
        SideMenu(titl: "My Earning", icon: "my earningsss") ,
        SideMenu(titl: "Settings", icon: "settingsss") ,
        SideMenu(titl: "Contact", icon: "contactss") ,
        SideMenu(titl: "Log out", icon: "logouttt") ,
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let persistence = Persistence(with: .user)
        userObj  = persistence.load()

        tblViewss.registerCells([
            SideMenuCell.self
        ])

        tblViewss.delegate = self
        tblViewss.dataSource = self
        tblViewss.reloadData()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
}

extension KDSideMenuVC: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userObj?.accountStatus == "1" {
            return proUserSideMenu.count
        } else {
              return sections.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SideMenuCell.self, for: indexPath)
        if userObj?.accountStatus == "1" {
        cell.lblName.textColor = UIColor.black
        cell.lblName.text = proUserSideMenu[indexPath.row].titl
        let img = proUserSideMenu[indexPath.row].icon
        cell.imgOfSideMenu.image = UIImage(named: img)
        } else {
            cell.lblName.text = sections[indexPath.row].titl
            let img = sections[indexPath.row].icon
            cell.imgOfSideMenu.image = UIImage(named: img)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userObj?.accountType == "1" {
           if indexPath.row == 0 {
              let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
              let homeVC = storyboard.instantiateViewController(withIdentifier: "KDProUserProfileVC")
              sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
              sideMenuViewController?.hideMenuViewController()
           }
           else if indexPath.row == 1 {
              let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
              let homeVC = storyboard.instantiateViewController(withIdentifier: "KDProUserBookingVC")
              sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
              sideMenuViewController?.hideMenuViewController()
            }
            else if indexPath.row == 4 {
              let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
              let homeVC = storyboard.instantiateViewController(withIdentifier: "KDSettingVC")
              sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
              sideMenuViewController?.hideMenuViewController()
            }
            else if indexPath.row == 6 {
              let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
              Persistence.init(with: .user).delete()
              UIApplication.shared.keyWindow?.rootViewController = vc
            }
        }
        
        else {
        
            if indexPath.row == 0 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "KDProfileVC")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
            sideMenuViewController?.hideMenuViewController()

        }  else if indexPath.row == 1 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "KDSerciceListVC")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
            sideMenuViewController?.hideMenuViewController()

      } else if indexPath.row == 2 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "KDBookingVC")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
            sideMenuViewController?.hideMenuViewController()

      } else if indexPath.row == 4 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "KDSettingVC")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
            sideMenuViewController?.hideMenuViewController()

      } else if indexPath.row == 6 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            Persistence.init(with: .user).delete()
            UIApplication.shared.keyWindow?.rootViewController = vc
      }
     }
        
    }
}

