//
//  Vendor.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 4/6/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import Foundation

struct Vendor: Entrant, Addressable {
    var firstName: String?
    var middleName: String?
    var lastName: String?
    let address: HomeAddress
    let company: VendorCompany
    let birthDate: Date
    let visitDate: Date
    
    enum VendorCompany {
        case acme, orkin, fedex, nwElectrical
    }
    
}
