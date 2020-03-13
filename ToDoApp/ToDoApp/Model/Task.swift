//
//  Task.swift
//  ToDoApp
//
//  Created by Алексей Макаров on 04.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import Foundation

struct Task {
    
    let title: String
    let description: String?
    let date: Date
    let location: Location?
    
    init(title: String, description: String? = nil, location: Location? = nil, date: Date? = nil) {
        self.title = title
        self.date = date ?? Date()
        self.description = description
        self.location = location
    }
    
}

// переопределяем сравнение (исключаем date) потому что при создании даты фиксируются наносекунды и объекты сравниваются неправильно
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) ->  Bool {
        if  lhs.title == rhs.title,
            lhs.description == rhs.description,
            lhs.location  == rhs.location { return true }
        
        return false
    }
}

extension Task {
    typealias PlistDict = [String: Any]
    init?(dict: PlistDict) {
        self.title = dict["title"] as! String
        self.description = dict["description"] as? String
        self.date = dict["date"] as? Date ?? Date()
        
        if let locationDict = dict["location"] as? [String: Any] {
            self.location = Location(dict: locationDict)
        } else {
            self.location = nil
        }
    }
}
