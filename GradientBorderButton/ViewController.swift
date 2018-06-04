//
//  ViewController.swift
//  GradientBorderButton
//
//  Created by DemonionFF on 5/30/18.
//  Copyright © 2018 DemonionFF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var updateButton: GradientBorderButton!
    @IBOutlet private weak var borderWidthLabel: UILabel!
    @IBOutlet private weak var cornerRadiusLabel: UILabel!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Actions
    @IBAction private func updateButtonAction(_ sender: GradientBorderButton) {
        presentOptionsActionSheet()
    }
    
    @IBAction private func borderWidthSliderAction(_ sender: UISlider) {
        updateButton.configure(with: GradientButtonOptions(borderWidth: CGFloat(Int(sender.value))))
        borderWidthLabel.text = "Border width: \(Int(sender.value))"
    }
    
    @IBAction private func directionSegmentControlAction(_ sender: UISegmentedControl) {
        let direction: CALayer.GradientDirection
        switch sender.selectedSegmentIndex {
        case 0:
            direction = .horizontal
        case 1:
            direction = .vertical
        default:
            direction = .horizontal
        }
        updateButton.configure(with: GradientButtonOptions(direction: direction))
    }
    
    @IBAction private func cornerRadiusSliderAction(_ sender: UISlider) {
        updateButton.configure(with: GradientButtonOptions(cornerRadius: CGFloat(Int(sender.value))))
        cornerRadiusLabel.text = "Corner radius: \(Int(sender.value))"
    }
    
    private func update(with state: GradientButtonState) {
        updateButton.update(state: state)
    }
    
    private func presentOptionsActionSheet() {
        let alert = UIAlertController(title: nil, message: "Select option", preferredStyle: .actionSheet)
        
        let actionNone = UIAlertAction(title: GradientButtonState.none.title, style: .default) { (_) in
            self.update(with: .none)
        }
        let actionFill = UIAlertAction(title: GradientButtonState.fill.title, style: .default) { (_) in
            self.update(with: .fill)
        }
        let actionBroder = UIAlertAction(title: GradientButtonState.border.title, style: .default) { (_) in
            self.update(with: .border)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(actionNone)
        alert.addAction(actionFill)
        alert.addAction(actionBroder)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
}

