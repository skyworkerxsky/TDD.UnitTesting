//
//  ViewController.swift
//  Demo
//
//  Created by Алексей Макаров on 03.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private(set) var volume = 0
    
    func setVolume(value: Int) {
        volume = min(max(value, 0), 100)
    }
    
    func charactersCompare(stringOne: String, stringTwo: String) -> Bool {
        return Set(stringOne) == Set(stringTwo)
    }

}

