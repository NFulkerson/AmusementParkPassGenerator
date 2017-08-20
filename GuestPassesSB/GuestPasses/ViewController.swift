//
//  ViewController.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 12/12/16.
//  Copyright © 2016 Nathan Fulkerson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rooms = AccessControlList().rooms
        let guest = Guest(type: .vip)
        checkPermissions(for: guest, in: rooms)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkPermissions(for entrant: Entrant, in rooms: [Kiosk]) {
        for kiosk in rooms {
            print("Swiping access for \(kiosk.location)")
            print(entrant.swipe(kiosk: kiosk))
        }
    }
    
}

