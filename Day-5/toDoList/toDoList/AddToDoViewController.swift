//
//  AddToDoViewController.swift
//  toDoList
//
//  Created by harsh Khandelwal on 13/09/21.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    var toDoTableViewController: ToDoListTableViewController?=nil

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        let newToDo = ToDo()
        newToDo.priority = prioritySegment.selectedSegmentIndex
        if let name = nameTextField.text {
            newToDo.name = name
        }
        toDoTableViewController?.todos.append(newToDo)
        toDoTableViewController?.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    

}
