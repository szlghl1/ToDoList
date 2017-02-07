//
//  testVCViewController.swift
//  ToDoList
//
//  Created by Ling He on 2/6/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import UIKit

class testVCViewController: UIViewController, UITextFieldDelegate {
    let pcker = UIDatePicker()
    @IBOutlet weak var txtfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtfield.delegate = self
        txtfield.returnKeyType = .done
        let toolbarview = UIToolbar()
        toolbarview.sizeToFit()
        let item = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissEdit))
        toolbarview.setItems([item], animated: true)
        toolbarview.isUserInteractionEnabled = true
        txtfield.inputAccessoryView = toolbarview
        txtfield.inputView = pcker
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //textField.returnKeyType = .done
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        var dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateStyle = .long
        txtfield.text = dateFormatter.string(from: pcker.date)
        txtfield.resignFirstResponder()
    }
    
    @objc
    func dismissEdit() {
        print("pressed")
        self.view.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        self.view.endEditing(false)
        return true
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
