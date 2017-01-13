//
//  ItemTableViewController.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/12/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    //MARK: Properties
    var items = [Item]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the initial data.
        loadInitialItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // I'll be updating this when I implement more than one table section <<<<<<<<<<<
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count // I'll be updating this, too <<<<<<<<<<
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and will be dequeued using a cell identifier.
        let cellIdentifier = "ItemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemTableViewCell else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }
        
        // Fetches the appropriate item and quantityImage for the data source layout.
        let qty1 = UIImage(named: "qty1")
        let qty2 = UIImage(named: "qty2")
        let qty3 = UIImage(named: "qty3")
        let qty4 = UIImage(named: "qty4")
        let qty5 = UIImage(named: "qty5")
        let qty6 = UIImage(named: "qty6")
        
        let item = items[indexPath.row]
        cell.itemNameLabel.text = item.name
        
        switch (item.quantity)
        {
        case 1:
            cell.qtyImageView.image = qty1
            
        case 2:
            cell.qtyImageView.image = qty2
            
        case 3:
            cell.qtyImageView.image = qty3
            
        case 4:
            cell.qtyImageView.image = qty4
        
        case 5:
            cell.qtyImageView.image = qty5
            
        case 6:
            cell.qtyImageView.image = qty6
            
        default:
            print("This default case is actually impossible based on the code in Item.swift")
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: Private Methods
    private func loadInitialItems() {
        guard let item1 = Item(name: "sweet italian creamer", quantity: 1, location: "1") else {
            fatalError("Unable to instantiate item1")
        }
        guard let item2 = Item(name: "juice", quantity: 2, location: "1") else {
            fatalError("Unable to instantiate item2")
        }
        guard let item3 = Item(name: "sour cream", quantity: 3, location: "1") else {
            fatalError("Unable to instantiate item3")
        }
        guard let item4 = Item(name: "top ramen", quantity: 4, location: "1") else {
            fatalError("Unable to instantiate item4")
        }
        guard let item5 = Item(name: "yogurt", quantity: 5, location: "1") else {
            fatalError("Unable to instantiate item5")
        }
        guard let item6 = Item(name: "hormel snacks", quantity: 6, location: "1") else {
            fatalError("Unable to instantiate item6")
        }
        
        items += [item1, item2, item3, item4, item5, item6]
    }


}