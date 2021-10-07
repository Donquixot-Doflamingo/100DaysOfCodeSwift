//
//  ViewController.swift
//  colorConverterApp
//
//  Created by harsh Khandelwal on 16/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    @IBOutlet weak var alphaTextField: UITextField!
    @IBOutlet weak var conversionButton: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!
    
    enum Conversion {
        case RGBToHex
        case HexToRGB
    }
    
    var conversion : Conversion = .HexToRGB
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            conversion = .HexToRGB
            conversionButton.setTitle("Convert Hex To RGB", for: .normal)
        case 1:
            conversion = .RGBToHex
            conversionButton.setTitle("Convert RGB  To Hex", for: .normal)
        default:
            conversion = .HexToRGB
            conversionButton.setTitle("Convert Hex To RGB", for: .normal)
        }
        
        print(conversion)
        
        redTextField.text?.removeAll()
        greenTextField.text?.removeAll()
        blueTextField.text?.removeAll()
        alphaTextField.text?.removeAll()
        resultsLabel.text?.removeAll()
    }
    
    func HexToRGB() -> UIColor?{
        guard let redText = UInt8(redTextField.text!, radix: 16) else {
            print("Invalid Input")
            return nil
        }
        guard let greenText = UInt8(greenTextField.text!, radix: 16) else {
            print("Invalid Input")
            return nil
        }
        guard let blueText = UInt8(blueTextField.text!, radix: 16) else {
            print("Invalid Input")
            return nil
        }
        guard let alphaText = Float(alphaTextField.text!) else {
            print("Invalid Input")
            return nil
        }
        if alphaText > 1 || alphaText < 0 {
            return nil
        }
        print("text selected: \(redText) , \(greenText) , \(blueText) , \(alphaText) ")
        resultsLabel.text = "Red : \(redText) \nGreen : \(greenText) \nBlue : \(blueText) \nAlpha : \(alphaText)"
        let backgroundColor = UIColor(red: CGFloat(redText) / 255, green: CGFloat(greenText) / 255, blue: CGFloat(blueText) / 255, alpha: CGFloat(alphaText))
        
        return backgroundColor
    }
    
    func RGBToHex() -> UIColor?{
        guard let redText = UInt8(redTextField.text!) else {
            print("Invalid Input")
            return nil
        }
        guard let greenText = UInt8(greenTextField.text!) else {
            print("Invalid Input")
            return nil
        }
        guard let blueText = UInt8(blueTextField.text!) else {
            print("Invalid Input")
            return nil
        }
        guard let alphaText = Float(alphaTextField.text!) else {
            print("Invalid Input")
            return nil
        }
        if alphaText > 1 || alphaText < 0 {
            return nil
        }
        
        let redString = String(format: "%2X", redText)
        let greenString = String(format: "%2X", greenText)
        let blueString = String(format: "%2X", blueText)
        
        print("Hex Code : #\(redString)\(greenString)\(blueString) /nAlpha : \(alphaText) ")
        resultsLabel.text = "Hex Code : #\(redString)\(greenString)\(blueString) \nAlpha : \(alphaText) "
        let backgroundColor = UIColor(red: CGFloat(redText) / 255, green: CGFloat(greenText) / 255, blue: CGFloat(blueText) / 255, alpha: CGFloat(alphaText))
        
        return backgroundColor
    }
    
    @IBAction func convertAction(_ sender: UIButton) {
        
        switch conversion {
        case .HexToRGB:
            self.view.backgroundColor = HexToRGB()
        
        case .RGBToHex:
            self.view.backgroundColor = RGBToHex()
        }
        
    }
}

