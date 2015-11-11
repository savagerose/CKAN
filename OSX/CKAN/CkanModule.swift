//
//  CkanModule.swift
//  CKAN
//
//  Created by Calvin Mlynarczyk on 2015-11-07.
//  Copyright © 2015 KSP-CKAN. All rights reserved.
//

import Foundation

class CkanModule {
    let identifier: String
    let name: String
    let description: String
    let downloadUrl: NSURL
    let version: String
    let licenses: [String]
    let size: UInt32
    var installed: Bool
    var update: Bool
    let contents: [String]
    let authors: [String]?
    let externalResources: ExternalResources?
    
    init(identifier: String, name: String, description: String, downloadUrl: NSURL, version: String, licenses: [String], size: UInt32, installed: Bool, update: Bool, contents: [String], authors: [String]?, externalResources: ExternalResources?) {
        self.identifier = identifier
        self.name = name
        self.description = description
        self.downloadUrl = downloadUrl
        self.version = version
        self.licenses = licenses
        self.size = size
        self.installed = installed
        self.update = update
        self.contents = contents
        self.authors = authors
        self.externalResources = externalResources
    }
}

class ExternalResources {
    let repository: NSURL?
    let homepage: NSURL?
    let bugTracker: NSURL?
    let kerbalstuff: NSURL?
    
    init(repository: NSURL?, homepage: NSURL?, bugTracker:NSURL?, kerbalstuff: NSURL?) {
        self.repository = repository
        self.homepage = homepage
        self.bugTracker = bugTracker
        self.kerbalstuff = kerbalstuff
    }
}
