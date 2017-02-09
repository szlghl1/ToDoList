//
//  AddViewController.swift
//  ToDoList
//
//  Created by Ling He on 1/29/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var importLevelSegCtrl: UISegmentedControl!
    @IBOutlet weak var deadlineTextField: UITextField!
    //group
    
    @IBOutlet weak var groupSegCtrl: UISegmentedControl!
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var deadline = Date()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize text field delegate
        titleTextField.delegate = self
        detailTextField.delegate = self
        
        //initialize deadline label context
        deadlineTextField.placeholder = Date().toString()
        
        //dismiss input when touch
        let tapViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissInputTools))
        view.addGestureRecognizer(tapViewRecognizer)
        
        //setup datePicker and deadlineTextField
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(updateDeadline(sender:)), for: UIControlEvents.valueChanged)
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissInputTools))
        toolbar.isUserInteractionEnabled = true
        toolbar.setItems([doneButton], animated: true)
        toolbar.sizeToFit()
        deadlineTextField.inputView = datePicker
        deadlineTextField.inputAccessoryView = toolbar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case titleTextField:
            titleTextField.resignFirstResponder()
            detailTextField.becomeFirstResponder()
        case detailTextField:
            detailTextField.resignFirstResponder()
            deadlineTextField.becomeFirstResponder()
        default:
            dismissInputTools()
        }
        return true
    }
    
    @objc
    func dismissInputTools() {
        updateDeadline(sender: datePicker)
        view.endEditing(false)
    }
    
    func updateDeadline(sender: UIDatePicker) {
        deadline = sender.date
        deadlineTextField.text = deadline.toString()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if (titleTextField.text?.isEmpty)! || (detailTextField.text?.isEmpty)! {
            var alertTitle = ""
            if (titleTextField.text?.isEmpty)! {
                alertTitle += titleTextField!.placeholder!
            }
            if (detailTextField.text?.isEmpty)! {
                alertTitle += ", " + detailTextField.placeholder!
            }
            
            alertTitle += " empty"
            let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "got it", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            if let task = NSEntityDescription.insertNewObject(forEntityName: "ThingToDo", into: managedContext) as? ThingToDo {
                task.uuid = UUID().uuidString
                task.title = titleTextField.text
                task.detail = titleTextField.text
                task.importantLevel = Int16(importLevelSegCtrl.selectedSegmentIndex)
                task.deadline = deadline as NSDate?
                task.group = Int16(groupSegCtrl.selectedSegmentIndex)
                task.createTime = Date() as NSDate?
            }
            do {
                try managedContext.save()
            } catch {
                print("failed to save context in adding task")
            }
            _ = navigationController?.popViewController(animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Date {
    func toString(style: DateFormatter.Style = .long) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
