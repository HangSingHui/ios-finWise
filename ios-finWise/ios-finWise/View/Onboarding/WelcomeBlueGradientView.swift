//
//  WelcomeGradientView.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 29/10/25.
//


import UIKit

class WelcomeGradientView: UIView {
    private var decorativeShapes: [CALayer] = []

    // Use gradient layer as base
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    func setupGradient() {
        // Blue gradient background
        gradientLayer.colors = [
            UIColor(red: 0.65, green: 0.78, blue: 0.98, alpha: 1.0).cgColor, // top light blue
            UIColor(red: 0.45, green: 0.63, blue: 0.95, alpha: 1.0).cgColor, // middle blue
            UIColor(red: 0.25, green: 0.49, blue: 0.92, alpha: 1.0).cgColor  // bottom deep blue
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

       // addDecorativeShapes()
       // animateShapes()
    }

    private func animateShapes() {
        decorativeShapes.forEach { shape in
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.fromValue = 0
            animation.toValue = 40
            animation.duration = 4.0
            animation.autoreverses = true
            animation.repeatCount = .infinity
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            shape.add(animation, forKey: "float")
        }
    }

//    private func addDecorativeShapes() {
//        decorativeShapes.forEach { $0.removeFromSuperlayer() }
//        decorativeShapes.removeAll()
//
//        // Top right floating shape
//        addShape(
//            size: CGSize(width: 350, height: 250),
//            position: CGPoint(x: bounds.width - 90, y: 180),
//            cornerRadius: 40,
//            rotation: -10,
//            color: UIColor.white.withAlphaComponent(0.3)
//        )
//
//        // Bottom left floating shape
//        addShape(
//            size: CGSize(width: 400, height: 250),
//            position: CGPoint(x: 100, y: bounds.height - 180),
//            cornerRadius: 50,
//            rotation: -20,
//            color: UIColor.white.withAlphaComponent(0.25)
//        )
//
//
//    }

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
//        if !decorativeShapes.isEmpty {
//          //  addDecorativeShapes()
//            animateShapes()
//        }
    }
}
