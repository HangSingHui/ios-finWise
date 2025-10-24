//
//  GradientView.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//

import UIKit

class GradientView: UIView {
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
    }
    

}
