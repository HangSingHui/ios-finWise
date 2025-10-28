//
//  LoadingViewController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 27/10/25.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    
    private var animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "LoadingModel")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.loopMode = .loop
        animation.contentMode = .scaleAspectFit
        animation.animationSpeed = 1.0
        return animation
    }()
    
    private var loadingTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private var timer: Timer?
    
    let loadingText = [
        "Sniffing out sneaky clauses…",
        "Counting invisible fees…",
        "Shaking the contract for secrets…",
        "Putting on my lawyer hat…",
        "Deciphering legal mumbo-jumbo…",
        "Polishing fine print until it shines…",
        "Summoning clause spirits…",
        "Making sense of fancy words…",
        "Hunting hidden obligations…",
        "Tickling the termination section…",
        "Giving confidentiality a hug…",
        "Turning legal gobbledygook into plain English…",
        "Crunching numbers and letters…",
        "Negotiating with stubborn paragraphs…",
        "Checking if the contract behaves…"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        startTextUpdates()
    }
    
    private func setupViews() {
        // Add subviews
        view.addSubview(animationView)
        view.addSubview(loadingTextLabel)
        
        // Start animation
        animationView.play()
        
        // Auto Layout constraints
        NSLayoutConstraint.activate([
            // Animation centered horizontally and vertically (slightly up)
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300),
            
            // Label below animation
            loadingTextLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20),
            loadingTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loadingTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Set initial text
        loadingTextLabel.text = loadingText.first
    }
    
    private func startTextUpdates() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let randomIndex = Int.random(in: 0..<self.loadingText.count)
            self.loadingTextLabel.text = self.loadingText[randomIndex]
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}


#Preview {
    AnimationViewController()
}
