//
//  MainViewController.swift
//  PhotoColorChange
//
//  Created by Виталий Бобрик on 20.03.22.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVS = segue.destination as? SettingViewController else {return}
        settingsVS.delegate = self
        settingsVS.viewColor = view.backgroundColor
    }
}

//MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
