//
//  ViewController.swift
//  GuestPassesSB
//
//  Created by Nathan on 8/9/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        }
    }
    
    var selectedSubcategory: String? {
        didSet {
            disableFields()
            enableFields(for: selectedPassType!)
        }
    }
    
    // - MARK: Default Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the visibility of the submenu to 0 until the user has selected a parent category.
        subcategoryStackView.alpha = 0
        // - TODO: May not be necessary.
        selectedPassType = PassType.guest
        let defaultSubMenu = selectedPassType!.getSubcategories()
        
        
        // set UITextFieldDelegate to the view controller so we can resign/close the keyboard.
        for field in formFields {
            field.delegate = self
        }
        
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
    
    // - MARK: Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // - TODO: Adjust implementation
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }

    // - MARK: IBActions
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        styleCategoryButtons(in: mainMenuUIButtons)
        styleActiveButton(button: sender)
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
                submenuButton.addTarget(self, action: #selector(subcategoryButtonTapped(_:)), for: .touchUpInside)
                styleThatButton(button: submenuButton)
                subMenuUIButtons.append(submenuButton)
            }
        }
        
        if subcategoryStackView.alpha == 0 {
            UIView.animate(withDuration: 1.0, animations: {
                self.subcategoryStackView.alpha = 1
            })
        }
        clearFieldText()
    }
    
    @IBAction func generatePassButtonTapped(_ sender: UIButton) {
        let dataIsValid = submitForm()
        if dataIsValid == true {
            //switch selectedPassType! {
            //case .guest:
                
            //case .employee:
            //case .contract:
            //case .manager:
            //case .vendor:
                
            //}
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
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(updateDOBFieldValue(sender:)), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func beganEditingProjectField(_ sender: UIFormTextField) {
        // - TODO: Implement
    }
    
    @IBAction func populateData(_ sender: Any) {
        guard let passType = selectedPassType, let subType = selectedSubcategory else {
            let alert = UIAlertController(title: "Error", message: "Please select a pass type and sub-type first.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        switch passType {
        case .employee, .contract, .manager:
            firstNameField.text = "Philip"
            lastNameField.text = "Fry"
            streetAddressField.text = "57th Street"
            cityField.text = "New New York"
            stateField.text = "New York"
            zipField.text = "10019"
            ssnField.text = "111-22-3333"
            if passType.rawValue == "Contractor" {
                projectNoField.text = subType
            }
        case .guest:
            switch subType {
            case "Classic", "VIP":
                return
            case "Senior":
                dobField.text = "03/19/1955"
                firstNameField.text = "Jane"
                lastNameField.text = "Doe"
            case "Child":
                dobField.text = "06/02/2014"
            case "Seasonal":
                firstNameField.text = "Arya"
                lastNameField.text = "Stark"
                streetAddressField.text = "2019 Winterfell Ave"
                cityField.text = "North"
                stateField.text = "Westeros"
                zipField.text = "11122"
            default:
                return
            }
        case .vendor:
            switch subType {
            case "NW Electric":
                companyField.text = "NW Electric"
            case "Acme":
                companyField.text = "Acme"
            case "Orkin":
                companyField.text = "Orkin"
            case "Fedex":
                companyField.text = "Fedex"
            default:
                return
            }
            firstNameField.text = "Wile"
            lastNameField.text = "Coyote"
            streetAddressField.text = "1 Runner Road"
            cityField.text = "Acmeville"
            stateField.text = "New Mexico"
            zipField.text = "11122"
        }
    }
    
    // - MARK: Controller Methods
    
    func clearSubMenuItems() {
        let submenuViews = subcategoryStackView.arrangedSubviews
        for view in submenuViews {
            subcategoryStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        subMenuUIButtons.removeAll()
    }
    
    @objc func updateDOBFieldValue(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
        dobField.text = formatter.string(from: sender.date)
    }
    
    @objc func subcategoryButtonTapped(_ sender: UIButton) throws {
        guard let subcategory = sender.titleLabel?.text else {
            throw EntrantConversionError.UnidentifiableEntrant
        }
        selectedSubcategory = subcategory
        styleCategoryButtons(in: subMenuUIButtons)
        styleActiveButton(button: sender)
        clearFieldText()
        print(subcategory)
    }
    
    private func clearFieldText() {
        for field in formFields {
            field.text = ""
        }
    }
    
    private func styleActiveButton(button: UIButton) {
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    private func styleCategoryButtons(in buttons: [UIButton]) {
        for button in buttons {
            print(button.titleLabel?.text ?? "Nothing")
            button.setTitleColor(UIColor.CustomColor.Gray.muted, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
        }
    }
    
    // Couldn't get the date picker to play nicely in resigning the keyboard--I'm probably confused over where to send
    // the action. Meanwhile, I'm using an up-to-date version of the method found here:
    // http://roadfiresoftware.com/2015/01/the-easy-way-to-dismiss-the-ios-keyboard/
    @objc func finishPickingDate(sender: UIBarButtonItem) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
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
            for field in emptyFields {
                field.backgroundColor = UIColor.red
            }
            return false
        } else {
            return true
        }
    }
    
    // temporary
    func styleThatButton(button: UIButton) {
        button.setTitleColor(UIColor.CustomColor.Gray.muted, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
        subcategoryStackView.addArrangedSubview(button)
    }
    
    func enableFields(for entrant: PassType) {
        var fields: [UIFormTextField] = []
        switch entrant {
        case .guest:
            if let subCategory = selectedSubcategory {
                switch subCategory {
                case "Child":
                    fields = [dobField]
                case "Senior":
                    fields = [firstNameField, lastNameField, dobField]
                case "Seasonal":
                    fields = [firstNameField, lastNameField, streetAddressField, cityField, stateField, zipField]
                default:
                    fields = []
                }
            }
        case .contract:
            fields = [firstNameField, lastNameField,
                      streetAddressField, cityField, stateField, zipField, projectNoField]
        case .employee, .manager:
            fields = [firstNameField, lastNameField,
                      streetAddressField, cityField, stateField, zipField, ssnField]
        case .vendor:
            // - TODO: Need to require/add a visit date?
            fields = [firstNameField, lastNameField, companyField, dobField]
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

