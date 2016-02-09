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
    
    var rating = 0
    var ratingButtons = [UIButton]()
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        
        //        Every UIView subclass that implements an initializer must include an implementation of init?(coder:).
        //        The Swift compiler knows this, and offers a fix-it to make this change in your code.
        super.init(coder: aDecoder)
        
        //        The half-open range operator (..<) doesn’t include the upper number, so this range goes from 0 to 4 for a
        //        total of five loop iterations, drawing five buttons instead of just one. The underscore (_) represents a
        //        wildcard, which you can use when you don’t need to know which iteration of the loop is currently executing.
        
        //create 5 buttons
        for _ in 0..<5 {
            
            //instantiates a button with params
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            
            //sets button background color
            button.backgroundColor = UIColor.redColor()
            
            
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
    
    override func layoutSubviews() {
        var buttonFrame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        for (index, button) in ratingButtons.enumerate() {
            
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 240, height: 44)
    }
    
    //MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        print("button pressed!")
    }
}
