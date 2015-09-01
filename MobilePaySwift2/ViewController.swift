//
//  ViewController.swift
//  MobilePaySwift2
//
//  Created by Joachim Dittman on 31/08/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buy(sender: AnyObject) { 
        buyer().buy();
    }

}

