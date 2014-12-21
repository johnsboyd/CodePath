//
//  SettingsViewController.swift
//  tips
//
//  Created by John Boyd on 12/16/14.
//  Copyright (c) 2014 John Boyd. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsControl: UISegmentedControl!
    @IBOutlet weak var colorControl: UISegmentedControl!
    
    // sets background color
    func setBackgroundColor(segIndex: Int) {
        switch segIndex {
        case 1:
            view.backgroundColor = .purpleColor()
        case 2:
            view.backgroundColor = .blueColor()
        case 3:
            view.backgroundColor = .whiteColor()
        default:
            view.backgroundColor = .blackColor()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // reset all view events to the last ones stored from this view
        var defaults =  NSUserDefaults.standardUserDefaults()
        var storedPercent = defaults.objectForKey("stored_percent") as? Double
        var storedIndex = defaults.integerForKey("stored_seg_index")
        settingsControl.selectedSegmentIndex = storedIndex
        
        var storedColorIndex = defaults.integerForKey("stored_color_index")
        colorControl.selectedSegmentIndex = storedColorIndex
        setBackgroundColor(storedColorIndex)

    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // set and store color changes in Settings
    @IBAction func onColorChanged(sender: AnyObject) {
        var colorIndex = colorControl.selectedSegmentIndex
        setBackgroundColor(colorIndex)
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(colorIndex, forKey: "stored_color_index")
        defaults.synchronize()
    }
    
    // set and store percent changes in Settings
    @IBAction func onSettingsChanged(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[settingsControl.selectedSegmentIndex]
        var defaults =  NSUserDefaults.standardUserDefaults()
        defaults.setObject(tipPercentage, forKey: "stored_percent")
        defaults.setInteger(settingsControl.selectedSegmentIndex, forKey: "stored_seg_index")
        defaults.synchronize()

    }

    // dismiss and return to regular app view
    @IBAction func onTapReturn(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

}
