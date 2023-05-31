// MIT License

// Copyright (c) 2023 DemonionFF

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

open class GradientBorderButton: UIButton {
    
    public enum State {
        case none, border, fill
    }
    
    public enum Direction {
        case vertical, horizontal, custom(start: CGPoint, end: CGPoint)
        
        var startPoint: CGPoint {
            switch self {
            case .vertical:             return .init(x: 0.5, y: 0)
            case .horizontal:           return .init(x: 0, y: 0.5)
            case .custom(let start, _): return start
            }
        }
        
        var endPoint: CGPoint {
            switch self {
            case .vertical:             return .init(x: 0.5, y: 1)
            case .horizontal:           return .init(x: 1, y: 0.5)
            case .custom(_, let end):   return end
            }
        }
    }
    
    public struct Options {
        
        public let borderWidth: CGFloat?
        public let colors: [UIColor]
        public let cornerRadius: CGFloat?
        public let direction: Direction?
        
        public init(
            direction: Direction? = nil,
            borderWidth: CGFloat? = nil,
            colors: [UIColor] = [],
            cornerRadius: CGFloat? = nil
        ) {
            self.direction = direction
            self.borderWidth = borderWidth
            self.colors = colors
            self.cornerRadius = cornerRadius
        }
    }

    
    // MARK: - UI Properties
    
    private var gradientBorderWidth: CGFloat = 1
    private var colors: [UIColor] = [.systemGreen, .systemYellow]
    private var cornerRadius: CGFloat = .zero
    private var gradientDirection: Direction = .horizontal
    
    // MARK: - Layers
    
    private var gradientBorderLayer: CAGradientLayer?
    private var gradientLayer: CAGradientLayer?
    
    // MARK: - Button State
    
    private var gradientState: State = .border {
        didSet {
            guard oldValue != gradientState else { return }
            updateStateVisually()
        }
    }
    
    // MARK: - Open State changer
    
    open func update(state: State) {
        gradientState = state
    }
    
    open func configure(withOptions options: Options) {
        gradientBorderWidth = options.borderWidth ?? gradientBorderWidth
        colors = options.colors.isEmpty ? colors : options.colors
        cornerRadius = options.cornerRadius ?? cornerRadius
        gradientDirection = options.direction ?? gradientDirection
        updateStateVisually()
    }
    
    // MARK: - View cycles
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateStateVisually()
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        updateStateVisually()
    }
    
    // MARK: - Redraw according state
    
    private func updateStateVisually() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = !(cornerRadius == 0)
        removeAllGradientLayers()
        switch gradientState {
        case .border:
            gradientBorderLayer = layer.addGradientBorder(direction: gradientDirection, lineWidth: gradientBorderWidth, colors: colors)
        case .fill:
            gradientLayer = layer.addFillGradient(direction: gradientDirection, colors: colors)
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
