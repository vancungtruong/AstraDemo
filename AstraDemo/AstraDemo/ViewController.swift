//
//  ViewController.swift
//  AstraDemo
//
//  Created by cuong on 3/18/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func upgradeToPremiumTapped(_ sender: Any) {
        
        UpgradeToPremiumViewController.show(from: self)
    }
}

