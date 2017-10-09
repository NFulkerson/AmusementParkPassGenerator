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
    
    init(firstName: String, lastName: String, address: HomeAddress, company: String, birthDate: String) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let companyId = VendorCompany(rawValue: company) else {
            throw EntrantConversionError.UnidentifiableEntrant("Could not identify vendor company.")
        }
        guard let dob = dateFormatter.date(from: birthDate) else {
            throw DOBError.dateConversionError("Could not convert date from string.")
        }
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.company = companyId
        self.birthDate = dob
        self.visitDate = Date()
    }
    
}
