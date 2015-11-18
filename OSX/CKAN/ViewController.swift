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

class ManageModsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    let mods = [
        CkanModule(
            identifier: "FAR",
            name: "Ferram Aerospace Research",
            description: "Better aero",
            downloadUrl: NSURL(string: "https://github.com/ferram4/Ferram-Aerospace-Research")!,
            version: "3.0.15.1",
            licenses: ["GPL-3.0"],
            size: 4000,
            installed: false,
            update: false,
            contents: ["file/thing.png", "stuff/mod.txt"],
            status: "Stable",
            maxKSPVersion: "1.5",
            authors: ["ferram4"],
            externalResources: ExternalResources(
                repository: NSURL(string: "https://github.com/ferram4/Ferram-Aerospace-Research")!,
                homepage: nil,
                bugTracker: nil,
                kerbalstuff: nil)),
        CkanModule(
            identifier: "ModuleManager",
            name: "Module Manager",
            description: "Allow for extensibility of Kerbal Space Program by overwriting parts files in-memory",
            downloadUrl: NSURL(string: "https://github.com/sarbian/ModuleManager")!,
            version: "2.6.13",
            licenses: ["CC-SA"],
            size: 680,
            installed: true,
            update: false,
            contents: ["file/thing.png", "bin/modulemanager.dll"],
            status: "Stable",
            maxKSPVersion: "1.5",
            authors: ["sarbian"],
            externalResources: ExternalResources(
                repository: NSURL(string: "https://github.com/sarbian/ModuleManager")!,
                homepage: NSURL(string: "https://github.com/sarbian/ModuleManager"),
                bugTracker: nil,
                kerbalstuff: nil))
    ]
    
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
                case "Latest Version":
                    return val.version
                case "Max KSP Version":
                    return val.maxKSPVersion
                case "Download (KB)":
                    return "\(val.size)"
                case "Description":
                    return val.description
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
    
    @objc func tableViewSelectionDidChange(notification: NSNotification) {
        if let tableView = notification.object as? NSTableView {
            if tableView.selectedRow >= 0 {
                let modInfo = mods[tableView.selectedRow]
                
                if let modInfoViewController = childViewControllers.first as? ModInfoViewController {
                    modInfoViewController.setModInfo(modInfo)
                }
            }
        }
    }
    
}

class ModInfoViewController: NSTabViewController {
    func setModInfo(mod: CkanModule) {
        childViewControllers.forEach({ viewController in
            if let id = viewController.title {
                switch id {
                    case "Metadata":
                        setMetadataView(mod, viewController: viewController)
                    case "Content":
                        setContentsView(mod, viewController: viewController)
                    case "Relationships":
                        setRelationshipsView(mod, viewController: viewController)
                    default:
                        return
                }
            }
        })
    }
    
    func setMetadataView(mod: CkanModule, viewController: NSViewController) {
        let view = viewController.view
        
        if let titleLabel = view.viewWithTag(0) as? NSTextField {
            titleLabel.stringValue = mod.name
        }
        
        if let descriptionLabel = view.viewWithTag(1) as? NSTextField {
            descriptionLabel.stringValue = mod.description
        }
        
        if let detailsLabel = view.viewWithTag(2) as? NSTextField {
            var detailsString = "Version: \(mod.version)\n"
            
            if mod.licenses.count > 0 {
                detailsString += "License: \(mod.licenses.joinWithSeparator(", "))\n"
            }
            
            if let authors = mod.authors {
                if authors.count > 0 {
                    detailsString += "Author: \(authors.joinWithSeparator(", "))\n"
                }
            }
            
            if let homePage = mod.externalResources?.homepage {
                detailsString += "Home Page: \(homePage)\n"
            }
            
            if let repo = mod.externalResources?.repository {
                detailsString += "GitHub: \(repo)\n"
            }
            
            if let bugTracker = mod.externalResources?.bugTracker {
                detailsString += "Bug Tracker: \(bugTracker)\n"
            }
            
            if let kerbalStuff = mod.externalResources?.kerbalstuff {
                detailsString += "KerbalStuff: \(kerbalStuff)\n"
            }
            
            detailsString += "Release Status: \(mod.status)\nMaxVersion: \(mod.maxKSPVersion)\nIdentifier: \(mod.identifier)"
            
            detailsLabel.stringValue = detailsString
            detailsLabel.sizeToFit()
        }
    }
    
    func setContentsView(mod: CkanModule, viewController: NSViewController) {
        let outlineView = viewController.view.viewWithTag(1)
        
        mod.contents.forEach({ fileName in
            
        })
    }
    
    func setRelationshipsView(mod: CkanModule, viewController: NSViewController) {
        let outlineView = viewController.view.viewWithTag(1)
        
        mod.contents.forEach({ dependency in
            viewController.view.viewWithTag(1)
        })
    }
}

class ModRelationshipsViewController: NSObject, NSOutlineViewDataSource {
    var relationshipData: [String] = []
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        return relationshipData[index]
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        return relationshipData.count
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return relationshipData.count > 0
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        return relationshipData[0]
    }
}
