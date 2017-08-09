//
//  Helpers.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 1/15/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct HomeAddress {
    let streetAddress: String
    let city: String
    let state: String
    
    init(street: String, city: String, state: String) throws {
        if street.isEmpty {
            throw AddressError.missingStreetAddress
        }
        if city.isEmpty {
            throw AddressError.missingCity
        }
        if state.isEmpty {
            throw AddressError.missingState
        }
        self.streetAddress = street
        self.city = city
        self.state = state
    }
    
    enum AddressError: Error {
        case missingStreetAddress, missingState, missingCity, missingZip
    }
}

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}
