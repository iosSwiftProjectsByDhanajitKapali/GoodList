//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by unthinkable-mac-0025 on 21/11/21.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex), let taskTitle = taskTitleTextField.text else { return }
        
        let task = Task(title: taskTitle , priority: priority)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
    }
    

}
