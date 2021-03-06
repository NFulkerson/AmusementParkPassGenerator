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
    case RideAccess
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
            if entrant is Guest || entrant is Employee {
                return true
            } else if entrant is Vendor {
                
                //[REVIEW] Never ever force unwrap optionals!!!
                
                if let vendor = entrant as? Vendor {
                    switch vendor.company {
                    case .acme, .fedex:
                        return false
                    case .nwElectrical, .orkin:
                        return true
                    }
                }
            } else if entrant is Contractor {
                let contract = entrant as! Contractor
                switch contract.project {
                case .p1001, .p1002, .p1003:
                    return true
                case .p2001, .p2002:
                    return false
                }
            }
        case .RideAccess:
            if entrant is Guest {
                let guest = entrant as! Guest
                if guest.canSkipLines {
                    print("You can skip lines!")
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
            } else if entrant is Contractor {
                let contractor = entrant as! Contractor
                switch contractor.project {
                case .p1001:
                    if location == .RideControl {
                        return true
                    }
                case .p1002:
                    if location == .RideControl || location == .Maintenance {
                        return true
                    }
                case .p1003:
                    return true
                case .p2001:
                    if location == .Office {
                        return true
                    }
                case .p2002:
                    if location == .Kitchen || location == .Maintenance {
                        return true
                    }
                }
            } else if entrant is Vendor {
                if let vendor = entrant as? Vendor {
                    switch vendor.company {
                    case .acme:
                        switch location {
                        case .Kitchen:
                            return true
                        default:
                            return false
                        }
                    case .fedex:
                        switch location {
                        case .Maintenance, .Office:
                            return true
                        default:
                            return false
                        }
                    case .nwElectrical:
                        return true
                    case .orkin:
                        switch location {
                        case .Amusement, .Kitchen, .RideControl:
                            return true
                        default:
                            return false
                        }
                    }
                }
                
            }
            else {
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
                if discount.food > 0 || discount.merch > 0 {
                    return true
                } else {
                    return false
                }
            }
        }
        print("Doesn't qualify for discounts.")
        return false
    }
    
}
