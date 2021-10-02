//
//  ViewController.swift
//  counterApp
//
//  Created by harsh Khandelwal on 10/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    var count : Int = 0

    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counterLabel.text = String(count)
    }

    @IBAction func counterPlus(_ sender: UIButton) {
        count += 1
        counterLabel.text = String(count)
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        count = 0
        counterLabel.text = String(count)
    }
}

