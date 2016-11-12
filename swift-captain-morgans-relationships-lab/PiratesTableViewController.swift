//
//  PiratesTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Douglas Galante on 11/12/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class PiratesTableViewController: UITableViewController {
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if store.pirates.isEmpty {
            store.generateTestData()
        }
        
        store.fetchData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.pirates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pirateCell")
        
        cell?.textLabel?.text = store.pirates[indexPath.row].name
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shipsSegue" {
            let destVC = segue.destination as! ShipsTableViewController
            let index = tableView.indexPathForSelectedRow?.row
            if let index = index {
                destVC.pirate = store.pirates[index]
            }
            
        }
    }
    
    
}
