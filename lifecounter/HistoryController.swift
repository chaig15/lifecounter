//
//  HistoryController.swift
//  lifecounter
//
//  Created by Chai Gangavarapu on 2/3/19.
//  Copyright © 2019 Chaitanya Gangavarapu. All rights reserved.
//


import UIKit

class HistoryController: UIViewController {
    
     var historyStrings: [String] = [];
    
    @IBOutlet weak var history: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for string in historyStrings {
            history.text?.append(string);
            history.text?.append("\n");
        }
        
        
    }
    
    @IBAction func game(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
}
