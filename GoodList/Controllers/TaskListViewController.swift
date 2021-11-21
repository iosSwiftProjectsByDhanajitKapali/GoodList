//
//  ViewController.swift
//  GoodList
//
//  Created by daffolapmac-190 on 15/10/21.
//

import UIKit
import RxSwift
import RxRelay

class TaskListViewController: UIViewController {

    // MARK:  Private Data Members
    private let disposeBag = DisposeBag()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    // MARK:  IBOutlets
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func changedPrioritySegmentedControl(_ sender: UISegmentedControl) {
        let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
        
        filterTasks(by: priority)
    }
    
}

// MARK:  Lifecycle Methods
extension TaskListViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController, let addTaskVC = navC.viewControllers.first as? AddTaskViewController else {
                fatalError("Controller Not Found")
            }
        
        addTaskVC.taskSubjectObservable.subscribe(onNext: {
            task in
            //Get the current priority selected
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
            
            //Save the task
            self.tasks.accept(self.tasks.value + [task])
            
            self.filterTasks(by: priority)
            
        }).disposed(by: disposeBag)
    }

}


// MARK:  Private Methods
private extension TaskListViewController{
    
    func filterTasks(by priority : Priority?){
        
        if priority == nil{
            //Means "All" is selected
            self.filteredTasks = tasks.value
            
            //Display the Filtered Tasks
            print(self.filteredTasks)
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
            
        }else{
            //Filter the tasks
            self.tasks.map{ theTasks in
                return theTasks.filter{ $0.priority == priority! }
            }.subscribe(onNext: { [weak self]
                theFilteredTasks in
                self?.filteredTasks = theFilteredTasks
                
                //Display the Filtered Tasks
                print(self?.filteredTasks)
                DispatchQueue.main.async {
                    self?.myTableView.reloadData()
                }
                
            }).disposed(by: disposeBag)
        }
    }
}

// MARK: UITableViewDelegate Methods
extension TaskListViewController : UITableViewDelegate{
    
}

// MARK: UITableViewDataSource
extension TaskListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCellID", for: indexPath)
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        return cell
    }
    
    
}

