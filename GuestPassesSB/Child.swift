//
//  Child.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 3/24/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

/// - init: String in date format yyyy-MM-dd
struct Child: Entrant, RideAccessible, FreelyAdmissible {
    var birthDate: Date
    
    init(birthDate: String) throws {
        // Definitely not the right way to do it, but it'll do.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let bday = dateFormatter.date(from: birthDate) else {
            throw DOBError.dateConversionError("Couldn't create date from string.")
        }
        self.birthDate = bday
        
        if bday.age > 5 {
            throw DOBError.dobInvalid("Child is too old to qualify for free admission.")
        } else if bday.age < 0 {
            throw DOBError.dobInvalid("We don't need passes for children not born yet.")
        }
    }
}
