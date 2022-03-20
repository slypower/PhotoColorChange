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
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
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
        guard let numberValue = Float(newValue) else {
            showAlert(title: "Oops!", message: "Incorrect value entered")
            return}
        
        if numberValue > 1 {
            showAlert(title: "Oops!", message: "Incorrect value entered")
            return
        }
        
        /*
        // Почему не реализовывать так, а нужно через delegate
        if sender == redTextField {
            redSlider.value = numberValue
        } else if sender == greenTextField {
            greenSlider.value = numberValue
        } else {
            blueSlider.value = numberValue
        }
        viewChangeColor()
        setValue(for: redLabel, greenLabel, blueLabel)
         */
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

//MARK: UITextFieldDelegate
extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField)
        guard let newValue = textField.text else {return}
        guard let numberValue = Float(newValue) else {return}
        
        if textField == redTextField {
            redSlider.value = numberValue
        } else if textField == greenTextField {
            greenSlider.value = numberValue
        } else {
            blueSlider.value = numberValue
        }
        viewChangeColor()
        setValue(for: redLabel, greenLabel, blueLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == redTextField {
            greenTextField.becomeFirstResponder()
        } else if textField == greenTextField {
            blueTextField.becomeFirstResponder()
        } else {
            PressDoneButton()
        }
        return true
    }
    
}

//MARK: - Alert Controller
extension SettingViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
