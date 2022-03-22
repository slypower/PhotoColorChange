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
    
    var viewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.layer.cornerRadius = 10
        
        viewController.backgroundColor = viewColor
        
        setSliders()
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }

    @IBAction func sliderChange(_ sender: UISlider) {
   
        switch sender {
            /* 21.03.2022
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
             */
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        }
        viewChangeColor()
    }
    
    @IBAction func pressDoneButton() {
        delegate?.setColor(viewController.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2F", slider.value)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redSlider)
            case greenTextField: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func viewChangeColor() {
        viewController.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                                 green: CGFloat(greenSlider.value),
                                                 blue: CGFloat(blueSlider.value),
                                                 alpha: 1)
    }
}

//MARK: UITextFieldDelegate
extension SettingViewController: UITextFieldDelegate {
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
     
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done, target: self, action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem (
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        guard let newValue = textField.text else {
            showAlert(title: "Oops!", message: "Incorrect value entered")
            return
        }
        
        guard let currentValue = Float(newValue) else {
            showAlert(title: "Oops!", message: "Incorrect value entered")
            return
        }
        
        if  currentValue <= 1.00  {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueLabel)
            }
            
            viewChangeColor()
            return
        }

            showAlert(title: "Oops!", message: "Incorrect value entered")

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
