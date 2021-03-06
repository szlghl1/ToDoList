//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Ling He on 1/29/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import NotificationCenter

class ToDoTableViewController: UITableViewController {
    
    var thingsToDo:[[ThingToDo]] = Array(repeating: [ThingToDo](), count: numOfImportLevel)
    enum IdentifierOfCells: String {
        case BasicCell = "BasicCell"
        case TaskCell = "TaskCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //preloadTestData()
        
        refreshAll()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshAll()
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(refreshAll), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numOfImportLevel
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section >= thingsToDo.count {
            return 0
        } else {
            return thingsToDo[section].count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Level \(section)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: IdentifierOfCells.TaskCell.rawValue) ?? UITableViewCell(style: .value1, reuseIdentifier: IdentifierOfCells.TaskCell.rawValue)) as! TaskTableViewCell
        let thing = thingsToDo[indexPath.section][indexPath.row]
        cell.title = thing.title!
        cell.detail = thing.detail!
        cell.deadline = thing.deadline! as Date
        cell.importLevel = Int(thing.importantLevel)
        cell.group = Int(thing.group)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func refreshAll() {
        for i in 0..<numOfImportLevel {
            thingsToDo[i] = ToDoList.getTasksByImportLevel(importantLevel: i)
        }
        tableView.reloadData()
    }
    
    func preloadTestData() {
        struct wrappedFlag {
            static var runned: Bool = false
        }
        if wrappedFlag.runned == true {
            return
        } else {
            wrappedFlag.runned = true
        }
        for i in 0..<numOfImportLevel {
            if let task = ToDoList.addTask(title: "Task in level \(i)", detail: "detail", importantLevel: i, deadline: Date(timeIntervalSinceNow: 50), group: i) {
                thingsToDo[i].append(task)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ToDoList.removeTask(task: thingsToDo[indexPath.section][indexPath.row])
            thingsToDo[indexPath.section].remove(at: indexPath.row)
            tableView.reloadSections([indexPath.section], with: UITableViewRowAnimation.fade)
        }
    }
    
    func fetchSection(section: Int) {
        if section < numOfImportLevel {
            thingsToDo[section] = ToDoList.getTasksByImportLevel(importantLevel: section)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
