//
//  ScoreViewController.swift
//  Beer Googlr
//
//  Created by TURANT Dagna on 31/03/16.
//  Copyright © 2016 GHT. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreTextView: UILabel!
    var score:Int?

    @IBOutlet weak var webview: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        var localfilePath = NSBundle.mainBundle().URLForResource("beerFull", withExtension: "html");

        
        switch score! {
            
        case Int.min..<0:
            
            scoreTextView.text = "you are sober as a gopher"
            
            print("you are sober as a gopher")
            
            localfilePath = NSBundle.mainBundle().URLForResource("beerEmpty", withExtension: "html");
            
            
        case 1...3: // (diff >= 1) && (diff <= 3)
            
            scoreTextView.text = "you are a little tipsy"
            
            print("you are a little tipsy")
            
            localfilePath = NSBundle.mainBundle().URLForResource("beerEmpty", withExtension: "html");
            
        case 4...7:
            
            scoreTextView.text = "you probably shouldn't drive"
            
            print("you probably shouldn't drive")
            
            localfilePath = NSBundle.mainBundle().URLForResource("beerHalf", withExtension: "html");
            
        case 8...11:
            
            scoreTextView.text = "you definitely can't drive, so why not have another"
            
            
            print("you can drink one more")

            
        case 12...16:
            
            scoreTextView.text = "drink your next one at your own risk"
            
            
            print("next one on your own responsibility")
            
 
        default:
            
            scoreTextView.text = "You are smashed"
            
            print("You are smashed")
            
            
        }
        
        print(String(score))
        
        let myRequest = NSURLRequest(URL: localfilePath!);
        
        webview.loadRequest(myRequest);
        
        self.view.backgroundColor = UIColor(red: 86/255.0, green: 77/255.0, blue: 68/255.0, alpha: 1)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showHomeAction(sender: AnyObject) {
        
        self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
