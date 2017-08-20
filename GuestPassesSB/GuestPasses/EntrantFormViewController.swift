//
//  EntrantFormViewController.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 3/23/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//
// Entrant Form View is an implementation of Screen Mockup 1.

import UIKit

class EntrantFormViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        
        let topStackBgView = UIView()
        topStackBgView.backgroundColor = UIColor.CustomColor.Purple.light
        let entrantStack = createMenu()
        topStackBgView.addSubview(entrantStack)
        
        let bottomStackBgView = UIView()
        bottomStackBgView.backgroundColor = UIColor.CustomColor.Purple.dark
        let subMenuStack = createSubMenu()
        bottomStackBgView.addSubview(subMenuStack)
        
        let stackView = UIStackView(arrangedSubviews: [topStackBgView,bottomStackBgView])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        let bgView = UIView()
        view.addSubview(bgView)
        bgView.backgroundColor = UIColor.CustomColor.Gray.steel
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            entrantStack.bottomAnchor.constraint(equalTo: topStackBgView.layoutMarginsGuide.bottomAnchor, constant: 0.0),
            entrantStack.topAnchor.constraint(equalTo: topStackBgView.layoutMarginsGuide.topAnchor, constant: 0.0),
            entrantStack.trailingAnchor.constraint(equalTo: topStackBgView.layoutMarginsGuide.trailingAnchor, constant: -50.0),
            entrantStack.leadingAnchor.constraint(equalTo: topStackBgView.layoutMarginsGuide.leadingAnchor, constant: 50.0),
            subMenuStack.bottomAnchor.constraint(equalTo: bottomStackBgView.layoutMarginsGuide.bottomAnchor, constant: 0.0),
            subMenuStack.topAnchor.constraint(equalTo: bottomStackBgView.layoutMarginsGuide.topAnchor, constant: 0.0),
            subMenuStack.trailingAnchor.constraint(equalTo: bottomStackBgView.layoutMarginsGuide.trailingAnchor, constant: -100.0),
            subMenuStack.leadingAnchor.constraint(equalTo: bottomStackBgView.layoutMarginsGuide.leadingAnchor, constant: 100.0),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 150.0),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            bgView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0.0),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0)
        ])
    }
    
    func createMenu() -> UIStackView {
        let guestButton = UIButton(type: .custom)
        guestButton.setTitle("Guest", for: .normal)
        guestButton.setTitleColor(.white, for: .normal)
        guestButton.backgroundColor = .clear
        
        let employeeButton = UIButton(type: .custom)
        employeeButton.setTitle("Employee", for: .normal)
        employeeButton.setTitleColor(.white, for: .normal)
        employeeButton.backgroundColor = .clear
        
        let managerButton = UIButton(type: .custom)
        managerButton.setTitle("Manager", for: .normal)
        managerButton.setTitleColor(.white, for: .normal)
        managerButton.backgroundColor = .clear
        
        let vendorButton = UIButton(type: .custom)
        vendorButton.setTitle("Vendor", for: .normal)
        vendorButton.setTitleColor(.white, for: .normal)
        vendorButton.backgroundColor = .clear
        
        let entrantStack = UIStackView(arrangedSubviews: [guestButton, employeeButton, managerButton, vendorButton])
        entrantStack.axis = .horizontal
        entrantStack.distribution = .equalSpacing
        entrantStack.alignment = .center
        entrantStack.translatesAutoresizingMaskIntoConstraints = false
        
        return entrantStack
    }
    
    func createSubMenu() -> UIStackView {
        let childButton = UIButton(type: .custom)
        childButton.setTitleColor(.white, for: .normal)
        childButton.setTitle("Child", for: .normal)
        
        let adultButton = UIButton(type: .custom)
        adultButton.setTitle("Adult", for: .normal)
        adultButton.setTitleColor(.white, for: .normal)
        
        let vipButton = UIButton(type: .custom)
        vipButton.setTitleColor(.white, for: .normal)
        vipButton.setTitle("VIP", for: .normal)
        
        let seniorButton = UIButton(type: .custom)
        seniorButton.setTitleColor(.white, for: .normal)
        seniorButton.setTitle("Senior", for: .normal)
        
        let subStack = UIStackView(arrangedSubviews: [childButton, adultButton, seniorButton, vipButton])
        subStack.axis = .horizontal
        subStack.distribution = .equalSpacing
        subStack.alignment = .center
        subStack.translatesAutoresizingMaskIntoConstraints = false
        
        return subStack
        
    }
    
    
    
}
