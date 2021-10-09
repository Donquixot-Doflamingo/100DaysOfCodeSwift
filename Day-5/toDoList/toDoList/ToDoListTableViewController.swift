//
//  ToDoListTableViewController.swift
//  toDoList
//
//  Created by harsh Khandelwal on 13/09/21.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    var todos : [ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toDo1 = ToDo()
        toDo1.name = "Write chapter one of iOS 13 book"
        toDo1.priority = 0
        
        let toDo2 = ToDo()
        toDo2.name = "Edit iOS 13 book"
        toDo2.priority = 1
        
        todos = [toDo1,toDo2]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let selectedToDo = todos[indexPath.row]
        
        if selectedToDo.priority == 1{
            cell.textLabel?.text = "❗️ " + selectedToDo.name
        }
        else if selectedToDo.priority == 2{
            cell.textLabel?.text = "‼️ " + selectedToDo.name
        }
        else{
            cell.textLabel?.text = selectedToDo.name
        }
        
        return cell

        // Configure the cell...
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedToDo = todos[indexPath.row]
        performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let addToDoViewController = segue.destination as? AddToDoViewController{ addToDoViewController.toDoTableViewController = self
        }
        
        if let detailsToDoViewController = segue.destination as? ToDoDetailsViewController{
            if let selectedToDo = sender as? ToDo{
                detailsToDoViewController.toDo = selectedToDo
            }
        }
        
    }

}
