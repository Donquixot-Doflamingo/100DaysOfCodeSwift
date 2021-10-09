//
//  ToDoListTableViewController.swift
//  toDoList
//
//  Created by harsh Khandelwal on 13/09/21.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    var toDoCDs : [ToDoCD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getToDos()
    }
    
    func getToDos(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()){
                if let toDos = toDosFromCoreData as? [ToDoCD]{
                    toDoCDs = toDos
                    tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoCDs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let selectedToDo = toDoCDs[indexPath.row]
        if selectedToDo.priority == 1{
            if let name = selectedToDo.name{
                cell.textLabel?.text = "❗️ " + name
            }
        }
        else if selectedToDo.priority == 2{
            if let name = selectedToDo.name{
                cell.textLabel?.text = "‼️ " + name
            }
        }
        else{
            if let name = selectedToDo.name{
                cell.textLabel?.text = name
            }
        }
        
        return cell

        // Configure the cell...
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedToDo = toDoCDs[indexPath.row]
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
            if let selectedToDo = sender as? ToDoCD{
                detailsToDoViewController.toDoCD = selectedToDo
            }
        }
        
    }

}
