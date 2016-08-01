//
//  ViewController.swift
//  Beer Googlr
//
//  Created by TURANT Dagna on 31/03/16.
//  Copyright © 2016 GHT. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    var gender = 0
    var preference = 0
    var genderChoice = false
    var attractChoice = false
    

    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var menButton: UIButton!
    @IBOutlet weak var womenButton: UIButton!

    @IBAction func maleClick(sender: AnyObject) {
        if(genderChoice == false){
            maleButton.setImage(UIImage(named: "MALE_SEL.png"), forState: .Normal)
        }
        else{
            maleButton.setImage(UIImage(named: "MALE_SEL.png"), forState: .Normal)
            femaleButton.setImage(UIImage(named: "FEMALE_DSE.png"), forState: .Normal)
        }
        gender = 0
        genderChoice = true
    }
    
    @IBAction func femaleClick(sender: AnyObject) {
        if(genderChoice == false){
            femaleButton.setImage(UIImage(named: "FEMALE_SEL.png"), forState: .Normal)
        }
        else{
            femaleButton.setImage(UIImage(named: "FEMALE_SEL.png"), forState: .Normal)
            maleButton.setImage(UIImage(named: "MALE_DSE.png"), forState: .Normal)
        }
        gender = 1
        genderChoice = true
    }
    
    @IBAction func menClick(sender: AnyObject) {
        menButton.setImage(UIImage(named: "MEN_SEL.png"), forState: .Normal)
        womenButton.setImage(UIImage(named: "WOMEN_DSE.png"), forState: .Normal)
        preference = 0
        attractChoice = true
    }
    
    @IBAction func womenClick(sender: AnyObject) {
        menButton.setImage(UIImage(named: "MEN_DSE.png"), forState: .Normal)
        womenButton.setImage(UIImage(named: "WOMEN_SEL.png"), forState: .Normal)
        preference = 1
        attractChoice = true
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if(attractChoice && genderChoice){
            defaults.setInteger(gender, forKey: "Gender")
            defaults.setInteger(preference, forKey: "Preference")
        }
    }
    
    //TODO: Add man and women icons and font and linkages
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //gogglesImage.image = UIImage(named: "logo.imageset/transparent_goggles")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

