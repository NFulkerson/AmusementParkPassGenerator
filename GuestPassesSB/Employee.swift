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
enum EmployeeType {
    case FoodServices
    case RideServices
    case Maintenance
    case Manager
}

struct Employee: Entrant, RideAccessible, Employable, DiscountQualifiable {
    var firstName: String?
    var middleName: String?
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
    init(as type: EmployeeType, with firstName: String?, lastName: String?, address: HomeAddress) throws {
        do {
            
            try self.init(firstName: firstName, lastName: lastName)
            self.address = address
            self.type = type
            
            
        } catch let error {
            print(error)
            throw error
        }
        
    }
}
