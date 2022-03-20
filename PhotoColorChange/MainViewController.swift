//
//  MainViewController.swift
//  PhotoColorChange
//
//  Created by Виталий Бобрик on 20.03.22.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColorBackround(with red: Float, and green: Float, end blue: Float)
}

class MainViewController: UIViewController {

    var red: Float = 0.5
    var green: Float = 0.5
    var blue: Float = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorBackround(with: red, and: green, end: blue)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVS = segue.destination as? SettingViewController else {return}
        settingsVS.delegate = self
        
        settingsVS.red = red
        settingsVS.green = green
        settingsVS.blue = blue

    }
    
    private func viewChangeColor(with red: Float, and green: Float, end blue: Float) {
        self.red = red
        self.green = green
        self.blue = blue
        view.backgroundColor = UIColor(red: CGFloat(red)*100/255,
                                       green: CGFloat(green)*100/255,
                                       blue: CGFloat(blue)*100/255,
                                       alpha: 1)
    }
}

//MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setColorBackround(with red: Float, and green: Float, end blue: Float) {
        viewChangeColor(with: red, and: green, end: blue)
    }
    
}
