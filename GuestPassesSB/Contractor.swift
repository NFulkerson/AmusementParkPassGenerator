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
        case p1001 = "#1001"
        case p1002 = "#1002"
        case p1003 = "#1003"
        case p2001 = "#2001"
        case p2002 = "#2002"
    }
    
    init(firstName: String, lastName: String, address: HomeAddress, project: String) throws {
        guard let projectType = Project(rawValue: project) else {
            throw EntrantConversionError.UnidentifiableEntrant("Could not identify project type.")
        }
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.project = projectType
    }

}
