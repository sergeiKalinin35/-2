//
//  ViewController.swift
//  Шаги и Цели 2
//
//  Created by Sergey on 04.08.2021.
//
import UserNotifications
import UIKit

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!
    
    var models = [Todo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
     
        table.rowHeight = 70
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        
    }
    
    @IBAction func  didTapAdd() {
        // show add vc
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        
        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = Todo(title: title, date: date , identifier: "id_ \(title)")
                self.models.append(new)
                self.table.reloadData()
                
                let content = UNMutableNotificationContent()
                content.title  = title
                content.sound = .default
                content.body = body
                
                let targetDate = date //Date().addingTimeInterval(10)
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents( [.year, .month, .day, .hour, .minute, . second],
                                                                                                          from: targetDate)  ,
                                                            
                                                            repeats: false)
                
                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                    
                    })
                
                }
            
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        
}
    
    

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
        }

//}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    //   func numberOfSections(in tableView: UITableView) -> Int {
  //      return 1
  //  }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CheckTableViewCell
   
        cell.textLabel?.text = models[indexPath.row].title
        
        
        let date = models[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.dateFormat = "dd.MM. HH:mm"
        cell.detailTextLabel?.text = formatter.string(from: date)
        
        return cell
    }
    
    
    // двигаем ячейку
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
       let mu =  models.remove(at: sourceIndexPath.row)
        models.insert(mu, at: destinationIndexPath.row)
    }
 //   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
 //     let currenTrack = models.remove(at: sourceIndexPath.row)
//        models.insert(currenTrack, at: destinationIndexPath.row)
 //   }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // удаление ячейки
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            tableView.endUpdates()
        }
        
     
}
    
  
    

    
}




