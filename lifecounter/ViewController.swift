//
//  ViewController.swift
//  lifecounter
//
//  Created by Chai Gangavarapu on 1/28/19.
//  Copyright © 2019 Chaitanya Gangavarapu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    // life labels
    @IBOutlet weak var lifelabel1: UILabel!
    @IBOutlet weak var lifelabel2: UILabel!
    @IBOutlet weak var lifelabel3: UILabel!
    @IBOutlet weak var lifelabel4: UILabel!
    @IBOutlet weak var lifelabel5: UILabel!
    @IBOutlet weak var lifelabel6: UILabel!
    @IBOutlet weak var lifelabel7: UILabel!
    @IBOutlet weak var lifelabel8: UILabel!
    @IBOutlet weak var loseLabel: UILabel!
    
    // player stack views
    @IBOutlet weak var view1: UIStackView!
    @IBOutlet weak var view2: UIStackView!
    @IBOutlet weak var view3: UIStackView!
    @IBOutlet weak var view4: UIStackView!
    @IBOutlet weak var view5: UIStackView!
    @IBOutlet weak var view6: UIStackView!
    @IBOutlet weak var view7: UIStackView!
    @IBOutlet weak var view8: UIStackView!
    
    var players: [UIStackView] = [];
    
    var historyStrings: [String] = [];
    
    var numPlayers: Int = 4;
    
    var gameStarted: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        players.append(view1);
        players.append(view2);
        players.append(view3);
        players.append(view4);
        players.append(view5);
        players.append(view6);
        players.append(view7);
        players.append(view8);
        
       
    }
     
    @IBAction func numberChange(_ sender: UITextField, forEvent event: UIEvent) {
        let charset = CharacterSet(charactersIn: "+-1234567890")
        for case let button as UIButton in (sender.superview?.subviews)! {
            if (sender.text?.rangeOfCharacter(from: charset) != nil) {
                button.setTitle(sender.text, for: .normal);
            }
        }
    }
    
    @IBAction func onClick(_ sender: UIStepper) {
        gameStarted = true;
        let tag: Int = sender.tag;
        let label: UILabel
        if (tag == 1) {
            label = lifelabel1;
        } else if (tag == 2) {
            label = lifelabel2
        } else if (tag == 3) {
            label = lifelabel3
        } else if (tag == 4) {
            label = lifelabel4
        } else if (tag == 5) {
            label = lifelabel5;
        } else if (tag == 6) {
            label = lifelabel6;
        } else if (tag == 7) {
            label = lifelabel7;
        } else {
            label = lifelabel8;
        }
        let newLabel: Int
        let trim: String = label.text!.trimmingCharacters(in: .whitespacesAndNewlines);
        if (sender.value > 0) {
            newLabel = Int(trim)! + 1
            addHistoryString(1, tag)
        } else {
             newLabel = Int(trim)! - 1
            addHistoryString(-1, tag)
        }
        label.text = String(newLabel);
        sender.value = 0;
        checkBelowZero(label);
    }
    
    func addHistoryString(_ increment: Int, _ player: Int) {
        var string: String = "";
        if (increment > 0) {
            string = "Player " + String(player) + " gained " + String(increment) + " life";
        } else {
            string = "Player " + String(player) + " lost " + String(increment) + " life";
        }
        historyStrings.append(string);
    }
    
    
    @IBAction func fiveClick(_ sender: UIButton) {
        gameStarted = true;
        let tag: Int = sender.tag;
        let label: UILabel
        if (tag == 1) {
            label = lifelabel1;
        } else if (tag == 2) {
            label = lifelabel2
        } else if (tag == 3) {
            label = lifelabel3
        } else if (tag == 4) {
            label = lifelabel4
        } else if (tag == 5) {
            label = lifelabel5;
        } else if (tag == 6) {
            label = lifelabel6;
        } else if (tag == 7) {
            label = lifelabel7;
        } else {
            label = lifelabel8;
        }
        let newLabel: Int
        var positive: Bool = true;
        var increment: Int = 0;
        if (sender.currentTitle?.contains("-") ?? false) {
            positive = false;
        }
        if let number = Int(sender.currentTitle!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            increment = number;
        }
        let trim: String = label.text!.trimmingCharacters(in: .whitespacesAndNewlines);
        if (positive) {
            newLabel = Int(trim)! + increment
            addHistoryString(increment, tag);
        } else {
            newLabel = Int(trim)! - increment
            increment.negate();
            addHistoryString(increment, tag);
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
    
    
    @IBAction func addPlayer(_ sender: UIButton) {
        if (!gameStarted) {
            for view in players {
                if (view.isHidden == true) {
                    view.isHidden = false;
                    numPlayers += 1;
                    break;
                }
            }
        }
    }
    
    @IBAction func removePlayer(_ sender: UIButton) {
        if (numPlayers > 2 && !gameStarted) {
            for view in players.reversed() {
                if (view.isHidden == false) {
                    view.isHidden = true;
                    numPlayers -= 1;
                    break;
                }
            }
        }
    }
    
    
    @IBAction func history(_ sender: Any) {

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let historyViewController = storyBoard.instantiateViewController(withIdentifier: "history") as! HistoryController
        historyViewController.historyStrings = historyStrings;
        self.present(historyViewController, animated: true, completion: nil)


    }
    
    @IBAction func reset(_ sender: UIButton) {
        loseLabel.text = "";
        lifelabel1.text = "20";
        lifelabel2.text = "20";
        lifelabel3.text = "20";
        lifelabel4.text = "20";
        lifelabel5.text = "20";
        lifelabel6.text = "20";
        lifelabel7.text = "20";
        lifelabel8.text = "20";
        gameStarted = false;
        historyStrings.removeAll()
    }
}

