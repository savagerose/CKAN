//
//  ViewController.swift
//  CKAN
//
//  Created by Calvin Mlynarczyk on 2015-11-04.
//  Copyright © 2015 KSP-CKAN. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

class ManageModsViewController: NSViewController, NSTableViewDataSource {
    
    override func viewDidLoad() {
        
    }
    
    let mods = [ CkanModule(identifier: "FAR", name: "Ferram Aerospace Research", description: "Better aero", downloadUrl: NSURL(string: "https://github.com/ferram4/Ferram-Aerospace-Research")!, version: "3.0.15.1", licenses: ["GPL-3.0"], size: 4000, installed: true, update: false, authors: ["Ferram4"], externalResources: ExternalResources(repository: NSURL(string: "https://github.com/ferram4/Ferram-Aerospace-Research")!, homepage: nil, bugTracker: nil, kerbalstuff: nil)) ]
    
    @objc func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return mods.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let val = mods[row]
        
        if let col = tableColumn?.headerCell.stringValue {
            switch col {
                case "Installed":
                    return val.installed
                case "Update":
                    return val.update
                case "Name":
                    return val.name
                case "Author":
                    return val.authors?.joinWithSeparator(", ")
                case "Installed Version":
                    return val.version
                default:
                    return nil
            }
        }
        
        return nil
    }
    
    func tableView(tableView: NSTableView, setObjectValue object: AnyObject?, forTableColumn tableColumn: NSTableColumn?, row: Int) {
        let val = mods[row]
        
        if let newVal = object as? Bool, let col = tableColumn?.headerCell.stringValue {
            switch col {
                case "Installed":
                    val.installed = newVal
                case "Update":
                    val.update = newVal
                default:
                    return
            }
        }
    }
    
}
