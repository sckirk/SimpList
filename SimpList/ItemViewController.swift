//
//  ItemViewController.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/9/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: Properties
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var qtySelector: QtySelector!
    @IBOutlet var pickerTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    // This value is either passed by `ItemTableViewController` in `prepare(for:sender:)` or constructed as part of adding a new item.
    var item: Item?
    
    // location options array--immutable
    let pickOption = ["health/bath", "toys/garden/home", "kitchen/crafts", "right grocery", "back right refrigerated", "left grocery", "back left refrigerated", "clothes/shoes", "natural section", "organic produce", "frozen"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        pickerTextField.inputView = pickerView

        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickOption[row]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: Actions


}

