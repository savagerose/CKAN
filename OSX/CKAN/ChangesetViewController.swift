//
//  ChangesetViewController.swift
//  CKAN
//
//  Created by Calvin Mlynarczyk on 2015-11-18.
//  Copyright © 2015 KSP-CKAN. All rights reserved.
//

import Foundation
import AppKit

class ChangesetViewController: NSViewController, NSTableViewDataSource {
    var changeset: [CkanModule] {
        get {
            if let tabController = parentViewController as? NSTabViewController {
                if let manageMods = tabController.childViewControllers.filter({ viewController in
                        viewController is ManageModsViewController
                    }).first as? ManageModsViewController {
                        return manageMods.mods.filter({ mod in
                            mod.installed
                        })
                }
            }
            
            return []
        }
    }
    
    @objc func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return changeset.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let val = changeset[row]
        
        if let col = tableColumn?.headerCell.stringValue {
            switch col {
                case "Mod":
                    return "\(val.name) \(val.version)"
                case "Change":
                    if val.installed {
                        return "Install"
                    } else {
                        return "Remove"
                    }
                case "Reason for action":
                    return "Changed by user"
                default:
                    return nil
            }
        }
        
        return nil
    }
    
    func tableView(tableView: NSTableView, setObjectValue object: AnyObject?, forTableColumn tableColumn: NSTableColumn?, row: Int) {
        // This table is not editable by the user
    }
}
