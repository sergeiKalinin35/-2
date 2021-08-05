//
//  AddViewController.swift
//  Шаги и Цели 2
//
//  Created by Sergey on 05.08.2021.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    public var completion: ((String,
                             String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .dateAndTime
       let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        titleField.delegate = self
        bodyField.delegate = self
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
     }
    
    
    
       @objc func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
           let bodyText = bodyField.text, !bodyText.isEmpty {
            
            let targetDate = datePicker.date
            
            completion?(
                titleText,
                bodyText, targetDate)
            
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    

}
