//
//  ViewController.swift
//  TapperProject
//
//  Copyright © 2016 Holberton School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Mark: Properties
    
    @IBOutlet weak var image_tapper: UIImageView!
    @IBOutlet weak var button_play: UIButton!
    @IBOutlet weak var textfield_number: UITextField!
    @IBOutlet weak var label_taps: UILabel!
    @IBOutlet weak var button_coin: UIButton!
    
    @IBAction func clickPlayButton(sender: AnyObject){
        if let taps = Int(self.textfield_number!.text!) {
            if taps > 0 {
                print("Let's do \(taps) taps")
            }
        }
    }
    
    @IBAction func clickCoinButton(sender: AnyObject) {
        print("Tap!")
        self.taps_done += 1
        self.label_taps.text = "\(taps_done) Taps"
    }
    var taps_done: Int = 0
    var taps_requested: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

