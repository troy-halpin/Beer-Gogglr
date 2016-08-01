//
//  RatingViewController.swift
//  Beer Googlr
//
//  Created by TURANT Dagna on 31/03/16.
//  Copyright © 2016 GHT. All rights reserved.
//

//All images and videos on Pixabay are released free of copyrights under Creative Commons CC0.

extension CollectionType{
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int{
    mutating func shuffleInPlace(){
        if count < 2 { return }
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

var needsInstruction = true

import UIKit

class RatingViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var instructionText: UILabel!
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet weak var instructionImg: UIImageView!
    @IBOutlet weak var instructionView: UIView!
    
    
    
    var isBaseline:Bool?
    
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    var folderName = "women/"
    var picName = "w"
    //List of images
    var imageList:[String] = []
    var imageIndex = 0
    var imageLength : Int {
        return imageList.count
    }
    let drunkImageCount = 10
    //List of images while doing drunk test
    var imageDrunkList = [Int](count: 25, repeatedValue: 0)
    //List of rates when u do drunk test
    var drunkRatingList = [0] //= [Int](count: drunkImageCount, repeatedValue: 0)
    //Reference to Core data to store baseline notes
    var baselineRatingList = [Int](count: 25, repeatedValue: 0)

    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        needsInstruction = isBaseline!
        
        if NSUserDefaults.standardUserDefaults().objectForKey("Preference") != nil {
            if NSUserDefaults.standardUserDefaults().integerForKey("Preference") == 0 {
                folderName = "men/"
                picName = "m"
            }
        }
        
        for i in 0 ..< 25 {
            imageList.append(picName + String(i) + ".jpg")
            print(imageList[i])
        }
        
        
        drunkRatingList = [Int](count: drunkImageCount, repeatedValue: 0)
        
        // Do any additional setup after loading the view.
        if !isBaseline!{
            for i in 0 ..< 25 {
                imageDrunkList[i]=i
            }
            imageDrunkList.shuffleInPlace()
            
            if NSUserDefaults.standardUserDefaults().objectForKey("BaselineRates") != nil {
                baselineRatingList = NSUserDefaults.standardUserDefaults().objectForKey("BaselineRates") as! [Int]
            }
        }
        
        if(isBaseline!){
            personImage.image = UIImage(named: folderName + imageList[imageIndex])
        }
        else{
            personImage.image = UIImage(named: folderName + imageList[imageDrunkList[imageIndex]])
        }
        
        //personImage.image = UIImage(named: "w0")
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction=UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeLeft.direction=UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(tap)
        
        finishButton.hidden = true
        
        progressView.progress = 0.0
        
        self.view.backgroundColor = UIColor(red: 86/255.0, green: 77/255.0, blue: 68/255.0, alpha: 1)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (needsInstruction) {
            instructionView.backgroundColor = UIColor(red: 86/255.0, green: 77/255.0, blue: 68/255.0, alpha: 1)
            instructionView.hidden = false
            instructionImg.hidden = false
            instructionButton.hidden = false
            instructionText.hidden = false
            
            
            self.view.backgroundColor = UIColor(red: 86/255.0, green: 77/255.0, blue: 68/255.0, alpha: 0.5)
            finishButton.alpha = 0.5
            personImage.alpha = 0.5
            progressView.alpha = 0.5
            ratingControl.alpha = 0.5
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func instructionFinishBtn(sender: AnyObject) {
        instructionView.hidden = true
        instructionImg.hidden = true
        instructionButton.hidden = true
        instructionText.hidden = true
        needsInstruction = false
        
        self.view.backgroundColor = UIColor(red: 86/255.0, green: 77/255.0, blue: 68/255.0, alpha: 1)
        finishButton.alpha = 1
        personImage.alpha = 1
        progressView.alpha = 1
        ratingControl.alpha = 1
    }
   
    
    func swiped(gesture: UIGestureRecognizer){
        if !needsInstruction {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer{
                switch swipeGesture.direction{
                case UISwipeGestureRecognizerDirection.Left :
                    swipeLeft()
                
                case UISwipeGestureRecognizerDirection.Right :
                    swipeRight()
                
                default:
                    break
                }
            
                }
        }
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        if !needsInstruction {
            let point = gestureRecognizer.locationInView(self.view)
            if point.x < self.view.bounds.size.width / 2{
                swipeRight()
            }
            else{
                swipeLeft()
            }
        }
    }
    
    func swipeLeft(){
        if ratingControl.rating != 0
        {
            if !isBaseline!{
                drunkRatingList[imageIndex] = ratingControl.rating
                print(ratingControl.rating)
            }
            else{
                baselineRatingList[imageIndex] = ratingControl.rating
                print(ratingControl.rating)
            }
            
            imageIndex += 1
            //imageLength
            if isBaseline! && imageIndex == (imageLength - 1) {
                finishButton.hidden = false
            }
            if !isBaseline! && imageIndex == (drunkImageCount - 1) {
                finishButton.hidden = false
            }
            
            //Prevent swiping from causing crashes
            if (imageIndex==imageLength && isBaseline!)||(imageIndex == drunkImageCount && !isBaseline!){
                imageIndex=imageIndex-1
                finish()
            }
            
            if !isBaseline!{
                personImage.image=UIImage(named: folderName + imageList[imageDrunkList[imageIndex]])
                print(folderName + imageList[imageDrunkList[imageIndex]])
                print("index: " + String(imageDrunkList[imageIndex]))
                ratingControl.rating = drunkRatingList[imageIndex]
                
                progressView.progress = (Float(imageIndex) + 1) / Float(drunkImageCount)
            }
            else{
                personImage.image=UIImage(named: folderName + imageList[imageIndex])
                ratingControl.rating = baselineRatingList[imageIndex]
                
                progressView.progress = (Float(imageIndex) + 1) / 25.0
            }
        }
    }
    
    func swipeRight(){
        
        if !isBaseline!{
            drunkRatingList[imageIndex] = ratingControl.rating
            print(ratingControl.rating)
            
        }
        else{
            baselineRatingList[imageIndex] = ratingControl.rating
            print(ratingControl.rating)
        }
        
        imageIndex-=1
        
        if imageIndex < 0 {
            imageIndex = 0
        }
        
        if !isBaseline!{
            personImage.image=UIImage(named: folderName + imageList[imageDrunkList[imageIndex]])
            ratingControl.rating = drunkRatingList[imageIndex]
            progressView.progress = (Float(imageIndex) + 1) / Float(drunkImageCount)
        }
        else{
            personImage.image=UIImage(named: folderName + imageList[imageIndex])
            ratingControl.rating = baselineRatingList[imageIndex]
            progressView.progress = (Float(imageIndex) + 1) / 25.0
        }
    }
    
    
    
    func textFieldShouldReturn(rateTextField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func finishButton(sender: AnyObject) {
        finish()

    }
    
    func finish(){
        if ratingControl.rating != 0
        {
            if isBaseline! {
                baselineRatingList[imageIndex] = ratingControl.rating
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(baselineRatingList, forKey: "BaselineRates")
                defaults.setObject(true, forKey: "BaselineDone")
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            }
            else{
                drunkRatingList[imageIndex] = ratingControl.rating
                var score = 0;
                for i in 0 ..< drunkImageCount{
                    score += drunkRatingList[i] - baselineRatingList[imageDrunkList[i]]
                }
                let storyboard = self.storyboard;
                if storyboard != nil {
                    if let vc = storyboard!.instantiateViewControllerWithIdentifier("ScoreViewController") as? ScoreViewController {
                        vc.score = score;
                        self.presentViewController(vc, animated: true, completion: nil);
                        
                    }
                }
            }
        }
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
