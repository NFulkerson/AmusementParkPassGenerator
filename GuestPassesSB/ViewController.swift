//
//  ViewController.swift
//  GuestPassesSB
//
//  Created by Nathan on 8/9/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
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
            if let selectedPassType = selectedPassType {
                enableFields(for: selectedPassType)
            }
        }
    }
    var pass: Pass?
    var passError: Error?
    
    // - MARK: Default Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the visibility of the submenu to 0 until the user has selected a parent category.
        subcategoryStackView.alpha = 0
        // - TODO: We don't truly need these defaults if the submenu is hidden, but removing it appears to break layout. Investigate.
        selectedPassType = PassType.guest
        let defaultSubMenu = selectedPassType?.getSubcategories()
        
        // set UITextFieldDelegate to the view controller so we can resign/close the keyboard.
        for field in formFields {
            field.delegate = self
        }
        
        clearSubMenuItems()
        if let defaultSubMenu = defaultSubMenu {
            for item in defaultSubMenu {
                let submenuButton = UIButton(type: .system)
                submenuButton.setTitle(item, for: .normal)
                styleThatButton(button: submenuButton)
            }
        }
    }
    
    // Reset textField background color, in case invalid fields have been fixed.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.white
    }
    
    // - MARK: IBActions
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        
        styleCategoryButtons(in: mainMenuUIButtons)
        styleActiveButton(button: sender)
        guard let buttonTitle = sender.currentTitle else {
            return
        }
        let passType = PassType(rawValue: buttonTitle)
        selectedPassType = passType
        // Clear subCategory to prevent unwanted/unexpected behavior.
        selectedSubcategory = nil
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
            //[REVIEW] always use [weak sel] or [unowned self] to prevent a retain cycle in closures
            //[AUTHOR] Sources here say that animate(withDuration:) will not create a retain cycle but it likely doesn't
            // hurt to be cautious: http://www.thomashanning.com/retain-cycles-weak-unowned-swift/
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                    self?.subcategoryStackView.alpha = 1
            })
        }
        clearFieldText()
    }
    
    func shouldGeneratePass() -> Bool {
        print("Generate pass tapped.")
        guard let passType = selectedPassType, let subType = selectedSubcategory else {
            displayAlert(with: "Error", message: "Please select a pass type and sub-type first.")
            return false
        }
        let result = submitForm()
        if result == false {
           return false
        }
        
        switch passType {
        case .guest:
            var guest: Guest?
            switch subType {
            case "Classic":
                do {
                    guest = try Guest(guestType: .classic)
                } catch {
                    displayAlert(with: "Error", message: "\(error)")
                }
            case "VIP":
                do {
                    guest = try Guest(guestType: .vip, firstName: firstNameField.text, lastName: lastNameField.text)
                } catch {
                    displayAlert(with: "Error", message: "\(error)")
                }
            case "Senior":
                do {
                    guest = try Guest(guestType: .senior, birthDate: dobField.text, firstName: firstNameField.text, lastName: lastNameField.text)
                } catch {
                    displayAlert(with: "Error", message: "\(error)")
                }
            case "Child":
                do {
                    guest = try Guest(guestType: .child, birthDate: dobField.text)
                } catch {
                    displayAlert(with: "Error", message: "\(error)")
                }
            case "Seasonal":
                do {
                    guest = try Guest(guestType: .seasonPass)
                } catch {
                    displayAlert(with: "Error", message: "\(error)")
                }
            default:
                displayAlert(with: "Error", message: "Could not create pass for Guest.")
                return false
            }
            
            guard let entrant = guest else {
                return false
            }
            if firstNameField.isEnabled && lastNameField.isEnabled {
                guard let firstName = firstNameField.text, let lastName = lastNameField.text else {
                    displayAlert(with: "Name Error", message: "Name field is empty or invalid.")
                    return false
                }
                self.pass = Pass(firstName: firstName, lastName: lastName, passType: .guest, photo: nil, owner: entrant)
            } else {
                self.pass = Pass(passType: .guest, owner: entrant)
            }
        case .employee:
            var employee: Employee
            var employeeType: EmployeeType
            guard let street = streetAddressField.text, let city = cityField.text, let state = stateField.text else {
                displayAlert(with: "Address Error", message: "Check the address fields and try again.")
                return false
            }
            
            switch subType {
            case "Food Services":
                employeeType = .FoodServices
            case "Ride Services":
                employeeType = .RideServices
            case "Maintenance Services":
                employeeType = .Maintenance
            default:
                displayAlert(with: "Employee Error", message: "Can't identify Employee classification.")
                return false
            }
            do {
                employee = try Employee(as: employeeType, with: firstNameField.text, lastName: lastNameField.text, address: HomeAddress(street: street, city: city, state: state))
            } catch {
                displayAlert(with: "Employee Error", message: error.localizedDescription)
                return false
            }
            self.pass = Pass(firstName: firstNameField.text, lastName: lastNameField.text, passType: .employee, owner: employee)
            
        case .contract:
            var contract: Contractor
            var address: HomeAddress
            guard let street = streetAddressField.text, let city = cityField.text, let state = stateField.text else {
                displayAlert(with: "Address Error", message: "Check the address fields and try again.")
                return false
            }
            do {
                address = try HomeAddress(street: street, city: city, state: state)
            } catch {
                displayAlert(with: "Address Error", message: "\(error)")
                return false
            }
            guard let firstName = firstNameField.text, let lastName = lastNameField.text else {
                displayAlert(with: "Name Error", message: "Name is missing or invalid.")
                return false
            }
            do {
                contract = try Contractor(firstName: firstName, lastName: lastName, address: address, project: subType)
                self.pass = Pass(firstName: firstName, lastName: lastName, passType: .contract, owner: contract)
            } catch {
                displayAlert(with: "Contractor Error", message: "\(error)")
                return false
            }
            
        case .manager:
            var address: HomeAddress
            var manager: Employee?
            guard let street = streetAddressField.text, let city = cityField.text, let state = stateField.text else {
                displayAlert(with: "Address Error", message: "Check the address fields and try again.")
                return false
            }
            do {
                address = try HomeAddress(street: street, city: city, state: state)
                manager = Employee(as: .Manager, with: firstNameField.text, lastName: lastNameField.text, address: address)
            } catch {
                displayAlert(with: "Error", message: "\(error)")
            }
            guard let entrant = manager else {
                return false
            }
            self.pass = Pass(firstName: firstNameField.text, lastName: lastNameField.text, passType: .manager, owner: entrant)
        
        case .vendor:
            guard let street = streetAddressField.text, let city = cityField.text, let state = stateField.text else {
                displayAlert(with: "Address Error", message: "Address is invalid. Check the address fields and try again.")
                return false
            }
            guard let firstName = firstNameField.text, let lastName = lastNameField.text else {
                displayAlert(with: "Name Error", message: "Name is invalid.")
                return false
            }
            guard let company = companyField.text, let dob = dobField.text else {
                displayAlert(with: "Missing value", message: "Check the required fields and try again.")
                return false
            }
            do {
                let address = try HomeAddress(street: street, city: city, state: state)
                let vendor = try Vendor(firstName: firstName, lastName: lastName, address: address, company: company, birthDate: dob)
                self.pass = Pass(firstName: vendor.firstName, lastName: vendor.lastName, passType: .vendor, owner: vendor)
            } catch {
                displayAlert(with: "Error", message: error.localizedDescription)
                return false
            }
            
        }
        if self.pass != nil {
            print("Data is ok, let's set it as true.")
            return true
        }
        print("Work done.")
        return false
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
    

    
    @IBAction func populateData(_ sender: Any) {
        guard let passType = selectedPassType, let subType = selectedSubcategory else {
            displayAlert(with: "Entrant Error", message: "Select a pass type and a sub-category first.")
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
            firstNameField.text = "Wile"
            lastNameField.text = "Coyote"
            streetAddressField.text = "1 Runner Road"
            cityField.text = "Acmeville"
            stateField.text = "New Mexico"
            zipField.text = "11122"
            companyField.text = subType
        }
    }
    
    // - MARK: Controller Methods
    // This determines whether the segue should be performed at all
    // And if the return value is true, will call prepare(for segue:)
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "generatePassViewSegue" {
            return shouldGeneratePass()
        } else {
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "generatePassViewSegue" {
            print("Going to segue to Pass View.")
            let passVC = segue.destination as! PassViewController
            passVC.pass = self.pass
            self.pass = nil
        }
    }
    
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
            throw EntrantConversionError.UnidentifiableEntrant("Could not identify sub-category.")
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
            button.setTitleColor(UIColor.CustomColor.Gray.muted, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
        }
    }
    
    // Couldn't get the date picker to play nicely in resigning the keyboard--I'm probably confused over where to send
    // the action. Meanwhile, I'm using an up-to-date version of the method found here:
    // http://roadfiresoftware.com/2015/01/the-easy-way-to-dismiss-the-ios-keyboard/
    //[REVIEW] Check out this WWDC video and the code, might help with the problem: https://developer.apple.com/videos/play/wwdc2017/242/
    
    @objc func finishPickingDate(sender: UIBarButtonItem) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    //[REVIEW] I don't think this function will ever work. You'd better switch on the entrant type and check for the proper text fields to have text, otherwise return false and show an alert
    //[REPLY] This will actually work, as another function modifies the isMandatory flag on the textField when a type is selected. However, it's still worth rewriting the implementation to simplify matters.
    func submitForm() -> Bool {
        var emptyFields: [UIFormTextField] = []
        
        for field in formFields {
            if let fieldEmpty = field.text?.isEmpty {
                if field.isEnabled && fieldEmpty {
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
    
    private func displayAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

