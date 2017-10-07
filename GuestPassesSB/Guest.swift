//
//  Guest.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 3/24/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct Guest: Entrant, RideAccessible, DiscountQualifiable {
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var birthDate: Date?
    var type: GuestType
    
    enum GuestType {
        case classic
        case vip
        case senior
        case seasonPass
        case child
    }
    
    var discounts: (food: PercentDiscount, merch: PercentDiscount) {
        switch self.type {
        case .classic, .child:
            return (food: 0.0, merch: 0.0)
        case .vip:
            return (food: 0.10, merch: 0.20)
        case .senior:
            return (food: 0.10, merch: 0.10)
        case .seasonPass:
            return (food: 0.10, merch: 0.20)
        }
    }
    
    init(guestType: GuestType, birthDate: String? = nil) throws {
        switch guestType {
        case .child, .senior:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            guard let dob = birthDate ,let bday = dateFormatter.date(from: dob) else {
                throw DOBError.dateConversionError("Couldn't create date from string.")
            }
            if guestType == .senior && bday.age < 60 {
                throw DOBError.dobInvalid("Guest doesn't yet qualify for senior admission.")
            } else if guestType == .child && bday.age > 5 {
                throw DOBError.dobInvalid("Child is too old to qualify for free admission.")
            } else if guestType == .child && bday.age < 0 {
                throw DOBError.dobInvalid("We don't need passes for children not born yet.")
            }
            
            self.birthDate = bday
            self.type = guestType
        default:
            self.type = guestType
        }
    }
    
}

