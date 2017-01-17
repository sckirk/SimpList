//
//  Section.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/16/17.
//  Copyright © 2017 SK. All rights reserved.
//

import Foundation

struct Section {
    
    var heading : String
    var items = [Item]()
    
    init(title: String, objects : [Item]) {
        heading = title
        items = objects
    }
    
}
