//
//  BusinessProtocols.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 1/15/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

/// This protocol defines free admittance to the park.
protocol FreelyAdmissible {
    // requires a birthdate, which we can check further to verify whether an entrant qualifies.
    var birthDate: Date { get }
}

// MARK: - Ride Privileges
protocol RideAccessible {
}

protocol LineSkippable {
}

// MARK: - Location Access
// How should these protocols be assigned to Employees?
protocol AmusementAccessible {
}

protocol KitchenAccessible {
}

protocol RideControlAccessible {
}

protocol MaintenanceAccessible {
}

protocol OfficeAccessible {
}

// MARK: - Merch
protocol DiscountQualifiable {
    var discounts: (food: PercentDiscount, merch: PercentDiscount) { get }
}

// These protocols loosely define different classes of people admitted entry to the park.


protocol Nameable {
    var firstName: String? { get set }
    var lastName: String? { get set }
}

enum NameError: Error {
    case invalidData
}


/// - name: requires a variable property of type Name
protocol Identifiable: Nameable {
}

/// This protocol defines personally identifiable information such as name and address.
protocol Addressable: Identifiable {
    var address: HomeAddress { get }
}
