//
//  EntryError.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 12/22/16.
//  Copyright © 2016 Nathan Fulkerson. All rights reserved.
//

import Foundation


enum DOBError: Error {
    case dobInvalid(String)
    case dateConversionError(String)
}

enum AccessError: Error {
    case EntryNotPermitted
}

enum EntrantConversionError: Error {
    case UnidentifiableEntrant
}
