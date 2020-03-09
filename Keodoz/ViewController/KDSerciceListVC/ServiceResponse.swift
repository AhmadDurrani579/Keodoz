//
//  ServiceResponse.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 24/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import Foundation
import UIKit


struct ServiceResponse : Response   {
    var status      : Bool?
    var message     : String?
    var code        : Int?
    var data        : [ServiceList]?
    
    enum CodingKeys: String, CodingKey {
        case status         = "status"
        case message        = "message"
        case code            = "code"
        case data           = "data"
    }
    
    func process() {
    }
}

struct ServiceList : Codable {
    
    var id                       : Int?
    var name                    : String?
    var image                  : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
    }
    
}

