//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Dang Viet Ha on 3/19/15.
//  Copyright (c) 2015 Dang Viet Ha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Record the user' voice
        recordingInProgress.hidden = false
        
    }

    @IBAction func stopRecord(sender: AnyObject) {
        recordingInProgress.hidden = true
    }
}

