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
    let date: Date?
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
