//
//  Entrant.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 12/12/16.
//  Copyright © 2016 Nathan Fulkerson. All rights reserved.
//

import Foundation

typealias PercentDiscount = Float

// Foresight was good: Vendors do not have ride access, so it's removed and granted to appropriate groups.
protocol Entrant {
    // All entrants can swipe a pass, whether guest or employee, so swipe resides here.
    func swipe(kiosk: Kiosk) -> Bool
}

extension Entrant {
    // TODO: Make a generic replacement instead?
    func swipe(kiosk: Kiosk) -> Bool {
        let accessGranted = kiosk.determinePermissions(for: self)
        if accessGranted {
            print("\(self): Access granted for \(kiosk.location)")
        } else {
            print("\(self): Access denied for \(kiosk.location)")
        }
        return accessGranted
    }
}

enum EntrantType {
    case Guest
    case Employee
    case Manager
    case Vendor
}




