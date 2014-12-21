//
//  ViewController.swift
//  tips
//
//  Created by John Boyd on 12/15/14.
//  Copyright (c) 2014 John Boyd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var twoPersonLabel: UILabel!
    @IBOutlet weak var threePersonLabel: UILabel!
    @IBOutlet weak var fourPersonLabel: UILabel!
    @IBOutlet weak var oneStarLabel: UILabel!
    @IBOutlet weak var twoStarLabel: UILabel!
    @IBOutlet weak var threeStarLabel: UILabel!
    @IBOutlet weak var fourStarLabel: UILabel!
  
    // this adds commas to a number stored as text
    func addCommas(totalText: String) -> String {
        var revStr = ""
        var counter = 2
        var flag = false
        var lastChar = ""
        var char = ""
        var forwardStr = ""
        for char in reverse(totalText) {
            if (lastChar == ".") {
                flag = true
            }
            if (flag) {
                counter += 1
            }
            if (counter % 3 == 0 && lastChar != ".") {
                revStr += ","
            }
            revStr.append(char)
            lastChar = String(char)
        }
        for char in revStr {
            forwardStr = String(char) + forwardStr
        }
        return forwardStr
    }
    
    // set the default background color that can be changed 
    // the Settings page.
    func setBackgroundColor(segIndex: Int) {
        switch segIndex {
        case 1:
            view.backgroundColor = .purpleColor()
            billField.backgroundColor = .purpleColor()
   
        case 2:
            view.backgroundColor = .blueColor()
            billField.backgroundColor = .blueColor()
 
        case 3:
            view.backgroundColor = .whiteColor()
            billField.backgroundColor = .whiteColor()
   
        default:
            view.backgroundColor = .blackColor()
            billField.backgroundColor = .blackColor()
      
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set billField alpha to visible
        billField.alpha = 1
        // set focus to the billField
        self.billField.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        // viewWillAppear allows updates to the screen before changing
        // to that view
        super.viewDidAppear(animated)
        // set focus to the billField
        self.billField.becomeFirstResponder()
        // pull vars stored in MSUserDefaults
        var defaults =  NSUserDefaults.standardUserDefaults()
        var storedPercent = defaults.objectForKey("stored_percent") as? Double
        var storedIndex = defaults.integerForKey("stored_seg_index")
        var storedColorIndex = defaults.integerForKey("stored_color_index")
        tipControl.selectedSegmentIndex = storedIndex
        var tipPercentage = 0.2
        if (storedPercent > 0.0) {
            var tipPercentage = storedPercent
        }
        var storedBillAmount = defaults.objectForKey("stored_bill_amount") as? Double
        var billAmount = 0.0
        if (storedBillAmount > 0.0) {
            billAmount = storedBillAmount!
        }
        billAmount = NSString(string: billField.text).doubleValue
        // grab the date last stored and display billAmount if accessed in the last 10 min
        let myDate = NSUserDefaults.standardUserDefaults().objectForKey("myDate") as? NSDate
        
        if let lastDate = myDate {
            
            let dateNow = NSDate()
            let secondsInTenMin: NSTimeInterval = 600
            
            if dateNow.timeIntervalSinceDate(lastDate) >= secondsInTenMin {
                storedBillAmount = 0.0
            }
        }
        
        if (storedBillAmount > 0.0 ) {
            billAmount = storedBillAmount!
            billField.text = String(format:"%.2f",billAmount)
        }
        // calculate additional people's amounts
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        var divby2 = total / 2
        var divby3 = total / 3
        var divby4 = total / 4

        // hide most text if nothing is entered in billField
        if (NSString(string: billField.text).doubleValue > 0.0 ) {
                self.tipControl.alpha = 1
                self.tipLabel.alpha = 1
                self.totalLabel.alpha = 1
                self.twoPersonLabel.alpha = 1
                self.threePersonLabel.alpha = 1
                self.fourPersonLabel.alpha = 1
                self.oneStarLabel.alpha = 1
                self.twoStarLabel.alpha = 1
                self.threeStarLabel.alpha = 1
                self.fourStarLabel.alpha = 1
         } else {
                self.tipControl.alpha = 0
                self.tipLabel.alpha = 0
                self.totalLabel.alpha = 0
                self.twoPersonLabel.alpha = 0
                self.threePersonLabel.alpha = 0
                self.fourPersonLabel.alpha = 0
                self.oneStarLabel.alpha = 0
                self.twoStarLabel.alpha = 0
                self.threeStarLabel.alpha = 0
                self.fourStarLabel.alpha = 0
        }
        // display text with commas if numbers are over 1000
        tipLabel.text = "+ $" + addCommas(String(format: "%.2f", tip))
        totalLabel.text = "$" + addCommas(String(format: "%.2f", total))
        twoPersonLabel.text = "$" + addCommas(String(format: "%.2f", divby2))
        threePersonLabel.text = "$" + addCommas(String(format: "%.2f", divby3))
        fourPersonLabel.text = "$" + addCommas(String(format: "%.2f", divby4))
        setBackgroundColor(storedColorIndex)
        
    }
    

    // actions if editing occurs similar to above
    @IBAction func onEditingChanged(sender: AnyObject) {
     
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        var divby2 = total / 2
        var divby3 = total / 3
        var divby4 = total / 4
        
        tipLabel.text = "+ $" + addCommas(String(format: "%.2f", tip))
        totalLabel.text = "$" + addCommas(String(format: "%.2f", total))
        twoPersonLabel.text = "$" + addCommas(String(format: "%.2f", divby2))
        threePersonLabel.text = "$" + addCommas(String(format: "%.2f", divby3))
        fourPersonLabel.text = "$" + addCommas(String(format: "%.2f", divby4))
        
        if (NSString(string: billField.text).doubleValue > 0.0 ) {
            // fade in text over 1 second if billField is greater than 0
            UIView.animateWithDuration(1.0, animations: {
                self.tipControl.alpha = 1
                self.tipLabel.alpha = 1
                self.totalLabel.alpha = 1
                self.twoPersonLabel.alpha = 1
                self.threePersonLabel.alpha = 1
                self.fourPersonLabel.alpha = 1
                self.oneStarLabel.alpha = 1
                self.twoStarLabel.alpha = 1
                self.threeStarLabel.alpha = 1
                self.fourStarLabel.alpha = 1
            })
        } else {
            // otherwise fade the text out
            UIView.animateWithDuration(1.0, animations: {
                                self.tipControl.alpha = 0
                self.tipLabel.alpha = 0
                self.totalLabel.alpha = 0
                self.twoPersonLabel.alpha = 0
                self.threePersonLabel.alpha = 0
                self.fourPersonLabel.alpha = 0
                self.oneStarLabel.alpha = 0
                self.twoStarLabel.alpha = 0
                self.threeStarLabel.alpha = 0
                self.fourStarLabel.alpha = 0
            })
            
        }
        // store date and bill amount for later
        var currentDate = NSDate()
        var user =  NSUserDefaults.standardUserDefaults()
        user.setObject(currentDate, forKey: "myDate")
        user.setObject(billAmount, forKey: "stored_bill_amount")
        user.synchronize()
        

        
    }
    
    // tap anywhere to remove keyboard
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

