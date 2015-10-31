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
    @IBOutlet weak var dateCancelButton: UIButton!
    @IBOutlet var dateCancelHeightConstraint: NSLayoutConstraint!
    
    var task: Task?
    var taskIndex: Int?
    var dateAdded = false

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .ShortStyle
        dateButton.setTitle(formatter.stringFromDate(datePicker.date), forState: .Normal)
        dateDisplayedView()
        taskTitleTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
        datePicker.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.addTarget(self, action: "datePickerChanged", forControlEvents: .ValueChanged)
        dateDisplayedView()
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
        dateCancelButton.hidden = true
        datePicker.hidden = false
        dateButtonHeightConstraint.active = false
        dateCancelHeightConstraint.active = false
        datePickerHeightConstraint.active = true
    }
    
    func dateDisplayedView() {
        if dateAdded{
            dateButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            dateButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 15.0)
            dateCancelButton.hidden = false
            dateCancelHeightConstraint.active = true
        } else {
            dateButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            dateButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12.0)
            dateCancelButton.hidden = true
            dateCancelHeightConstraint.active = false
        }
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
    
    @IBAction func dateCancelButtonTapped(sender: AnyObject) {
        dateAdded = false
        dateDisplayedView()
        dateButton.setTitle("Add due date", forState: .Normal)
    }
    
    // MARK: Save and cancel
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        guard let title = taskTitleTextField.text where
            taskTitleTextField.text != "" else {
                noTitleAlert()
                return
        }
        
        guard let task = task else {return}
        
        if dateAdded {
            task.dueDate = datePicker.date
        } else {
            task.dueDate = nil
        }
        
        task.notes = notesTextView.text
        
        task.title = title
        
        TaskController.sharedTaskController.save()
        
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









