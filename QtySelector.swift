//
//  QtySelector.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/10/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit

@IBDesignable class QtySelector: UIStackView {
    
    //MARK: Properties
    private var quantityButtons = [UIButton]()
    
    var quantity = 1  // {
//        didSet {
//            updateButtonSelectionStates()
//        }
//    }
    
    @IBInspectable var qtySize: CGSize = CGSize(width: 46.6, height: 46.6) {
        didSet {
            setupButtons()
        }
    }

    @IBInspectable var qtyCount: Int = 6 {
        didSet {
            setupButtons()
        }
    }

    
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    
    
    //MARK: Button Action
    func quantityButtonTapped(button: UIButton) {
        print("button pressed!!!")
//        guard let index = ratingButtons.index(of: button) else {
//            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
//        }
//        
//        // Calculate the rating of the selected button
//        let selectedRating = index + 1
//        
//        if selectedRating == rating {
//            // If the selected star represents the current rating, reset the rating to 0.
//            rating = 0
//        } else {
//            // Otherwise set the rating to the selected star
//            rating = selectedRating
//        }
    }

    
    
    //MARK: Private Methods
    private func setupButtons() {
        
        // clear any existing buttons
        for button in quantityButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        quantityButtons.removeAll()

//        // Load Button Images
//        let bundle = Bundle(for: type(of: self))
//        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
//        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
//        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<qtyCount {
            // Create the button
            let button = UIButton()
            button.backgroundColor = UIColor.green
            
//            // Set the button images
//            button.setImage(emptyStar, for: .normal)
//            button.setImage(filledStar, for: .selected)
//            button.setImage(highlightedStar, for: .highlighted)
//            button.setImage(highlightedStar, for: [.highlighted, .selected])
        
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: qtySize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: qtySize.width).isActive = true
            
//            // Set the accessibility label
//            button.accessibilityLabel = "Set \(index + 1) star rating"
//            
            // Setup the button action
            button.addTarget(self, action: #selector(QtySelector.quantityButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the quantity button array
            quantityButtons.append(button)
        }
        
//        updateButtonSelectionStates()
        
        // print(ratingButtons)    // trying to debug if/why I only have 1 button instead of 5. And now it WORKS?! Why? Maybe I hadn't hit save or something like that prior to my earlier build... Xcode.
    }

   
}
