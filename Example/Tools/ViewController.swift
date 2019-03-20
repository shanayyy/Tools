//
//  ViewController.swift
//  Tools
//
//  Created by shanayyy on 03/19/2019.
//  Copyright (c) 2019 shanayyy. All rights reserved.
//

import UIKit
import Tools

class ViewController: UIViewController {
    var array = SynchronizedArray<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.concurrentPerform(iterations: 100) { index in
            let last = array.last ?? 0
            array.append(last + 1)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

