//
//  Contractor.swift
//  GuestPassesSB
//
//  Created by Nathan on 9/12/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit

struct Contractor: Entrant, Addressable {
    var firstName: String?
    var lastName: String?
    let address: HomeAddress
    let project: Project
    var fullName: String {
        guard let first = firstName, let last = lastName else {
            return ""
        }
        return "\(first) \(last)"
    }
    
    enum Project: String {
        case p1001 = "Project #1001"
        case p1002 = "Project #1002"
        case p1003 = "Project #1003"
        case p2001 = "Project #2001"
        case p2002 = "Project #2002"
    }

}
