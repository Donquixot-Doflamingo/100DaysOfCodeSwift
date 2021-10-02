//
//  ViewController.swift
//  Calculator
//
//  Created by harsh Khandelwal on 16/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputArea: UITextField!
    @IBOutlet weak var outputArea: UILabel!
    
    var input1 : Double? = 0
    var input2 : Double? = 0
    
    enum Opeation {
        case addition
        case subtraction
        case multiplication
        case division
    }
    
    var opeationChoosen : Opeation = Opeation.addition
    
    func storeInput(inputNumber : inout Double?) {
        guard let inputText = inputArea.text else {
            print("Invalid Input")
            return
        }
        inputNumber = Double(inputText)
        inputArea.text?.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clearButton(_ sender: UIButton) {
        var input1 = 0
        var input2 = 0
        inputArea.text?.removeAll()
        outputArea.text = "Answer"
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        opeationChoosen = .addition
        storeInput(inputNumber: &input1)
    }
    
    @IBAction func subButton(_ sender: UIButton) {
        opeationChoosen = .subtraction
        storeInput(inputNumber: &input1)
    }
    
    @IBAction func mulButton(_ sender: UIButton) {
        opeationChoosen = .multiplication
        storeInput(inputNumber: &input1)
    }
    
    @IBAction func divideButton(_ sender: UIButton) {
        opeationChoosen = .division
        storeInput(inputNumber: &input1)
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        storeInput(inputNumber: &input2)
        
        guard let input_1 = input1 else {
            print("Invalid Input 1")
            return
        }
        guard let input_2 = input2 else {
            print("Invalid Input 2")
            return
        }
        
        var answer : Double = 0
        switch opeationChoosen {
        case .addition:
            answer = input_1 + input_2
        case .subtraction:
            answer = input_1 - input_2
        case .multiplication:
            answer = input_1 * input_2
        case .division:
            answer = input_1 / input_2
        }
        outputArea.text = String(answer)
    }
}

