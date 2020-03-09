//
//  ServiceCoachResponse.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import Foundation
import UIKit

struct ServiceCoach : Response   {
    var status      : Bool?
    var message     : String?
    var code        : Int?
    var data        : [CoachList]?
    
    enum CodingKeys: String, CodingKey {
        case status         = "status"
        case message        = "message"
        case code            = "code"
        case data           = "data"
    }
    func process() {
    }
}
struct CoachList : Codable {
    
    var id                           : Int?
    var firstName                    : String?
    var lastName                     : String?
    var email                        : String?
    var profilePicture               : String?
    var accountType                  : String?
    var distance                     : String?
    var profilePictureLink           : String?
    var latitude                     : String?
    var longitude                    : String?
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

    var serviceDetail                : ServiceDetail?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case profilePicture = "profilePicture"
        case accountType = "accountType"
        case distance = "distance"
        case profilePictureLink = "profilePictureLink"
        case serviceDetail = "service_detail"
        
        case latitude = "latitude"
        case longitude = "longitude"
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

    }
}

struct ServiceDetail : Codable {
    
    var id                           : Int?
    var user_id                    : String?
    var serviceCategory_id                     : String?
    var name                        : String?
    var details                      : String?
    var individualService                  : String?
    var rateBasis                     : String?
    var rate                         : String?
    var serviceProvide               : String?
    var aboutUser                    : String?
    var serviceCategoryName           : String?
    var averageRating                : Int?
    var userReviewStatus             : Bool?
    var servicesPerform              : [ServiceProvide]?
    var reviewList                   : [ReviewOnService]?
    var userInfo                      : UserReviewOnService?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user_id = "user_id"
        case serviceCategory_id = "serviceCategory_id"
        case name = "name"
        case details = "details"
        case individualService = "individualService"
        case rateBasis = "rateBasis"
        case rate = "rate"
        case serviceProvide = "serviceProvide"
        case aboutUser = "aboutUser"
        case serviceCategoryName = "serviceCategoryName"
        case servicesPerform = "services"
        case averageRating   = "averageRating"
        case userReviewStatus   = "userReviewStatus"
        case reviewList         = "reviews"
        case userInfo         = "user"
    }
}

struct ServiceProvide : Codable {
    var name                    : String?
    
    enum CodingKeys: String, CodingKey {

        case name = "name"
    }
}

struct ReviewOnService  : Codable {
    var id                      : Int?
    var serviceDetail_id                      : String?
    var user_id                      : String?
    var rating                      : String?
    var review                      : String?
    var status                      : String?
    var userReview                      : UserReviewOnService?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case serviceDetail_id = "serviceDetail_id"
        case user_id = "user_id"
        case rating = "rating"
        case review = "review"
        case status = "status"
        case userReview = "review_by_user"
    }
}

struct UserReviewOnService : Codable {
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







