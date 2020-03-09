//
//  AuthEndpoint.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 25/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import Foundation
import UIKit

enum AuthEndpoint : Endpoint {
    
    case login(email: String, password: String , deviceToken : String)
    case signUp(firstName : String , lastName : String , email: String, password: String, type : String ,  deviceType : String , deviceToken : String , latitude : String , longitude : String)
    
    case serviceCategories
    case coachList(serviceCategoryId : String , latitude : String , longitude : String)
    case getBookings
    case bookService(serviceId: String?  , serviceProvide : String? , startDate : String? , endDate : String?  , time: String? , services : String , address : String , noOfRateBasis : String , paymentType : String)
    case updateOrderStatus(orderId : String)
    case changePassword(changePass : String , retypePass : String)
    case updateProfilePic(image: Data)

    case profile
    case deactivatAccount
    case superMarket
    case shopping(superMarket: String , postalCode : String , shippingAddress : String , items : String)
    case orders
    case rating(recipeId : String , rating : String)

    var path: String {
        switch self {
        case .login(_,_ , _):
            return "login"
        case .signUp(_ , _ , _ , _ , _ , _ , _ , _ , _):
            return  "register"
        case .serviceCategories:
            return "service-categories"
        case .coachList(_ , _ , _):
            return "services"
        case .getBookings:
            return "getBookings"
        case .bookService(_ , _ , _ , _ , _ , _ , _ , _ , _):
            return "bookService"
        case .updateOrderStatus(_ ):
            return "updateOrderStatus"
        case .changePassword(_ , _) :
            return "change-password"
        case .profile:
            return "profile"
        case .deactivatAccount :
            return "deactive-account"
        case .superMarket :
            return "get-super-markets"
        case .shopping(_ , _ , _ , _) :
            return "shoping"
        case .orders :
             return "getOrders"
        case .rating(_ , _) :
             return "rating"
        case .updateProfilePic(_):
            return "update-profile-picture"
        }
        
        
        
    }

    var method: HTTPMethod {
        switch self {
        case .login(_,_ , _):
            return .post
        case .signUp (_ , _ , _ , _ , _ , _ , _ , _ , _):
            return .post
        case .serviceCategories:
            return .get
        case .coachList(_ , _ , _):
            return .get
        case .getBookings:
             return .get
        case .bookService(_ , _ , _ , _ , _ , _ , _ , _ , _):
            return .post
        case .updateOrderStatus(_) :
            return .post
        case .changePassword(_ , _):
            return .post
        case .profile:
            return .get
        case .deactivatAccount :
            return .post
        case .superMarket :
            return .get
        case .shopping(_ , _ , _ , _):
            return .post
        case .orders : 
            return .get
        case .rating(_ , _) :
            return .post
            
        case .updateProfilePic(_):
            return .post
        }
    }
    
    var contentType: HTTPContentType {
        switch self {
            case .updateProfilePic(_):
            return .multipart
        default:
            return .form
        }
    }

    var query: HTTPParameters {
        var query = HTTPParameters()
        switch self {
//        case .coachList(let serviceId , let lat , let lng):
//            query["serviceCategoryId"] = serviceId
//            query["latitude"] = lat
//            query["longitude"] = lng
       
        default:
            break
        }
        return query
    }

    var body: HTTPParameters {
        var body = HTTPParameters()
        
        switch self {
        case .login(let email, let password , let deviceToken):
            body["email"] = email
            body["password"] = password
            body["deviceToken"] = deviceToken
//            (firstName : String , lastName : String , email: String, password: String, type : String ,  deviceType : String , deviceToken : String , latitude : String , longitude : String)
        case .signUp(let firstName , let lastName , let email , let password , let type , let deviceType , let deviceToken ,  let latitude , let longitude):
            body["firstName"] = firstName
            body["lastName"] = lastName
            body["email"] = email
            body["password"] = password
            body["type"] = type
            body["deviceType"] = deviceType
            body["deviceToken"] = deviceToken
            body["latitude"] = latitude
            body["longitude"] = longitude
            
//            (serviceId: String?  , serviceProvide : String? , startDate : String? , endDate : String?  , time: String? , services : String , address : String , noOfRateBasis : String , paymentType : String)
        case .bookService(let serviceId , let serviceProvide , let startDate , let endDate , let time , let services , let address , let noOfRateBasis , let paymentType):
            
            body["serviceId"] = serviceId
            body["serviceProvide"] = serviceProvide
            body["startDate"] = startDate
            body["endDate"] = endDate
            body["time"] = time
            body["services"] = services
            body["address"] = address
            body["noOfRateBasis"] = noOfRateBasis
            body["paymentType"] = paymentType

            
        case .changePassword(let changePass , let retypePass) :
            body["newPassword"] = changePass
            body["confirmPassword"] = retypePass
        case .shopping(let superMarket, let postalCode , let shipingAddress , let itesm ):
            body["superMarket"] = superMarket
            body["postalCode"] = postalCode
            body["shippingAddress"] = shipingAddress
            body["items"]            = itesm
        case .rating(let recipeId  , let rating):
             body["recipeId"] = recipeId
             body["rating"]   = rating
            
        case .deactivatAccount :
            break
        default:
            break
        }
        return body
    }

    var multipart: [HTTPMultipart] {
        var multipart: [HTTPMultipart] = []
        switch self {
        case .updateProfilePic(let image) :
            multipart.append(HTTPMultipart(key: "profilePicture", filename: "profilePicture.png", data: image, mimeType: "image/png"))
        default:
            break
        }
        return multipart
    }
}

