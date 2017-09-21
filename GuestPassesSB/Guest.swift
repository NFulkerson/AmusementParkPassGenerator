//
//  Guest.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 3/24/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct Guest: Entrant, RideAccessible, DiscountQualifiable {
    var type: GuestType
    enum GuestType {
        case classic
        case vip
        case senior
        case seasonPass
    }
    var discounts: (food: PercentDiscount, merch: PercentDiscount) {
        switch self.type {
        case .classic:
            return (food: 0.0, merch: 0.0)
        case .vip:
            return (food: 0.10, merch: 0.20)
        case .senior:
            return (food: 0.10, merch: 0.10)
        case .seasonPass:
            return (food: 0.10, merch: 0.20)
        }
    }
}

struct Senior: Identifiable, LineSkippable {
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var birthDate: Date
    
    init(birthDate: String) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let bday = dateFormatter.date(from: birthDate) else {
            throw DOBError.dateConversionError("Couldn't create date from string.")
        }
        self.birthDate = bday
        
        if bday.age < 60 {
            throw DOBError.dobInvalid("Guest doesn't yet qualify for senior admission.")
        }
    }
}
