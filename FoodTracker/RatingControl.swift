//
//  RatingControl.swift
//  FoodTracker
//
//  Created by mrensel on 2/9/16.
//  Copyright © 2016 mti. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    //MARK: Properties
    let spacing = 5
    let stars = 5
    
    var buttonSize = Int()
    var rating = 0 {
        
        //        A property observer observes and responds to changes in a property’s value. Property observers are called every
        //        time a property’s value is set, and can be used to perform work immediately before or after the value changes.
        //        Specifically, the didSet property observer is called immediately after the property’s value is set. Here, you
        //        include a call to setNeedsLayout(), which will trigger a layout update every time the rating changes. This ensures
        //        that the UI is always showing an accurate representation of the rating property value.
        
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        
        //        Every UIView subclass that implements an initializer must include an implementation of init?(coder:).
        //        The Swift compiler knows this, and offers a fix-it to make this change in your code.
        super.init(coder: aDecoder)
        
        
        buttonSize = Int(frame.size.height)
        
        createButtons()

    }
    
    override func layoutSubviews() {
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        //The enumerate() method returns a collection that contains elements in the ratingButtons array paired with their indexes.
        //This is a collection of tuples—groupings of values—and in this case, each tuple contains an index and a button.
        for (index, button) in ratingButtons.enumerate() {
            
            //The frame locations are set equal to a standard button size of 44 points and 5 points of padding, multiplied by index.
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    //MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    //MARK: Helpers
    
    func createButtons() {
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        
        
        //        The half-open range operator (..<) doesn’t include the upper number, so this range goes from 0 to 4 for a
        //        total of five loop iterations, drawing five buttons instead of just one. The underscore (_) represents a
        //        wildcard, which you can use when you don’t need to know which iteration of the loop is currently executing.
        
        //create 5 buttons
        for _ in 0..<stars {
            
            //instantiates a button with params
            let button = UIButton()
            
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            //when button is both selected and highlighted (when button is mid tap)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            //        You’re attaching the action ratingButtonTapped: to the button object, which will be triggered whenever the .TouchDown event occurs.
            //        This event signifies that the user has pressed on a button. You set the target to self, which in this case is the RatingControl class,
            //        because that’s where the action is defined.
            
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            
            //add to our UIButton array
            ratingButtons += [button]
            
            //adds the button to the RatingControl sub view
            addSubview(button)
        }
    }
    
    func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerate() {
            button.selected = index < rating
        }
    }
}
