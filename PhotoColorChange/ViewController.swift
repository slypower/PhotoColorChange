//
//  ViewController.swift
//  PhotoColorChange
//
//  Created by Виталий Бобрик on 5.03.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var viewController: UIView!
   
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.layer.cornerRadius = 10
        
        viewChangeColor()
        setValue(for: redLabel, greenLabel, blueLabel)
    }

    @IBAction func sliderChange(_ sender: UISlider) {
        viewChangeColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
        }
    }
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2F", slider.value)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
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

