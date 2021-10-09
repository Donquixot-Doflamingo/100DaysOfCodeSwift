//
//  ToDoDetailsViewController.swift
//  toDoList
//
//  Created by harsh Khandelwal on 13/09/21.
//

import UIKit

class ToDoDetailsViewController: UIViewController {
    
    var toDoCD : ToDoCD? = nil
    
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toDo = toDoCD {
            if toDo.priority == 1{
                if let name = toDo.name{
                    toDoLabel.text = "❗️ " + name
                }
            }
            else if toDo.priority == 2{
                if let name = toDo.name{
                    toDoLabel.text = "‼️ " + name
                }
            }
            else{
                if let name = toDo.name{
                    toDoLabel.text = name
                }
            }
            if let data = toDo.image{
                imageView?.image = UIImage(data:data)
            }
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func doneTapped(_ sender: Any) {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        if let toDo = toDoCD{
            context.delete(toDo)
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    navigationController?.popViewController(animated: true)
    }
}
