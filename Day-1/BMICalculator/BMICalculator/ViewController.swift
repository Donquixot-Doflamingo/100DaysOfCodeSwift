//
//  ViewController.swift
//  BMICalculator
//
//  Created by harsh Khandelwal on 10/09/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightInput: UITextField!
    
    @IBOutlet weak var heightInput: UITextField!
    
    @IBOutlet weak var BMIValue: UILabel!
    
    @IBOutlet weak var BMIResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateBMI(_ sender: UIButton) {
        guard let height = Double(heightInput.text!)else{
            BMIResult.text = "wrong or no input"
            return
        }
        guard let weight = Double(weightInput.text!)else{
            BMIResult.text = "wrong or no input"
            return
        }
        let BMI = weight / (height * height)
        var classification : String
        if(BMI<18.5){
            classification = "Underweight"
        }
        else if(BMI<24.9){
            classification = "Healthy weight"
        }
        else if(BMI<29.9){
            classification = "overweight"
        }
        else{
            classification = "obese"
        }
        let formatedBMI = String(format: "%.1f",BMI)
        BMIValue.text = formatedBMI
        BMIResult.text = "BMI  \(formatedBMI)  \(classification)"
    }
    
    

}

