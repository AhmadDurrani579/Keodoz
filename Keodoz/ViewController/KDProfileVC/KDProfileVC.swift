//
//  KDProfileVC.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 01/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit

class KDProfileVC: UIViewController {
    
    let photo = PhotoPicker()
    
    @IBOutlet weak var imageOFUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet var btnMenu: UIButton!
    var cover_image: UIImage?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMenu.addTarget(send, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)

        let persistence = Persistence(with: .user)
        userObj  = persistence.load()
        
        let firstName = userObj?.firstName
        let lastName = userObj?.lastName

        lblAddress.text = "Romania"
        lblName.text = "\(firstName!) \(lastName!)"
        txtFirstName.text = firstName!
        txtLastName.text = lastName!
        txtEmail.text = userObj?.email
        txtPhoneNum.text = userObj?.phoneNumber
        
        guard let img = userObj?.profilePicture else {
            return
        }
        
        imageOFUser.setImage(with: img, placeholder: UIImage(named: "Profile_image"))
        let cgFloat: CGFloat = imageOFUser.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(imageOFUser, radius: CGFloat(someFloat))

        
        
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction private func btnChooseImage_Pressed(_ sender : UIButton) {
        photo.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) {[weak self] (orignal, edited) in
            self!.imageOFUser.image = orignal
            showProgressIndicator(view: self!.view)
            guard let data = self!.imageOFUser.image?.pngData() else {
                return
            }
            let persistence = Persistence(with: .user)
            let context = (self)

            let endPoint = AuthEndpoint.updateProfilePic(image: data)
            NetworkLayer.fetch(endPoint, with: LoginResponse.self) { (result) in
                switch result {
                case .success(let response):
                    hideProgressIndicator(view: context!.view)

                    if response.status == true {
                        persistence.save(response.data)
                        context?.showToast(response.message)
                    } else {
                        context?.showToast(response.message)

                        print("Some thing wrong")
                                
                    }
                case .failure(let error): break
                    context?.showToast(error.localizedDescription)
                    print("Some thing wrong")
                }
            //            context?.didFailSignUp(with: "")
            //            print("Some thing wrong")
                }
            
            let cgFloat: CGFloat = self!.imageOFUser.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self!.imageOFUser, radius: CGFloat(someFloat))
            self!.cover_image = orignal
        }
    }
    
}
