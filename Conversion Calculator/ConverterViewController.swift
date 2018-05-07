//
//  ConverterViewController.swift
//  Conversion Calculator
//
//  Created by Joe Timlin on 4/12/18.
//  Copyright © 2018 Joe Timlin. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var outputDisplayUnit: UITextField!
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    @IBOutlet weak var inputDisplayUnit: UITextField!
    
    var number: Double = 0
    var converted: Double = 0
    var currentConversion: Int = 0
    var sign = false
    var dotCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputDisplayUnit.text = conversions[0].outputUnit
        inputDisplayUnit.text = conversions[0].inputUnit
        self.inputDisplay.textAlignment = NSTextAlignment.right
        self.outputDisplay.textAlignment = NSTextAlignment.right
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clear(_ sender: UIButton)
    {
        outputDisplay.text = ""
        inputDisplay.text = ""
        sign = false
        number = 0
    }
    
    @IBAction func numberPressed(_ sender: UIButton)
    {
        if sender.tag != 20 {
            inputDisplay.text = inputDisplay.text! + String(sender.tag - 1)
            number = Double(inputDisplay.text!)!
            convert()
        }
        
        if sender.tag == 20 && dotCheck == false {
            inputDisplay.text = inputDisplay.text! + "."
            number = Double(inputDisplay.text!)!
            dotCheck = true
            convert()
        }
    }
    
    @IBAction func signChange(_ sender: UIButton) {
        if sign == false{
            number *=  -1
            sign = true;
            inputDisplay.text = "-" + inputDisplay.text!
        }
        else {
            number *= -1
            sign = false;
            inputDisplay.text = String(number)
        }
        convert()
        
    }
    struct ConversionType {
        let label: String?
        let inputUnit: String?
        let outputUnit: String?
    }
    
    let conversions = [
        ConversionType(label: "Fahrenheit to Celcius", inputUnit: "°F", outputUnit: "°C"),
        ConversionType(label: "Celcius to Fahrenheit", inputUnit: "°C", outputUnit: "°F"),
        ConversionType(label: "Miles to Kilometers", inputUnit: "mi", outputUnit: "km"),
        ConversionType(label: "Kilometers to Miles", inputUnit: "km", outputUnit: "mi"),
        ]
    
    
    @IBAction func converterTapped(_ sender: Any) {
        
        let converterAlertController = UIAlertController(title: nil, message: "Choose Converter", preferredStyle: .actionSheet)
        
        let fToC = UIAlertAction(title: conversions[0].label, style: .default) { action -> Void in
            self.outputDisplayUnit.text = self.conversions[0].outputUnit
            self.inputDisplayUnit.text = self.conversions[0].inputUnit
            self.currentConversion = 0
            self.convert()
        }
        let cToF = UIAlertAction(title: conversions[1].label, style: .default) { action -> Void in
            self.outputDisplayUnit.text = self.conversions[1].outputUnit
            self.inputDisplayUnit.text = self.conversions[1].inputUnit
            self.currentConversion = 1
            self.convert()
        }
        let miToKm = UIAlertAction(title: conversions[2].label, style: .default) { action -> Void in
            self.outputDisplayUnit.text = self.conversions[2].outputUnit
            self.inputDisplayUnit.text = self.conversions[2].inputUnit
            self.currentConversion = 2
            self.convert()
        }
        let kmToM = UIAlertAction(title: conversions[3].label, style: .default) { action -> Void in
            self.outputDisplayUnit.text = self.conversions[3].outputUnit
            self.inputDisplayUnit.text = self.conversions[3].inputUnit
            self.currentConversion = 3
            self.convert()
        }
        
        converterAlertController.addAction(fToC)
        converterAlertController.addAction(cToF)
        converterAlertController.addAction(miToKm)
        converterAlertController.addAction(kmToM)
        
        self.present(converterAlertController, animated: true, completion: nil)
    }
    
    func fToC(number: Double) -> Double{
        return ((number - 32) * (5/9))
    }
    
    func cToF(number: Double) -> Double{
        return (number * 9/5 + 32)
    }
    
    func kmToM(number: Double) -> Double{
        return (number * 0.621371)
    }
    
    func mToKm(number: Double) -> Double{
        return (number * 1.621371)
    }
    
    func convert() {
        
        switch(currentConversion){
            
        case 0:
            let celsius = fToC(number: number)
            outputDisplay.text = String(celsius)
            
        case 1:
            let farhenheit = cToF(number: number)
            outputDisplay.text = String(farhenheit)
            
        case 2:
            let kilometers = mToKm(number: number)
            outputDisplay.text = String(kilometers)
            
        case 3:
            let miles = kmToM(number: number)
            outputDisplay.text = String(miles)
            
        default:
            print("Error Occurred")
            break
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
