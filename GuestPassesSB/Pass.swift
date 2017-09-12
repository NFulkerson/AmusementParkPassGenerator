//
//  Pass.swift
//  GuestPasses
//
//  Created by Nathan on 7/4/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit

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
    let passType: String
    let benefits: String
    let photo: UIImage?
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
