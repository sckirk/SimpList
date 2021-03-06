//
//  SectionsData.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/16/17.
//  Copyright © 2017 SK. All rights reserved.
//

import Foundation

class SectionsData {
    func getSectionsFromData() -> [Section] {
        var sectionsArray = [Section]()
        
        let health = Section(title: "health/bath", objects: [])
        sectionsArray.append(health)
        
        let toys = Section(title: "toys/garden/home", objects: [Item(name: "look at shopkins with Caris", quantity: 1, location: "toys/garden/home")!])
        sectionsArray.append(toys)
        
        let kitchen = Section(title: "kitchen/crafts", objects: [])
        sectionsArray.append(kitchen)
        
        let rightGroc = Section(title: "right grocery", objects: [Item(name: "frosted mini wheats", quantity: 1, location: "right grocery")!, Item(name: "triscuits", quantity: 2, location: "right grocery")!, Item(name: "cookies", quantity: 1, location: "right grocery")!, Item(name: "org green beans", quantity: 2, location: "right grocery")!, Item(name: "soup", quantity: 3, location: "right grocery")!, Item(name: "top ramen", quantity: 4, location: "right grocery")!, Item(name: "tuna", quantity: 3, location: "right grocery")!, Item(name: "hash", quantity: 2, location: "right grocery")!, Item(name: "spam", quantity: 2, location: "right grocery")!])
        sectionsArray.append(rightGroc)
        
        let rightRef = Section(title: "back right refrigerated", objects: [Item(name: "creamer", quantity: 1, location: "back right refrigerated")!, Item(name: "juice", quantity: 1, location: "back right refrigerated")!, Item(name: "tillamook yogurt", quantity: 5, location: "back right refrigerated")!])
        sectionsArray.append(rightRef)
        
        let leftGroc = Section(title: "left grocery", objects: [Item(name: "gatorade pack", quantity: 1, location: "left grocery")!])
        sectionsArray.append(leftGroc)
        
        let leftRef = Section(title: "back left refrigerated", objects: [Item(name: "hormel wraps", quantity: 5, location: "back left refrigerated")!, Item(name: "lunchables", quantity: 2, location: "back left refrigerated")!, Item(name: "natural lunch meat", quantity: 1, location: "back left refrigerated")!, Item(name: "bacon", quantity: 1, location: "back left refrigerated")!, Item(name: "organic meat", quantity: 1, location: "back left refrigerated")!])
        sectionsArray.append(leftRef)
        
        let clothes = Section(title: "clothes/shoes", objects: [])
        sectionsArray.append(clothes)
        
        let natural = Section(title: "natural section", objects: [Item(name: "organic whole milk", quantity: 1, location: "natural section")!, Item(name: "bulk chili powder", quantity: 1, location: "natural section")!, Item(name: "bread", quantity: 1, location: "natural section")!, Item(name: "bagels", quantity: 1, location: "natural section")!])
        sectionsArray.append(natural)
        
        let organic = Section(title: "organic produce", objects: [Item(name: "green superfood", quantity: 1, location: "organic produce")!, Item(name: "odwalla protein", quantity: 5, location: "organic produce")!, Item(name: "bananas", quantity: 5, location: "organic produce")!, Item(name: "kale", quantity: 1, location: "organic produce")!, Item(name: "collard greens", quantity: 1, location: "organic produce")!, Item(name: "garlic", quantity: 1, location: "organic produce")!])
        sectionsArray.append(organic)
        
        let frozen = Section(title: "frozen", objects: [Item(name: "pizza", quantity: 1, location: "frozen")!, Item(name: "meat - stir fry", quantity: 1, location: "frozen")!])
        sectionsArray.append(frozen)
        
        let checkout = Section(title: "time to checkout", objects: [Item(name: "say 'hi' to Elizabeth!", quantity: 1, location: "time to checkout")!])
        sectionsArray.append(checkout)
    
        return sectionsArray
    
    }
}
