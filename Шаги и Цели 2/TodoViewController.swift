//
//  AddViewController.swift
//  Шаги и Цели 2
//
//  Created by Sergey on 05.08.2021.
//

import UIKit

protocol TodoViewControllerDelegate: AnyObject {
  func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo)
}

class TodoViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    var todo: Todo?
    
    weak var delegate: TodoViewControllerDelegate?

    override func viewDidLoad() {
      super.viewDidLoad()

      textfield.text = todo?.title
    }
      
    @IBAction func save(_ sender: Any) {
      let todo = Todo(title: textfield.text!)
      delegate?.todoViewController(self, didSaveTodo: todo)
    }
    
  }
//, UITextFieldDelegate

    
    
//    @IBOutlet var titleField: UITextField!
 //   @IBOutlet var bodyField: UITextField!
 //   @IBOutlet var datePicker: UIDatePicker!
    
    
  //  public var completion: ((String, String, Date) -> Void)?

 //   override func viewDidLoad() {
 //       super.viewDidLoad()
  //      datePicker.datePickerMode = .dateAndTime
   //    let localeID = Locale.preferredLanguages.first
   //     datePicker.locale = Locale(identifier: localeID!)
   //     titleField.delegate = self
   //     bodyField.delegate = self
        
        
    //    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
  //   }
    
    
    
  //     @objc func didTapSaveButton() {
   //     if let titleText = titleField.text, !titleText.isEmpty,
    //       let bodyText = bodyField.text, !bodyText.isEmpty {
            
     //       let targetDate = datePicker.date
            
     //       completion?(titleText, bodyText, targetDate )
            
            
            
            
     //       dismiss(animated: true)
  //      }
        
//    }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
   //     textField.resignFirstResponder()
  //      return true
//    }
    
    

//}
