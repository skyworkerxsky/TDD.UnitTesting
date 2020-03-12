//
//  ViewController.swift
//  ToDoApp
//
//  Created by Алексей Макаров on 03.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: DataProvider!
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("main")
    }
    
    // MARK: - Actions
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(identifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            present(viewController, animated: true, completion: nil)
        }
    }
    
}

