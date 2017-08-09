//
//  Contractor.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 5/8/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct Contractor: Employable {
    var firstName: String?
    var middleName: String?
    var lastName: String?
    let address: HomeAddress
    var type: EmployeeType
    
    enum Project {
        case p1001
        case p1002
        case p1003
        case p2001
        case p2002
    }
}
