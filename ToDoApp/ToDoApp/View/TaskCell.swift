//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Алексей Макаров on 25.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter
    }
    
    func configure(withTask task: Task, done: Bool = false) {
        
        if done {
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            dateLabel = nil
            locationLabel = nil
        } else {
            // установка заголовка
            self.titleLabel.text = task.title
            
            // установка локации
            self.locationLabel.text = task.location?.name
            
            // установка даты
            let dateString = dateFormatter.string(from: task.date)
            dateLabel.text = dateString
        }
        
        
    }
    
}
