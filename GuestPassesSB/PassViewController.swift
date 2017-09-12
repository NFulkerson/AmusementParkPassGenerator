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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func testPermissions(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "Unknown")
        let buttonText = sender.titleLabel?.text ?? "Unknown"
        switch buttonText {
        case "Amusement Area Access":
            print("This will test Amusement access")
        case "Ride Access":
            print("This will test Ride access")
        case "Discount Access":
            print("This will test Discount access")
        case "Kitchen Access":
            print("This will test Kitchen access")
        case "Maintenance Access":
            print("This will test Maintenance access")
        case "Office Access":
            print("This will test Office access")
        default:
            testResultLabel.text = "Unknown Error"
        }
    }
    
    func displayTestResult() {
        
    }

}
