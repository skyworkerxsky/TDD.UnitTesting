//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Алексей Макаров on 11.03.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController {
    
    var taskManager: TaskManager!
    var geocoder = CLGeocoder()
    
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var locationTF: UITextField!
    @IBOutlet var dateTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var descriptionTF: UITextField!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var canselBtn: UIButton!
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    @IBAction func save() {
        let titleString = titleTF.text
        let locationString = locationTF.text
        let date = dateFormatter.date(from: dateTF.text!)
        let descriptionString = descriptionTF.text
        let addressString = addressTF.text
        
        geocoder.geocodeAddressString(addressString!) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let location = Location(name: locationString!, coordinate: coordinate)
            let task = Task(title: titleString!, description: descriptionString, location: location, date: date)
            self.taskManager.add(task: task)
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}
