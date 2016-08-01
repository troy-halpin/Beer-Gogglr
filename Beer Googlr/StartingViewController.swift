//
//  SoberViewController.swift
//  Beer Googlr
//
//  Created by TURANT Dagna on 31/03/16.
//  Copyright © 2016 GHT. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //if NSUserDefaults.standardUserDefaults().objectForKey("Name")==nil {
          //  performSegueWithIdentifier("registrationSegue", sender: self)
        //}
        self.view.backgroundColor = UIColor(red: 86/255.0, green: 77/255.0, blue: 68/255.0, alpha: 1)
    }
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().objectForKey("Preference")==nil {
          performSegueWithIdentifier("registrationSegue", sender: self)
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("BaselineDone")==nil {
            startButton.setImage(UIImage(named: "BASELINE.png"), forState: .Normal)
            //startButton.setTitle("Create Baseline", forState: .Normal)
        }
        else{
            startButton.setImage(UIImage(named: "SOBRIETY TEST.png"), forState: .Normal)
            //startButton.setTitle("Start Sobriety Test", forState: .Normal)
        }
    }
    
    @IBAction func resetButton(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "BaselineRates")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "BaselineDone")
        performSegueWithIdentifier("registrationSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startTest" {
            if let vc = segue.destinationViewController as?  RatingViewController{
                if NSUserDefaults.standardUserDefaults().objectForKey("BaselineDone")==nil {
                    vc.isBaseline = true
                }
                else{
                    vc.isBaseline = false
                }
            }
        }
    }
    
    @IBAction func n(sender: AnyObject) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishRegistrationSegueAction(segue: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func finishBaselineSegueAction(segue: UIStoryboardSegue)
    {
        
    }
 

}
