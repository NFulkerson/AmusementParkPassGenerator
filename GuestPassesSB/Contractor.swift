//
//  Contractor.swift
//  GuestPassesSB
//
//  Created by Nathan on 9/12/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct Contractor: Addressable {
    var firstName: String?
    var middleName: String?
    var lastName: String?
    let address: HomeAddress
    
    enum Project {
        case p1001
        case p1002
        case p1003
        case p2001
        case p2002
    }
}
