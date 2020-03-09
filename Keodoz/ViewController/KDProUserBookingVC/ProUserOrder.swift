//
//  ProUserOrder.swift
//  Keudoz
//
//  Created by Ahmed Durrani on 13/12/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import Foundation

struct Order : Response   {
    var status      : Bool?
    var message     : String?
    var code        : Int?
    var data        : [OrderList]?
    
    enum CodingKeys: String, CodingKey {
        case status         = "status"
        case message        = "message"
        case code            = "code"
        case data           = "data"
    }
    func process() {
    }
}

struct OrderList : Codable {
    
    var id                           : Int?
    var serviceDetail_id                    : String?
    var user_id                     : String?
    var serviceProvide                        : String?
    var startDate                    :  String?
    var endDate                      :  String?
    var time                         :  String?
    var address                      :  String?
    var noOfRateBasis                :  String?
    var paymentType                    :  String?
    var payment                    :  String?
    var tax                    :  String?
    var totalPayment                    :  String?
    var status                    :  String?
    var statusUpdatedAt           :  String?

    var ownerOrder                : UserOrder?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case serviceDetail_id = "serviceDetail_id"
        case user_id = "user_id"
        case serviceProvide = "serviceProvide"
        case startDate = "startDate"
        case endDate = "endDate"
        case time = "time"
        case address = "address"
        case noOfRateBasis = "noOfRateBasis"
        case paymentType = "paymentType"
        case payment = "payment"
        case tax = "tax"
        case totalPayment = "totalPayment"
        case status = "status"
        case ownerOrder = "user"

    }
}

struct UserOrder : Codable {
    var id                      : Int?
    var firstName                      : String?
    var lastName                      : String?
    var email                      : String?
    var profilePictureLink                      : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case profilePictureLink = "profilePictureLink"
    }
}





