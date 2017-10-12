//
//  UIFormTextField.swift
//  GuestPassesSB
//
//  Created by Nathan on 9/11/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit

class UIFormTextField: UITextField, FieldValidatable {
    //[REVIEW] isMandatory is a better name for a Bool
    var isMandatory: Bool = false

    override var isEnabled: Bool {
        willSet {
            backgroundColor = newValue ? UIColor.white : UIColor.gray
        }
    }
}
