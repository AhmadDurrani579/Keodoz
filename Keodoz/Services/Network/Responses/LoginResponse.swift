//
//  LoginResponse.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 26/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import Foundation

struct LoginResponse: Response {
    var status: Bool?
    var code  : Int?
    var message: String?
    var data: Session?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case code  = "code"
        case data = "data"
        
    }
    
    func process() {
        guard let details = data else {
            return
        }
    }
}

struct login: Codable {
    
    var user: Session?
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
    }
    
}


struct Session: Codable {
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
    var token: String?

    
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
        case token = "token"

        
    }
    
}
