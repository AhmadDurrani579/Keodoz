//
//  ProfileInfo.swift
//  Keudoz
//
//  Created by Ahmed Durrani on 14/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import Foundation

struct Profile : Response   {
    var status      : Bool?
    var message     : String?
    var code        : Int?
    var data        : UserInfo?
    
    enum CodingKeys: String, CodingKey {
        case status         = "status"
        case message        = "message"
        case code            = "code"
        case data           = "data"
    }
    func process() {
    }
}

struct UserInfo: Codable {
    var id : Int?
    var firstName: String?
    var lastName : String?
    var email: String?
    var profilePicture : String?
    var phoneNumber: String?
    var accountType : String?
    var accountStatus : String?
    var accountActivationStatus : String?
    var deviceToken : String?
    var latitude: String?
    var longitude: String?
    var userDetail : ServiceDetail?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case profilePicture = "profilePicture"
        case phoneNumber = "phoneNumber"
        case email = "email"
        case accountType = "accountType"
        case accountStatus = "accountStatus"
        case accountActivationStatus = "accountActivationStatus"
        case deviceToken = "deviceToken"
        case latitude = "latitude"
        case longitude = "longitude"
        case userDetail = "service_detail"
        
    }
    
}
