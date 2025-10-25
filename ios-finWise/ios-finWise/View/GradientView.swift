//
//  GradientView.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//

import UIKit

class GradientView: UIView {
    private var decorativeShapes: [CAShapeLayer] = []
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func setupGradient() {
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor(red: 0.85, green: 0.88, blue: 0.98, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        addDecorativeShapes()
        animateShapes()
    }

    private func animateShapes() {
        decorativeShapes.forEach { shape in
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.fromValue = 0
            animation.toValue = 20
            animation.duration = 4.0
            animation.autoreverses = true
            animation.repeatCount = .infinity
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            shape.add(animation, forKey: "float")
        }
    }
    
    private func addDecorativeShapes() {
        // Clear existing shapes
        decorativeShapes.forEach { $0.removeFromSuperlayer() }
        decorativeShapes.removeAll()
        
        // Top left rounded rectangle
        let topLeftShape = createRoundedRectangle(
            size: CGSize(width: 150, height: 150),
            cornerRadius: 30
        )
        topLeftShape.frame.origin = CGPoint(x: -50, y: 500)
        topLeftShape.transform = CATransform3DMakeRotation(.pi / 6, 0, 0, 1)
        layer.addSublayer(topLeftShape)
        decorativeShapes.append(topLeftShape)
        
        // Bottom right rounded rectangle
        let bottomRightShape = createRoundedRectangle(
            size: CGSize(width: 200, height: 200),
            cornerRadius: 40
        )
        bottomRightShape.frame.origin = CGPoint(x: bounds.width - 100, y: bounds.height - 250)
        bottomRightShape.transform = CATransform3DMakeRotation(-.pi / 8, 0, 0, 1)
        layer.addSublayer(bottomRightShape)
        decorativeShapes.append(bottomRightShape)
    }
    
    private func createRoundedRectangle(size: CGSize, cornerRadius: CGFloat) -> CAShapeLayer {
        let shape = CAShapeLayer()
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: cornerRadius)
        shape.path = path.cgPath
        shape.fillColor = UIColor(white: 1.0, alpha: 0.3).cgColor
        shape.bounds = CGRect(origin: .zero, size: size)
        return shape
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Recreate shapes when view size changes
        if !decorativeShapes.isEmpty {
            addDecorativeShapes()
            animateShapes()
        }
    }
}


