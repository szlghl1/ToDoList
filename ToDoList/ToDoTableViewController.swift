//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Ling He on 1/29/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import UIKit
import CoreData

public let numOfImportLevel:Int = 4

class ToDoTableViewController: UITableViewController {
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var thingsToDo:[[ThingToDo]] = Array(repeating: [ThingToDo](), count: numOfImportLevel)
    enum IdentifierOfCells: String {
        case BasicCell = "BasicCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preloadTestData()
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
        // #warning Incomplete implementation, return the number of sections
        return numOfImportLevel
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierOfCells.BasicCell.rawValue) ?? UITableViewCell(style: .value1, reuseIdentifier: IdentifierOfCells.BasicCell.rawValue)
        cell.textLabel?.text = thingsToDo[indexPath.section][indexPath.row].title
        cell.detailTextLabel?.text = thingsToDo[indexPath.section][indexPath.row].detail
        return cell
    }
    
    func fetchAll() {
        for i in 0..<numOfImportLevel {
            
            let request:NSFetchRequest<ThingToDo> = ThingToDo.fetchRequest()
            
            /*
            request.predicate = NSPredicate(block: { (thingToEvaluate: Any?, forgetIt: [String : Any]?) -> Bool in
                if let thing = thingToEvaluate as? ThingToDo {
                    return thing.importantLevel == Int16(i)
                } else {
                    return false
                }
            })
 */
            request.predicate = NSPredicate(format: "importantLevel = %d", i)
 
            
            let thingsInThisLevel = try! managedContext.fetch(request)
            thingsToDo[i] = thingsInThisLevel
        }
    }
    
    func preloadTestData() {
        for i in 0..<numOfImportLevel {
            if let thing = NSEntityDescription.insertNewObject(forEntityName: "ThingToDo", into: managedContext) as? ThingToDo {
                thing.title = "Task in level \(i)"
                thing.detail = "detail"
                thing.importantLevel = Int16(i)
                thingsToDo[i].append(thing)
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
