//
//  ViewController.swift
//  Task
//
//  Created by Caleb Hicks on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
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
    
    let stagedTask = Task(title: "Do the dishes", dueDate: nil, notes: nil, tag: [])
    
    let secondStagedTask = Task(title: "Clean car", dueDate: NSDate(), notes: nil, tag: [])


}

