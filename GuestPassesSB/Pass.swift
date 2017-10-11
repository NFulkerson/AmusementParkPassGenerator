//
//  Pass.swift
//  GuestPasses
//
//  Created by Nathan on 7/4/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit
/// IDEA: Use pass to determine category, use category and subcategory in view controller to determine the entrant that needs to be created.
/// Embed entrant in pass,
///
/// Guests:
///   - classic: Basic Guest
///   - vip: Can skip lines, 10% food discount, 20% merch discount
///   - senior: Birthdate required, can skip lines. Must be 65 years or older.
///   - child: Birthdate required, must be under 5 to qualify
///   - seasonal: Can skip lines. Personal info required. VIP discounts.
/// Hourly Employees:
/// All hourly employees qualify for employee discounts.
///   - foodServices: Access to kitchen & amusement.
///   - rideServices: Access to ride controls & amusement.
///   - maintenanceServices: Access to all areas except office.
/// Contract Employees
/// - project1001: Amusement & Ride Control access.
/// - project1002: Amusement, Ride Control, & Maintenance access.
/// - project1003: Access to all areas.
/// - project2001: Office access.
/// - project2002: Kitchen & Maintenance access.
/// Vendors
/// - nwElectric: Access to all areas.
/// - acme: Kitchen access.
/// - orkin: Amusement, Ride Control, and Kitchen access.
/// - fedex: Office & Maintenance Access.
/// Managerial Staff
/// Managers have a discount of 25% on all items in the park.
/// - manager: Access to all areas.

struct Pass {
    let name: String?
    let passType: PassType
    var benefits: [String] = []
    let photo: UIImage?
    let owner: Entrant
    // Gives the pass the responsibility of describing what specific pass it is without
    // making it the responsibility of the View Controller.
    // This could be simplified by rewriting the Entrant protocol to have a `type` property
    // and conform all Entrants to it, or possibly by simply assigning a description when instantiating
    // the pass from the form.
    func passDescription() -> String {
        var description: String
        if self.owner is Guest {
            let guest = owner as! Guest
            description = guest.type.rawValue
        } else if self.owner is Employee {
            let employee = owner as! Employee
            description = employee.type.rawValue
        } else if self.owner is Contractor {
            let contract = owner as! Contractor
            description = "Contract Employee"
        } else if self.owner is Vendor {
            let vendor = owner as! Vendor
            description = vendor.company.rawValue
        } else {
            description = "Invalid Pass?"
        }
        return description
    }
    
    init(firstName: String? = nil, lastName: String? = nil, passType: PassType, photo: UIImage? = nil, owner: Entrant) {
        if let firstName = firstName, let lastName = lastName {
            self.name = "\(firstName) \(lastName)"
        } else {
            self.name = nil
        }
        self.passType = passType
        self.photo = photo
        self.owner = owner
        switch passType {
        case .guest:
            let guest = owner as! Guest
            if guest.canSkipLines {
                self.benefits.append("Can skip lines")
            }
            if guest.discounts.food > 0 {
                self.benefits.append("\(guest.discounts.food * 100)% discount on food")
            }
            if guest.discounts.merch > 0 {
                self.benefits.append("\(guest.discounts.merch * 100)% discount on merchandise")
            }
        case .employee:
            let employee = owner as! Employee
            if employee.discounts.food > 0 {
                self.benefits.append("\(employee.discounts.food * 100)% discount on food")
            }
            if employee.discounts.merch > 0 {
                self.benefits.append("\(employee.discounts.merch * 100)% discount on merchandise")
            }
        default:
            self.benefits = []
        }
    }
}

enum PassType: String {
    case guest = "Guest"
    case employee = "Employee"
    case manager = "Manager"
    case contract = "Contractor"
    case vendor = "Vendor"
    
    func getSubcategories() -> [String] {
        switch self {
        case .guest:
            return ["Classic", "VIP", "Senior", "Child", "Seasonal"]
        case .employee:
            return ["Food Services", "Ride Services", "Maintenance Services"]
        case .manager:
            return ["Shift", "General"]
        case .contract:
            return ["#1001", "#1002", "#1003", "#2001", "#2002"]
        case .vendor:
            return ["NW Electric", "Acme", "Orkin", "Fedex"]
        }
    }
    
    static func getSubcategories(for type: PassType) -> [String] {
        return type.getSubcategories()
    }
}
