


import UIKit

class NewTaskTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var addDetailsButton: UIButton!
    @IBOutlet weak var taskTextField: UITextField!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        taskTextField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        addDetailsButton.hidden = false
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addTask()
        return false
    }
    
    @IBAction func addDetailsButtonTapped(sender: AnyObject) {
        addTask()
        NSNotificationCenter.defaultCenter().postNotificationName("addDetails", object: self)
    }
    
    func addTask() {
        if let title = taskTextField.text where title.characters.count > 0 {
            let task = Task(title: title)
            TaskController.sharedTaskController.addTask(task)
            addDetailsButton.hidden = true
            taskTextField.text = ""
            taskTextField.resignFirstResponder()
            TaskController.sharedTaskController.taskArray.sort {$0.dateCreated.compare($1.dateCreated) == NSComparisonResult.OrderedAscending}
            TaskController.sharedTaskController.save()
            NSNotificationCenter.defaultCenter().postNotificationName("taskAdded", object: self)
        } else {
            taskTextField.resignFirstResponder()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
