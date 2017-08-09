//
//  Kiosk.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 12/19/16.
//  Copyright © 2016 Nathan Fulkerson. All rights reserved.
//

import Foundation

enum KioskLocation {
    case Amusement
    case Kitchen
    case RideControl
    case Maintenance
    case Office
    case Restaurant
    case MerchBooth
}

enum DiscountAccessibleError: Error {
    case DiscountInaccessible
}

struct AccessControlList {
    private let types: [KioskLocation] = [.Amusement, .Kitchen, .RideControl,
                                  .Maintenance, .Office, .Restaurant, .MerchBooth]
    var rooms: [Kiosk] {
        return types.map(Kiosk.init)
    }
}

/// Kiosk is a simple struct representing a place of entry or a swipeable station. This is
/// what returns whether the entrant has sufficient permissions, and also represents the
/// tests conducted by the pass generator.
struct Kiosk {
    
    var location: KioskLocation
    
    func determinePermissions(for entrant: Entrant) -> Bool {
        switch location {
        case .Amusement:
            if entrant is Guest {
                let guest = entrant as! Guest
                if guest.type == .vip {
                    print("Guest is permitted to skip lines!")
                }
            }
            
            return entrant is RideAccessible
        
        case .Kitchen, .RideControl, .Maintenance, .Office:
            if entrant is Employee {
                let employee = entrant as! Employee
                switch employee.type {
                case .Manager:
                    // Managers are allowed access to any of these cases
                    // so we simply return true
                    return true
                case .Maintenance:
                    // These location checks are ugly, but it is seemingly the best way
                    // to check against these cases without having to repeat ourselves.
                    // However, this means we have to add more cases if this changes in any way.
                    if location != .Office {
                        return true
                    }
                case .FoodServices:
                    if location == .Kitchen {
                        return true
                    }
                case .RideServices:
                    if location == .RideControl {
                        return true
                    }
                }
            } else {
                return false
            }
        
        case .Restaurant, .MerchBooth:
            if entrant is DiscountQualifiable {
                print("Checking discounts.")
           
                var discount: (food: PercentDiscount, merch: PercentDiscount) = (food: 0.0, merch: 0.0)
                
                if let guest = entrant as? Guest {
                    discount = guest.discounts
                    
                } else if let employee = entrant as? Employee {
                    discount = employee.discounts
                }
               
                switch location {
                case .Restaurant:
                    print("Guest qualifies for \(discount.food * 100)% discount on food.")
                case .MerchBooth:
                    print("Guest qualifies for \(discount.merch * 100)% discount on merchandise.")
                default:
                    break
                }
                return true
            }
        }
        print("Doesn't qualify for discounts.")
        return false
    }
    
}
