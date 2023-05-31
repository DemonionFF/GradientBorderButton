# GradientBorderButton
Button with gradient border or fill.


`GradientBorderButton` is a Swift library which can help you avoid some boilerplate code.

Main features:
- Gradient border color for button
- Dark Mode support
- Custom gradient direction 

|Fill|Border|
|-|-|
|<img width="352" alt="Screenshot 2023-05-31 at 14 47 40" src="https://github.com/DemonionFF/GradientBorderButton/assets/21122119/706f384e-366c-4a87-84de-19b0694bfd19">|<img width="352" alt="Screenshot 2023-05-31 at 14 47 54" src="https://github.com/DemonionFF/GradientBorderButton/assets/21122119/f1cc5c57-25ab-40bc-9966-6a095ca7a334">|

![Simulator Screen Recording - iPhone 14 Pro](https://github.com/DemonionFF/GradientBorderButton/assets/21122119/99c0becf-1d91-4ccc-8427-c0f0b406a166)

## Installation

#### Manually
1. Download and drop ```Sources``` folder in your project.  
2. Congratulations!

## Usage example

1. Using storyboard, just set class of your button to ```GradientBorderButton```
2. Programmatically 
```swift
let gradientButton = GradientBorderButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
view.addSubview(gradientButton)
```

## Default values

* BorderWidth = 1
* Colors = [.systemGreen, .systemYellow]
* CornerRadius = .zero
* Direction = .horizontal

## Customization

1. Available ```GradientButtonState```'s: ```.none```, ```.fill```, ```.border```
```swift
yourGradientBorderButton.update(state: .fill)
```
2. Using ```GradientButtonOptions```


Available parameters: 
* direction
* borderWidth
* colors
* cornerRadius

Instantiate your options and pass them to button.
```swift
let options = GradientButtonOptions(borderWidth: 4)
yourGradientBorderButton.configure(with: options)
```

## Note

Each update with ```GradientButtonOptions``` updates only options you passed in.


## Meta

Distributed under the MIT license. See ``LICENSE`` for more information.
