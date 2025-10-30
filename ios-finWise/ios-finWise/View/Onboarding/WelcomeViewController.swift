//
//  WelcomeViewController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 29/10/25.
//

import UIKit
import Lottie

class WelcomeViewController: UIViewController{
    
    let logoImageView = UIImageView()
    let containerView = UIView()
    let welcomeTitleLabel  = UILabel()
    let welcomeDescText = UILabel()
    let startButton = UIButton()
    let stack = UIStackView()
    var animation: LottieAnimationView!

    
    override func viewDidLoad() {
        super.viewDidLoad( )
        
        setupBackground()
        setupUI()
        setupLayout()
        
    }
    
    
    func setupUI(){
        //Configure stackview
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        //Setup image
        let myLogo = UIImage(named: "finwise logo")
        // Logo
        logoImageView.image = UIImage(named: "finwise logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(logoImageView)
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5).isActive = true
        
        //Setup lottie animation
        animation = LottieAnimationView(name: "Morphing")
        animation.loopMode = .loop
        animation.animationSpeed = 1.0
        animation.contentMode = .scaleAspectFit
        animation.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(animation)
        animation.heightAnchor.constraint(equalToConstant: 250).isActive = true
        animation.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.7).isActive = true
        stack.addArrangedSubview(animation)
        animation.play()
        
       
        // Welcome Title
        welcomeTitleLabel.text = "Welcome to your personal financial document analyser!"
        welcomeTitleLabel.font = .systemFont(ofSize: 25, weight: .medium)
        welcomeTitleLabel.textAlignment = .center
        welcomeTitleLabel.numberOfLines = 0
        welcomeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(welcomeTitleLabel)
        welcomeTitleLabel.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.9).isActive = true
        
        stack.setCustomSpacing(20, after: welcomeTitleLabel)
    
        // Start Button
        startButton.setTitle("Get Started", for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        startButton.backgroundColor = .white
        startButton.setTitleColor(.systemBlue, for: .normal)
        startButton.layer.cornerRadius = 12
        startButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(startButton)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowOpacity = 0.25
        startButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        startButton.layer.shadowRadius = 6

    
    }
    
    @objc func startButtonTapped(_ sender: UIButton) {
        // Bounce animation
        UIView.animate(withDuration: 0.1,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        })
        
        let questionnaireVC = QuestionnaireViewController()
        questionnaireVC.modalPresentationStyle = .fullScreen
        present(questionnaireVC, animated: true)
    }

    
    func setupBackground(){
        let gradientView = WelcomeGradientView()
        gradientView.frame = view.bounds
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gradientView.setupGradient()
        view.insertSubview(gradientView, at: 0)
        
    }
    
    
    func setupLayout(){
// Constraints for animation
       NSLayoutConstraint.activate([
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
       stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
       stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
       stack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        
       ])
        
    }
}

#Preview {
    WelcomeViewController()
}
