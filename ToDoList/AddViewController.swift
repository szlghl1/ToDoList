//
//  AddViewController.swift
//  ToDoList
//
//  Created by Ling He on 1/29/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var importLevelSegCtrl: UISegmentedControl!
    @IBOutlet weak var deadlineDisplayLabel: UILabel!
    var datePicker = UIDatePicker()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        var str = String(describing: components.year!)
        str += "-\(components.month!)-\(components.day!)"
        deadlineDisplayLabel.text = str
        
        let tapViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissInputTools))
        view.addGestureRecognizer(tapViewRecognizer)
        
        deadlineDisplayLabel.isUserInteractionEnabled = true
        let tapDDLRecognizer = UITapGestureRecognizer(target: self, action: #selector(deadlineLabelPressed))
        deadlineDisplayLabel.addGestureRecognizer(tapDDLRecognizer)
    }
    
    @objc
    func deadlineLabelPressed() {
        datePicker.minimumDate = Date(timeIntervalSinceNow: 0)
        datePicker.center = view.center
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .date
        view.addSubview(datePicker)
    }
    
    @objc
    func dismissInputTools() {
        view.endEditing(false)
        datePicker.removeFromSuperview()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: datePicker.date)
        var str = String(describing: components.year!)
        str += "-\(components.month!)-\(components.day!)"
        deadlineDisplayLabel.text = str

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
                task.title = titleTextField.text
                task.detail = titleTextField.text
                task.importantLevel = Int16(importLevelSegCtrl.selectedSegmentIndex)
                task.deadline = datePicker.date as NSDate?
                task.createTime = Date() as NSDate?
            }
            do {
                try managedContext.save()
                //(UIApplication.shared.delegate as! AppDelegate).saveContext()
            } catch {
                print("failed to save context in adding tase")
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
