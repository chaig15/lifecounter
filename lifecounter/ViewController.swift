//
//  ViewController.swift
//  lifecounter
//
//  Created by Chai Gangavarapu on 1/28/19.
//  Copyright © 2019 Chaitanya Gangavarapu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lifelabel1: UILabel!
    @IBOutlet weak var lifelabel2: UILabel!
    @IBOutlet weak var lifelabel3: UILabel!
    @IBOutlet weak var lifelabel4: UILabel!
    @IBOutlet weak var loseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

  


    @IBAction func onClick(_ sender: UIStepper) {
        let tag: Int = sender.tag;
        let label: UILabel
        if (tag == 1) {
            label = lifelabel1;
        } else if (tag == 2) {
            label = lifelabel2
        } else if (tag == 3) {
            label = lifelabel3
        } else {
            label = lifelabel4
        }
        let newLabel: Int
        if (sender.value > 0) {
            newLabel = Int(label.text ?? "0")! + 1
        } else {
             newLabel = Int(label.text ?? "0")! - 1
        }
        label.text = String(newLabel);
        sender.value = 0;
        checkBelowZero(label);
    }
    
    
    @IBAction func fiveClick(_ sender: UIButton) {
        let tag: Int = sender.tag;
        let label: UILabel
        if (tag == 5) {
            label = lifelabel1;
        } else if (tag == 6) {
            label = lifelabel2
        } else if (tag == 7) {
            label = lifelabel3
        } else {
            label = lifelabel4
        }
        let newLabel: Int
        if (sender.currentTitle == "+5") {
            newLabel = Int(label.text ?? "0")! + 5
        } else {
            newLabel = Int(label.text ?? "0")! - 5
        }
        label.text = String(newLabel);
        checkBelowZero(label);
    }
    
    func checkBelowZero(_ label: UILabel) {
        
        if (Int(label.text ?? "0") ?? 0 < 0) {
            loseLabel.text = "Player \(label.tag) loses!"
            self.view.addSubview(loseLabel)
        }
    }
    
   
    @IBAction func reset(_ sender: UIButton) {
        loseLabel.text = "";
        lifelabel1.text = "20";
        lifelabel2.text = "20";
        lifelabel3.text = "20";
        lifelabel4.text = "20";
    }
}

