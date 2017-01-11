//
//  Item.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/11/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit

class Item {
    
    //MARK: Properties
    var name: String
    var quantity: Int
    var location: String
    
    
    
    //Initialization
    init?(name: String, quantity: Int, location: String) {
        
        // Initialization should fail if there is no name or location, or if the quantity is less than 1.
        if name.isEmpty || quantity < 1 || location.isEmpty  {
            return nil
        }
        
//        // The name must not be empty
//        guard !name.isEmpty else {
//            return nil
//        }
        
//        // The rating must be between 0 and 5 inclusively
//        guard (rating >= 0) && (rating <= 5) else {
//            return nil
//        }
        
        // Initialize stored properties.
        self.name = name
        self.quantity = quantity
        self.location = location
    }
}
