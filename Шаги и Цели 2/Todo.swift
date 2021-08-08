//
//  Todo.swift
//  Шаги и Цели 2
//
//  Created by Sergey on 08.08.2021.
//

import Foundation

struct Todo {
    
    
    
    let title: String
 //   let date : Date
 //   let identifier: String

    let isComplete: Bool
    
    init(title: String, isComplete: Bool = false) {
      self.title = title
      self.isComplete = isComplete
   }
    
    func completeToggled() -> Todo {
      return Todo(title: title, isComplete: !isComplete)
    }
    
}
