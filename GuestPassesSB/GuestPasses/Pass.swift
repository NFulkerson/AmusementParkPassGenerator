//
//  Pass.swift
//  GuestPasses
//
//  Created by Nathan on 7/4/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

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
    enum PassType {
        enum Guest: RideAccessible {
            case classic
            case vip
            case senior(firstName: String, lastName: String, birthday: Date)
            case child(Date)
            case seasonal
        }
    
        enum Employee {
            enum Hourly {
                case foodServices
                case rideServices
                case maintenanceServices
            }
            
            enum Contract: Int {
                case project1001 = 1001
                case project1002 = 1002
                case project1003 = 1003
                case project2001 = 2001
                case project2002 = 2002
            }
        }
        
        enum Vendor {
            case nwElectric
            case acme
            case orkin
            case fedex
        }
        
        enum Manager {
            case genersl
        }
    }
    var type: PassType
    
}
