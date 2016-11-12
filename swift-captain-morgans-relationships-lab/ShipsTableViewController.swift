//
//  ShipsTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Douglas Galante on 11/12/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ShipsTableViewController: UITableViewController {
    
    let store = DataStore.sharedInstance
    
    var pirate: Pirate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pirate = pirate {
            if let ships = pirate.ships {
                store.ships = ships.allObjects as! [Ship]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.ships.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shipCell")
        cell?.textLabel?.text = store.ships[indexPath.row].name
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shipDetailSegue" {
            let destVC = segue.destination as! ShipDetailViewController
            let index = tableView.indexPathForSelectedRow?.row
            destVC.pirate = pirate
            if let index = index {
                destVC.ship = store.ships[index]
            }
        }
    }
}
