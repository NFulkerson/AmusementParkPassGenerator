//
//  ViewController.swift
//  GuestPassesSB
//
//  Created by Nathan on 8/9/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // - MARK: Outlets

    @IBOutlet var mainMenuUIButtons: [UIButton]!
    @IBOutlet var subMenuUIButtons: [UIButton]!
    @IBOutlet var formFields: [UIFormTextField]!
    
    @IBOutlet weak var dobField: UIFormTextField!
    @IBOutlet weak var ssnField: UIFormTextField!
    @IBOutlet weak var projectNoField: UIFormTextField!
    @IBOutlet weak var firstNameField: UIFormTextField!
    @IBOutlet weak var lastNameField: UIFormTextField!
    @IBOutlet weak var companyField: UIFormTextField!
    @IBOutlet weak var streetAddressField: UIFormTextField!
    @IBOutlet weak var cityField: UIFormTextField!
    @IBOutlet weak var stateField: UIFormTextField!
    @IBOutlet weak var zipField: UIFormTextField!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var subcategoryStackView: UIStackView!
    
    // - MARK: Properties
    
    var selectedPassType: PassType? {
        didSet {
            disableFields()
            enableFields(for: selectedPassType!)
        }
    }
    
    // - MARK: Default Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaultPassSelection = PassType.guest
        let defaultSubMenu = defaultPassSelection.getSubcategories()
        clearSubMenuItems()
        for item in defaultSubMenu {
            let submenuButton = UIButton(type: .system)
            submenuButton.setTitle(item, for: .normal)
            styleThatButton(button: submenuButton)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // - MARK: IBActions
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        for button in mainMenuUIButtons {
            print(button.titleLabel?.text ?? "Nothing")
            button.setTitleColor(UIColor.CustomColor.Gray.muted, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightSemibold)
        }
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        let passType = PassType(rawValue: sender.currentTitle!)
        selectedPassType = passType
        // Look into setting up a delegate to handle some of this behavior. Right now the view controller and Pass
        // both require some maintenance should things change
        let subCategories = passType?.getSubcategories()
        if let submenu = subCategories {
            clearSubMenuItems()
            for item in submenu {
                let submenuButton = UIButton(type: .system)
                submenuButton.setTitle(item, for: .normal)
                styleThatButton(button: submenuButton)
            }
        }
    }
    
    @IBAction func beganEditingDOBField(_ sender: UIFormTextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        sender.inputAccessoryView = toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishPickingDate(sender:)))
        toolbar.setItems([doneButton], animated: true)
        
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(updateDOBFieldValue(sender:)), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func populateData(_ sender: Any) {
        
    }
    
    // - MARK: Controller Methods
    
    func clearSubMenuItems() {
        let submenuViews = subcategoryStackView.arrangedSubviews
        for view in submenuViews {
            subcategoryStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func updateDOBFieldValue(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dobField.text = formatter.string(from: sender.date)
    }
    
    func finishPickingDate(sender: UIBarButtonItem){
    }
    
    func submitForm() -> Bool {
        var emptyFields: [UIFormTextField] = []
        
        for field in formFields {
            
            if let fieldEmpty = field.text?.isEmpty {
                if field.mandatory && fieldEmpty {
                    emptyFields.append(field)
                }
            }
        }
        if emptyFields.count > 0 {
            return false
        } else {
            return true
        }
    }
    
    // temporary
    func styleThatButton(button: UIButton) {
        button.setTitleColor(UIColor.CustomColor.Gray.muted, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightSemibold)
        subcategoryStackView.addArrangedSubview(button)
    }
    
    func enableFields(for entrant: PassType) {
        var fields: [UIFormTextField]
        switch entrant {
        case .guest:
            fields = [dobField, firstNameField]
        case .contract:
            fields = [firstNameField, lastNameField, projectNoField]
        case .employee:
            fields = [firstNameField, lastNameField, ssnField]
        case .manager:
            fields = [firstNameField, lastNameField, streetAddressField]
        case .vendor:
            fields = [firstNameField, lastNameField, stateField]
        }
        for field in fields {
            field.isEnabled = true
        }
    }
    
    func disableFields() {
        for field in formFields {
            field.isEnabled = false
        }
    }
    
}

