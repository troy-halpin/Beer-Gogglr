//
//  RatingControl.swift
//  Beer Googlr
//
//  Created by GAPSA Mikolaj on 28/04/16.
//  Copyright © 2016 GHT. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    //Mark: Properties
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 10
    

    //MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<starCount {
        let button = UIButton()
            
        button.setImage(emptyStarImage, forState: .Normal)
        button.setImage(filledStarImage, forState: .Selected)
        button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
        button.adjustsImageWhenHighlighted = false
        
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
        
        ratingButtons += [button]
        addSubview(button)
        }
        
        
    }
    
    override func layoutSubviews() {
        
        let buttonSize = Int(frame.size.height)
        let buttonWidth = Int(frame.size.width)/starCount
        
        let dynamicSpacing = buttonWidth-buttonSize
        
        var correction = 0
        if dynamicSpacing < 0 {
            correction = dynamicSpacing
        }
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize+correction, height: buttonSize+correction)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + dynamicSpacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let buttonWidth = Int(frame.size.width)/starCount
        
        let dynamicSpacing = buttonWidth-buttonSize
        let width = (buttonSize * starCount) + (dynamicSpacing * (starCount - 1))
        
        var correction = 0
        if dynamicSpacing < 0 {
            correction = dynamicSpacing
        }
        
        return CGSize(width: width, height: buttonSize+correction)
    }
    
    func ratingButtonTapped(button: UIButton){
        if !needsInstruction {
            rating = ratingButtons.indexOf(button)! + 1
            updateButtonSelectionStates()
        }
    }
    
    func updateButtonSelectionStates(){
        for(index, button) in ratingButtons.enumerate() {
            //if the index of the button is less than the rating, that button should be selected
            button.selected = index < rating
        }
    }

}
