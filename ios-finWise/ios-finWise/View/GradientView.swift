//
//  GradientView.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//
import UIKit

class GradientView: UIView {
    private var decorativeShapes: [CALayer] = []
    
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
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        addDecorativeShapes()
        animateShapes()
    }

    private func animateShapes() {
        decorativeShapes.forEach { shape in
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.fromValue = 0
            animation.toValue = 50
            animation.duration = 3.0
            animation.autoreverses = true
            animation.repeatCount = .infinity
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            shape.add(animation, forKey: "float")
        }
    }
    
    private func addDecorativeShapes() {
        decorativeShapes.forEach { $0.removeFromSuperlayer() }
        decorativeShapes.removeAll()
        
        // Top left shape - subtle
        addShape(
            size: CGSize(width: 120, height: 120),
            position: CGPoint(x: 40, y: 180),
            cornerRadius: 30,
            rotation: 20,
            color: UIColor(red: 0.75, green: 0.8, blue: 0.95, alpha: 0.25)
        )
        
        // Bottom right shape - more visible
        addShape(
            size: CGSize(width: 160, height: 160),
            position: CGPoint(x: bounds.width - 60, y: bounds.height - 180),
            cornerRadius: 40,
            rotation: -15,
            color: UIColor(red: 0.7, green: 0.75, blue: 0.9, alpha: 0.3)
        )
    }
    
    private func addShape(size: CGSize, position: CGPoint, cornerRadius: CGFloat, rotation: CGFloat, color: UIColor) {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: cornerRadius)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = color.cgColor
        shapeLayer.bounds = CGRect(origin: .zero, size: size)
        shapeLayer.position = position
        shapeLayer.transform = CATransform3DMakeRotation(rotation * .pi / 180, 0, 0, 1)
        
        layer.insertSublayer(shapeLayer, at: 1)
        decorativeShapes.append(shapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !decorativeShapes.isEmpty {
            addDecorativeShapes()
            animateShapes()
        }
    }
}

#Preview{
    GradientView()
}
