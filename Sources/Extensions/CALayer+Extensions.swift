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

extension CALayer {
    
    enum GradientDirection {
        case vertical, horizontal
        
        var startPoint: CGPoint {
            switch self {
            case .vertical:             return CGPoint(x: 0.5, y: 0)
            case .horizontal:           return CGPoint(x: 0, y: 0.5)
            }
        }
        
        var endPoint: CGPoint {
            switch self {
            case .vertical:             return CGPoint(x: 0.5, y: 1)
            case .horizontal:           return CGPoint(x: 1, y: 0.5)
            }
        }
    }
    
    @discardableResult
    func addGradientBorder(direction: CALayer.GradientDirection, lineWidth: CGFloat, colors: [UIColor]) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        gradientLayer.colors = colors.map{$0.cgColor}
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = lineWidth
        let movedPath = CGRect(x: shapeLayer.lineWidth / 2 , y: shapeLayer.lineWidth / 2, width: bounds.size.width - shapeLayer.lineWidth, height: bounds.size.height - shapeLayer.lineWidth)
        ///Preventing top left empty corner
        ///Underthehood calculations are different
        if cornerRadius == 0 {
            shapeLayer.path = UIBezierPath(rect: movedPath).cgPath
        } else {
            shapeLayer.path = UIBezierPath(roundedRect: movedPath, cornerRadius: cornerRadius).cgPath
        }
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.white.cgColor
        gradientLayer.mask = shapeLayer
        insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    @discardableResult
    func addFillGradient(direction: CALayer.GradientDirection = .horizontal, colors: [UIColor]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        gradientLayer.colors = colors.map{$0.cgColor}
        insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
}
