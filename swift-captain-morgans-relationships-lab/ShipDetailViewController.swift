//
//  ShipDetailViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Douglas Galante on 11/12/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ShipDetailViewController: UIViewController {
    
    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var pirateNameLabel: UILabel!
    @IBOutlet weak var propulsionTypeLabel: UILabel!
    
    let store = DataStore.sharedInstance
    
    var pirate: Pirate?
    var ship: Ship?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        shipNameLabel.text = ship?.name
        pirateNameLabel.text = pirate?.name
        propulsionTypeLabel.text = ship?.engines?.type
        
    }
    
}
