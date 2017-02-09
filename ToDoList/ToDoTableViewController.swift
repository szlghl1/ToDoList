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

public let numOfImportLevel:Int = 4

class ToDoTableViewController: UITableViewController {
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var thingsToDo:[[ThingToDo]] = Array(repeating: [ThingToDo](), count: numOfImportLevel)
    enum IdentifierOfCells: String {
        case BasicCell = "BasicCell"
        case TaskCell = "TaskCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //preloadTestData()
        fetchAll()
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAll()
        tableView.reloadData()
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
    
    func fetchAll() {
        for i in 0..<numOfImportLevel {
            
            let request:NSFetchRequest<ThingToDo> = ThingToDo.fetchRequest()
            
            
            //NSPredicates created with predicateWithBlock: cannot be used for Core Data fetch requests backed by a SQLite store.
            request.predicate = NSPredicate(format: "importantLevel = %d", i)
            
            let thingsInThisLevel = try! managedContext.fetch(request)
            thingsToDo[i] = thingsInThisLevel
        }
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
            if let thing = NSEntityDescription.insertNewObject(forEntityName: "ThingToDo", into: managedContext) as? ThingToDo {
                thing.title = "Task in level \(i)"
                thing.detail = "detail"
                thing.importantLevel = Int16(i)
                thing.deadline = NSDate(timeIntervalSinceNow: 20000)
                thing.group = Int16(i)
                thingsToDo[i].append(thing)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            managedContext.delete(thingsToDo[indexPath.section][indexPath.row])
            do {
                try managedContext.save()
            } catch {
                print("failed to save context in deleting")
            }
            thingsToDo[indexPath.section].remove(at: indexPath.row)
            //fetchSection(section: indexPath.section)
            tableView.reloadSections([indexPath.section], with: UITableViewRowAnimation.fade)
        }
    }
    
    //should be uncommented later when I want to add editing task funciton
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }

    func fetchSection(section: Int) {
        if section < numOfImportLevel {
            let request:NSFetchRequest<ThingToDo> = ThingToDo.fetchRequest()
            request.predicate = NSPredicate(format: "importantLevel = %d", section)
            do {
                try thingsToDo[section] = managedContext.fetch(request)
            } catch {
                print("failed to fetch section \(section)")
            }
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
