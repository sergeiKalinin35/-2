//
//  ViewController.swift
//  Шаги и Цели 2
//
//  Created by Sergey on 04.08.2021.
//



//import UserNotifications
import UIKit

class ViewController: UIViewController {
    
    var todos = [
      Todo(title: "Make vanilla pudding."),
      Todo(title: "Put pudding in a mayo jar."),
      Todo(title: "Eat it in a public place."),
    ]
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    tableView.delegate = self
     //   tableView.dataSource = self
        
     
      //  table.rowHeight = 70
        
    //    navigationItem.leftBarButtonItem = editButtonItem
        
        
    }
    
    
    
    @IBAction func startEditing(_ sender: Any) {
        
        tableView.isEditing = !tableView.isEditing
    }
    
    
    
    @IBSegueAction func todoViewcontroller(_ coder: NSCoder) -> TodoViewController? {
      let vc = TodoViewController(coder: coder)
      
      if let indexpath = tableView.indexPathForSelectedRow {
        let todo = todos[indexpath.row]
        vc?.todo = todo
      }
      
      vc?.delegate = self
      vc?.presentationController?.delegate = self
      
      return vc
    }
    
  }
    
    
    
    
    
    
    
    
    
    
    
    
    
 //   @IBAction func  didTapAdd() {
        // show add vc
 //       guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
  //          return
  //      }
        
   //     vc.title = "New Reminder"
   //     vc.navigationItem.largeTitleDisplayMode = .never
   //     vc.completion = { title, body, date in
   //         DispatchQueue.main.async {
  //              self.navigationController?.popToRootViewController(animated: true)
   //             let new = Todo(title: title, date: date , identifier: "id_ \(title)")
     //           self.todos.append(new)
     //           self.table.reloadData()
                
      //          let content = UNMutableNotificationContent()
        //        content.title  = title
       //         content.sound = .default
          //      content.body = body
                
           //     let targetDate = date //Date().addingTimeInterval(10)
           //     let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents( [.year, .month, .day, .hour, .minute, . second],
              //                                                                                            from: targetDate)  ,
            
          //                                                  repeats: false)
          //      let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
       //         UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
      //              if error != nil {
   //                     print("something went wrong")
       //             }
                    
       //             })
                
      //          }
            
    //    }
        
    //    navigationController?.pushViewController(vc, animated: true)
        
        
        
//}
    
    

    // Кнопка теста кнопка редактирования
  //  @IBAction func  didTapTest() {
        // тест уведомление
  //      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
     //       if success {
                
                // test
      //          self.scheduleTest()
      //      }
    //        else if error != nil {
     //           print("error occurred")
                
     //       }
            
    //    })
 //   }
    //окно уведомления
 //   func scheduleTest() {
   //     let content = UNMutableNotificationContent()
   //     content.title  = "Заголовок!"
    //    content.sound = .default
    //    content.body = "Описание!⚓️"
        
   //     let targetDate = Date().addingTimeInterval(10)
   //     let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents( [.year, .month, .day, .hour, .minute, . second],
  //                                                                                                from: targetDate)  ,
                                                    
    //                                                repeats: false)
        
    //    let request = UNNotificationRequest(
    //        identifier: "some_long_id",
   //         content: content,
    //        trigger: trigger)
    //    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
   //         if error != nil {
   //             print("something went wrong")
    //        }
            
   //         })
        

//}

extension ViewController: UITableViewDelegate {
    // смахивание комплита в ячейке с лева на право
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
          
          let todo = self.todos[indexPath.row].completeToggled()
          self.todos[indexPath.row] = todo
          
          let cell = tableView.cellForRow(at: indexPath) as! ChekTableViewCell
          cell.set(checked: todo.isComplete)
          
          complete(true)
          
          print("complete")
    }
    
        return UISwipeActionsConfiguration(actions: [action])
      }
    
    // удаление ячейки
  
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}
    extension ViewController: UITableViewDataSource {
    //   func numberOfSections(in tableView: UITableView) -> Int {
  //      return 1
  //  }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as! ChekTableViewCell
   
        cell.delegate = self
        
        let todo = todos[indexPath.row]
        
        cell.set(title: todo.title, checked: todo.isComplete)
        
        
        
        
        
        
        
        
        //   cell.textLabel?.text = models[indexPath.row].title
    //   let date = models[indexPath.row].date
     //   let formatter = DateFormatter()
      //  formatter.dateStyle = .full
     //   formatter.dateFormat = "dd.MM. HH:mm"
     //   cell.detailTextLabel?.text = formatter.string(from: date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        todos.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    // двигаем ячейки вверх низ
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      let todo = todos.remove(at: sourceIndexPath.row)
      todos.insert(todo, at: destinationIndexPath.row)
    }
    
  }
    
extension ViewController: CheckTableViewCellDelegate {
  
  func checkTableViewCell(_ cell: ChekTableViewCell, didChagneCheckedState checked: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    let todo = todos[indexPath.row]
    let newTodo = Todo(title: todo.title, isComplete: checked)
    
    todos[indexPath.row] = newTodo
  }
  
}
    
extension ViewController: TodoViewControllerDelegate {
  
  func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo) {
    
    
    
    dismiss(animated: true) {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        // update
        self.todos[indexPath.row] = todo
        self.tableView.reloadRows(at: [indexPath], with: .none)
      } else {
        // create
        self.todos.append(todo)
        self.tableView.insertRows(at: [IndexPath(row: self.todos.count-1, section: 0)], with: .automatic)
      }
    }
  
  }
  
}


extension ViewController: UIAdaptivePresentationControllerDelegate {
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
}

    
    
    // двигаем ячейку
 //   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
 //      let mu =  todos.remove(at: sourceIndexPath.row)
  //      todos.insert(mu, at: destinationIndexPath.row)
 //   }

 //   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
 //     let currenTrack = models.remove(at: sourceIndexPath.row)
//        models.insert(currenTrack, at: destinationIndexPath.row)
 //   }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // удаление ячейки
 //   func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
  //      return .delete
  //  }
    
  //  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   //     if editingStyle == .delete {
    //        tableView.beginUpdates()
     //       todos.remove(at: indexPath.row)
      //      tableView.deleteRows(at: [indexPath], with: .fade)
            
            
     //       tableView.endUpdates()
    //    }
        
 //   }
    






