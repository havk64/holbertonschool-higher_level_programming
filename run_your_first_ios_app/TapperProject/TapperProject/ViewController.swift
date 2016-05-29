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
    
    var taps_done: Int = 0
    var taps_requested: Int = 0
    
    @IBAction func clickPlayButton(sender: AnyObject){
        if let taps = Int(self.textfield_number!.text!) {
            if taps > 0 {
                print("Let's do \(taps) taps")
            }
            self.taps_requested = taps
            initGame()
        }
    }
    

    @IBAction func clickCoinButton(sender: AnyObject) {
        print("Tap!")
        self.taps_done += 1
        self.label_taps.text = "\(taps_done) Taps"
        if self.taps_done >= self.taps_requested{
            resetGame()
        }
    }
    
    func initGame() {
        self.image_tapper.hidden = true
        self.button_play.hidden = true
        self.textfield_number.hidden = true
        self.label_taps.hidden = false
        self.button_coin.hidden = false
        self.taps_done = 0
        self.label_taps.text = "0 Taps"
    }
    
    func resetGame() {
        self.label_taps.hidden = true
        self.button_coin.hidden = true
        self.image_tapper.hidden = false
        self.button_play.hidden = false
        self.textfield_number.hidden = false
        self.taps_requested = 0
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

