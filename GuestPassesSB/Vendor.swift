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
    
    enum VendorCompany: String {
        case acme = "Acme"
        case orkin = "Orkin"
        case fedex = "FedEx"
        case nwElectrical = "NW Electrical"
    }
    
}
