//
//  ViewController.swift
//  Task
//
//  Created by Caleb Hicks on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ButtonTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: Tableview data source methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedTaskController.taskArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as! ButtonTableViewCell
        let task = TaskController.sharedTaskController.taskArray[indexPath.row]
        cell.updateWithTask(task)
        cell.delegate = self
        return cell
    }
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        if let indexPath = tableView.indexPathForCell(sender) {
        let task = TaskController.sharedTaskController.taskArray[indexPath.row]
            if task.isComplete.boolValue {
                task.isComplete = false
            }else {
                task.isComplete = true
            }
        sender.updateWithTask(task)
        TaskController.sharedTaskController.save()
        tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            tableView.beginUpdates()
            TaskController.sharedTaskController.removeTask(indexPath)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.endUpdates()
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editExistingTask" {
            if let destination = segue.destinationViewController as? TaskDetailViewController {
                guard let cell = sender as? UITableViewCell,
                 let indexPath = tableView.indexPathForCell(cell) else {return}
                destination.task = TaskController.sharedTaskController.taskArray[indexPath.row]
                destination.taskIndex = indexPath.row
                
                //                _ = destination.loadView()
//                guard let cell = sender as? UITableViewCell,
//                    let indexPath = tableView.indexPathForCell(cell) else {return}
//                destination.updateWithTask(indexPath.row)
            }
        }
    }


}

