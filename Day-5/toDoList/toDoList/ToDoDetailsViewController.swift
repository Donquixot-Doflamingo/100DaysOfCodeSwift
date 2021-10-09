//
//  ToDoDetailsViewController.swift
//  toDoList
//
//  Created by harsh Khandelwal on 13/09/21.
//

import UIKit

class ToDoDetailsViewController: UIViewController {
    
    var toDo = ToDo()
    
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if toDo.priority == 1{
            toDoLabel.text = "❗️ " + toDo.name
        }
        else if toDo.priority == 2{
            toDoLabel.text = "‼️ " + toDo.name
        }
        else{
            toDoLabel.text = toDo.name
        }
        // Do any additional setup after loading the view.
    }

}
