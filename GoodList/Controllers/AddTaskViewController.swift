//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by unthinkable-mac-0025 on 21/11/21.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {

    private let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable : Observable<Task>{
        return taskSubject.asObservable()
    }
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex), let taskTitle = taskTitleTextField.text else { return }
        
        let task = Task(title: taskTitle , priority: priority)
        taskSubject.onNext(task)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
