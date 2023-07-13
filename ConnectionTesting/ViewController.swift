//
//  ViewController.swift
//  ConnectionTesting
//
//  Created by Ahmed Ibrahim on 12/07/2023.
//

import UIKit
import NetworkExtension



class ViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timesLabel: UILabel!
    
    var count = 0
    var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.addObserver(self, forKeyPath: "date", options: .new, context: nil)
        
        dateLabel.text = UserDefaults.standard.string(forKey: "date")
        timesLabel.text = String(UserDefaults.standard.integer(forKey: "time"))
        
    }
    
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: "yourUserDefaultsKey")
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "date" {
            let newValue = UserDefaults.standard.string(forKey: "date")
            dateLabel.text = newValue
        }
    }
    
    
}

