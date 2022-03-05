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
    
    private func textForLabel() {
        redLabel.text = String(round(redSlider.value*100)/100)
        greenLabel.text = String(round(greenSlider.value*100)/100)
        blueLabel.text = String(round(blueSlider.value*100)/100)
    }
    private func textForLabelRed() {
        redLabel.text = String(round(redSlider.value*100)/100)
    }
    
    private func textForLabelGreen() {
        greenLabel.text = String(round(greenSlider.value*100)/100)
    }
    
    private func textForLabelBlue() {
        blueLabel.text = String(round(blueSlider.value*100)/100)
    }
    
    private func viewChangeColor() {
        let red = CGFloat(redSlider.value)*100
        let green = CGFloat(greenSlider.value)*100
        let blue = CGFloat(blueSlider.value)*100
        viewController.backgroundColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.layer.cornerRadius = 10
        
        textForLabel()
        viewChangeColor()
    }

    @IBAction func redSliderChange() {
        textForLabel()
        viewChangeColor()
    }
    
    @IBAction func greenSliderChange() {
        textForLabel()
        viewChangeColor()
    }
    
    @IBAction func blueSliderChange() {
        textForLabel()
        viewChangeColor()
    }
    
}

