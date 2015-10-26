//
//  TaskDetailViewController.swift
//  Task
//
//  Created by James Pacheco on 10/23/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dateButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet var datePickerHeightConstraint: NSLayoutConstraint!
    
    var task: Task?
    var taskIndex: Int?
    var dateAdded = false

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .ShortStyle
        dateButton.setTitle(formatter.stringFromDate(datePicker.date), forState: .Normal)
        dateDisplayedView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.addTarget(self, action: "datePickerChanged", forControlEvents: .ValueChanged)
        datePickerHeightConstraint.active = false
        dateButtonHeightConstraint.active = true
        if let task = task {
            updateWithTask(task)
        }
        
        datePicker.minimumDate = NSDate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: View updating
    
    func textViewDidBeginEditing(textView: UITextView) {
        dateDisplayedView()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        dateDisplayedView()
    }
    
    func datePickerView() {
        dateButton.hidden = true
        datePicker.hidden = false
        dateButtonHeightConstraint.active = false
        datePickerHeightConstraint.active = true
    }
    
    func dateDisplayedView() {
        dateButton.hidden = false
        datePicker.hidden = true
        dateButtonHeightConstraint.active = true
        datePickerHeightConstraint.active = false
    }
    
    func datePickerChanged() {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .ShortStyle
        dateButton.setTitle(formatter.stringFromDate(datePicker.date), forState: .Normal)
    }
    
    @IBAction func dueDateButtonPressed(sender: AnyObject) {
        datePickerView()
        dateAdded = true
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .ShortStyle
        dateButton.setTitle(formatter.stringFromDate(datePicker.date), forState: .Normal)
    }
    
    func updateWithTask(task: Task) {
        taskTitleTextField.text = task.title
        
        if let notes = task.notes {
            notesTextView.text = notes
        }
        if let dueDate = task.dueDate {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .ShortStyle
            dateButton.setTitle(formatter.stringFromDate(dueDate), forState: .Normal)
        } else {
            dateButton.setTitle("Add due date", forState: .Normal)
        }
    }
    
    // MARK: Save and cancel
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        guard let title = taskTitleTextField.text where
                taskTitleTextField.text != "" else {
            noTitleAlert()
            return
        }
        
        if let taskNumber = taskIndex {
            let newTask = TaskController.sharedTaskController.taskArray[taskNumber]
            if dateAdded {
                newTask.dueDate = datePicker.date
            }
            
            newTask.notes = notesTextView.text
            
            newTask.title = taskTitleTextField.text!

            TaskController.sharedTaskController.save()
        } else {
            let newTask = Task(title: title, dueDate: nil, notes: nil)
            
            if dateAdded {
                newTask.dueDate = datePicker.date
            }
            
                newTask.notes = notesTextView.text
            

            TaskController.sharedTaskController.addTask(newTask)
        }
        self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        taskIndex = nil
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        taskIndex = nil
    }
    
    func noTitleAlert() {
        let noTitleAlert = UIAlertController(title: "No title", message: "Cannot save task without title.", preferredStyle: .Alert)
        noTitleAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        presentViewController(noTitleAlert, animated: true, completion: nil)
    }

}









