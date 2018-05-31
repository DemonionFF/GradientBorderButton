// MIT License

// Copyright (c) 2018 DemonionFF

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import UIKit

enum GradientButtonState {
    /// states will change accroding following/follower/requested
    case none, border, fill, borderGray
    
    var title: String {
        switch self {
        case .none:             return "None"
        case .border:           return "Border"
        case .fill:             return "Fill"
        case .borderGray:       return "Border Gray"
        }
    }
}

struct GradientButtonOptions {
    let borderWidth: CGFloat?
    let leftColor: UIColor?
    let rightColor: UIColor?
    let grayColor: UIColor?
    let cornerRadius: CGFloat?
    
    init(borderWidth: CGFloat? = nil, leftColor: UIColor? = nil, rightColor: UIColor? = nil, grayColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
        self.borderWidth = borderWidth
        self.leftColor = leftColor
        self.rightColor = rightColor
        self.grayColor = grayColor
        self.cornerRadius = cornerRadius
    }
}

class GradientBorderButton: UIButton {
    
    //MARK: - UI Properties
    private var gradientBorderWidth: CGFloat = 1
    private var gradientLeftColor: UIColor = .green
    private var gradientRightColor: UIColor = .yellow
    private var grayColor: UIColor = .lightGray
    private var cornerRadius: CGFloat = 0
    
    //MARK: - Layers
    private var gradientBorderLayer: CAGradientLayer?
    private var gradientLayer: CAGradientLayer?
    
    //MARK: - Button State
    fileprivate var gradientState: GradientButtonState = .border {
        didSet {
            updateStateVisually()
        }
    }
    
    //MARK: - Open State changer
    func update(state: GradientButtonState) {
        gradientState = state
    }
    
    func configure(with options: GradientButtonOptions) {
        gradientBorderWidth = options.borderWidth ?? gradientBorderWidth
        gradientLeftColor = options.leftColor ?? gradientLeftColor
        gradientRightColor = options.rightColor ?? gradientRightColor
        grayColor = options.grayColor ?? grayColor
        cornerRadius = options.cornerRadius ?? cornerRadius
        updateStateVisually()
    }
    
    //MARK: - View cycles
    override func layoutSubviews() {
        super.layoutSubviews()
        updateStateVisually()
    }
    
    //MARK: - redraw according state
    private func updateStateVisually() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = !(cornerRadius == 0)
        removeAllGradientLayers()
        switch gradientState {
        case .border:
            gradientBorderLayer = layer.addGradientBorder(lineWidth: gradientBorderWidth, leftColor: gradientLeftColor, rightColor: gradientRightColor)
        case .fill:
            gradientLayer = layer.addFillGradient(leftColor: gradientLeftColor, rightColor: gradientRightColor)
        case .borderGray:
            gradientBorderLayer = layer.addGradientBorder(lineWidth: gradientBorderWidth, leftColor: grayColor, rightColor: grayColor)
        case .none:
            removeAllGradientLayers()
        }
    }
    
    private func removeAllGradientLayers() {
        gradientBorderLayer?.removeFromSuperlayer()
        gradientBorderLayer = nil
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
    }
    
}
