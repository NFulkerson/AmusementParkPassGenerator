//
//  UIFormTextField.swift
//  GuestPassesSB
//
//  Created by Nathan on 9/11/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit

class UIFormTextField: UITextField, FieldValidatable {

    
    //[REVIEW] Delete code you don't use, even if it is commented out
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    //[REVIEW] isMandatory is a better name for a Bool
    var mandatory: Bool = false
    
    override var isEnabled: Bool {
        willSet {
            backgroundColor = newValue ? UIColor.white : UIColor.gray
        }
    }

}
