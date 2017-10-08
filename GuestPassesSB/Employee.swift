//
//  Employee.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 3/24/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

/// Employee Type
///
/// - FoodServices: Represents kitchen and restaurant staff.
/// - RideServices: Represents ride operators.
/// - Maintenance: Represents maintenance workers.
/// - Manager: Represents managerial staff.
enum EmployeeType: String {
    case FoodServices = "Food Services"
    case RideServices = "Ride Services"
    case Maintenance = "Maintenance"
    case Manager = "Manager"
}

// This protocol is the base for all employees.
protocol Employable: Addressable {
    var type: EmployeeType { get }
}

struct Employee: Entrant, RideAccessible, Employable, DiscountQualifiable {
    
    var firstName: String?
    var lastName: String?
    var address: HomeAddress
    var type: EmployeeType
    var discounts: (food: PercentDiscount, merch: PercentDiscount) {
        switch self.type {
        case .FoodServices, .Maintenance, .RideServices:
            return (food: 0.15, merch: 0.25)
        case .Manager:
            return (food: 0.25, merch: 0.25)
        }
    }
    
    /// Convenience Init
    ///
    /// - Parameters:
    ///   - type: The type of employee (Food Service, Ride Service, Management, Maintenance)
    init(as type: EmployeeType, with firstName: String?, lastName: String?, address: HomeAddress) {
            self.firstName = firstName
            self.lastName = lastName
            self.address = address
            self.type = type
    }
}


