//
//  SettingViewController.swift
//  PhotoColorChange
//
//  Created by Виталий Бобрик on 5.03.22.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var viewController: UIView!
   
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var red: Float = 0.0
    var green: Float = 0.0
    var blue: Float = 0.0
    
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.layer.cornerRadius = 10
        
        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
        
        viewChangeColor()
        setValue(for: redLabel, greenLabel, blueLabel)
    }

    @IBAction func sliderChange(_ sender: UISlider) {
        viewChangeColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    @IBAction func PressDoneButton() {
        view.endEditing(true)
        delegate.setColorBackround(with: redSlider.value,
                                   and: greenSlider.value,
                                   end: blueSlider.value)
        dismiss(animated: true)
    }
    
    @IBAction func interInTextVield(_ sender: UITextField) {
        guard let newValue = sender.text else {return}
        guard let numberValue = Float(newValue) else {return}
        
        if sender == redTextField {
            redSlider.value = numberValue
        } else if sender == greenTextField {
            greenSlider.value = numberValue
        } else {
            blueSlider.value = numberValue
        }
        viewChangeColor()
        setValue(for: redLabel, greenLabel, blueLabel)
    }
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2F", slider.value)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
                redTextField.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
                greenTextField.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
                blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func viewChangeColor() {
        let red = CGFloat(redSlider.value)*100
        let green = CGFloat(greenSlider.value)*100
        let blue = CGFloat(blueSlider.value)*100
        viewController.backgroundColor = UIColor(red: red/255,
                                                 green: green/255,
                                                 blue: blue/255,
                                                 alpha: 1)
    }
}
