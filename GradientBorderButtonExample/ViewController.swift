//  Copyright © 2023 DA. All rights reserved.

import UIKit

final class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var updateButton: GradientBorderButton!
    @IBOutlet private weak var borderWidthLabel: UILabel!
    @IBOutlet private weak var cornerRadiusLabel: UILabel!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    
    @IBAction private func updateButtonAction(_ sender: GradientBorderButton) {
        presentOptionsActionSheet()
    }
    
    @IBAction private func borderWidthSliderAction(_ sender: UISlider) {
        updateButton.configure(withOptions: .init(borderWidth: CGFloat(Int(sender.value))))
        borderWidthLabel.text = "Border width: \(Int(sender.value))"
    }
    
    @IBAction private func directionSegmentControlAction(_ sender: UISegmentedControl) {
        let direction: GradientBorderButton.Direction
        switch sender.selectedSegmentIndex {
        case 0:
            direction = .horizontal
        case 1:
            direction = .vertical
        default:
            direction = .horizontal
        }
        updateButton.configure(withOptions: .init(direction: direction))
    }
    
    @IBAction private func cornerRadiusSliderAction(_ sender: UISlider) {
        updateButton.configure(withOptions: .init(cornerRadius: CGFloat(Int(sender.value))))
        cornerRadiusLabel.text = "Corner radius: \(Int(sender.value))"
    }
    
    private func update(state: GradientBorderButton.State) {
        updateButton.update(state: state)
    }
    
    private func presentOptionsActionSheet() {
        let alert = UIAlertController(title: nil, message: "Select option", preferredStyle: .actionSheet)
        
        let actionNone = UIAlertAction(title: GradientBorderButton.State.none.title, style: .default) { [weak self] _ in
            self?.update(state: .none)
        }
        let actionFill = UIAlertAction(title: GradientBorderButton.State.fill.title, style: .default) { [weak self] _ in
            self?.update(state: .fill)
        }
        let actionBroder = UIAlertAction(title: GradientBorderButton.State.border.title, style: .default) { [weak self] _ in
            self?.update(state: .border)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(actionNone)
        alert.addAction(actionFill)
        alert.addAction(actionBroder)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extensions

extension GradientBorderButton.State {
    
    var title: String {
        switch self {
        case .none:             return "None"
        case .border:           return "Border"
        case .fill:             return "Fill"
        }
    }
}
