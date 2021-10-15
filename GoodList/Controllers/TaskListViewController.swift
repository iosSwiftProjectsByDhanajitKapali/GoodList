//
//  ViewController.swift
//  GoodList
//
//  Created by daffolapmac-190 on 15/10/21.
//

import UIKit

class TaskListViewController: UIViewController {

    // MARK:  IBOutlets
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    

}

// MARK:  Lifecycle Methods
extension TaskListViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }

}

// MARK: UITableViewDelegate Methods
extension TaskListViewController : UITableViewDelegate{
    
}

// MARK: UITableViewDataSource
extension TaskListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCellID", for: indexPath)
        return cell
    }
    
    
}

