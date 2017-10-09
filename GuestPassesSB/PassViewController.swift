//
//  PassViewController.swift
//  GuestPassesSB
//
//  Created by Nathan on 8/31/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {
    
    @IBOutlet weak var passCardNameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var passBenefitsLabel: UILabel!
    @IBOutlet weak var testresultView: UIView!
    @IBOutlet weak var testResultLabel: UILabel!
    
    var pass: Pass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pass = pass else {
            let alert = UIAlertController(title: "Error", message: "Seems we couldn't load the pass data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let passName = pass.name ?? ""
        self.passCardNameLabel.text = passName
        self.passCardNameLabel.sizeToFit()
        self.passTypeLabel.text = pass.passDescription()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        self.pass = nil
    }

    @IBAction func testPermissions(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "Unknown")
        let buttonText = sender.titleLabel?.text ?? "Unknown"
        var kiosk: Kiosk
        guard let owner = pass?.owner else {
            let alert = UIAlertController(title: "Error", message: "Seems we couldn't load the pass data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        switch buttonText {
        case "Amusements":
            kiosk = Kiosk(location: .Amusement)
        case "Rides":
            kiosk = Kiosk(location: .RideAccess)
        case "Ride Control":
            kiosk = Kiosk(location: .RideControl)
        case "Discounts":
            kiosk = Kiosk(location: .MerchBooth)
        case "Kitchen":
            kiosk = Kiosk(location: .Kitchen)
        case "Maintenance":
            kiosk = Kiosk(location: .Maintenance)
        case "Office":
            kiosk = Kiosk(location: .Office)
        case "Skip Lines":
            if pass?.passDescription() == "VIP Pass" || pass?.passDescription() == "Season Pass" ||
                pass?.passDescription() == "Senior Pass" {
                displayTestResult(with: true)
                return
            } else {
                displayTestResult(with: false)
                return
            }
        default:
            testResultLabel.text = "Unknown Error"
            return
        }
        let result = owner.swipe(kiosk: kiosk)
        displayTestResult(with: result)
        
    }
    
    func displayTestResult(with result: Bool) {
        switch result {
        case true:
            testResultLabel.text = "Access Granted!"
            testresultView.backgroundColor = UIColor.green
        case false:
            testResultLabel.text = "Access Denied!"
            testresultView.backgroundColor = UIColor.red
        }
    }

}
