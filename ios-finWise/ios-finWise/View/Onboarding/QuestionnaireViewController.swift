//
//  QuestionnaireViewController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 29/10/25.
//

import UIKit

class QuestionnaireViewController: UIViewController {

    //Global variable to track which question the user is on
    var currQuestion: Int = 1
    
    //variable to save user preferences
    var userPrefs: [String: String] = [
        "Age Group": "",
        "Comfort Level": "",
        "Commonly Read Documents": "",
        "Name": ""
    ]
    
    //Create a new user object
    var user: User?
    
    //TODO: Put into view later
    var question1: UIView?
    var question2: UIView?
    var question3: UIView?
    var question4: UIView?
    
    //Set common variables
    var questionLabel = UILabel()
    var nextButton = UIButton()
    var stack = UIStackView() //contains question label, each question's view and next button
    
    //Set question 1 variable
    //agegroup: [iconName, ageGroupDescription]
    let ageGroup = [
        ("18 -21", ["leaf", "Just starting out"]),
        ("22 - 25", ["graduationcap", "Early career/ freelance life"]),
        ("26 & Above", ["briefcase", "Building independence"])
    ]
    
    //Question1 variables
    var hasSelectedAgeGroup: Bool = false
    var question1Options: [UIView] = []
    var selectedAgeGroup: String = ""
    
    //Question2 variables
    var slider = UISlider()
    var labelStack = UIView()
    var selectedComfortLevel: String = ""
    var minLabel = UILabel()
    var maxLabel = UILabel()
    
    //Question3 variable
    let commonDocuments = [
        ("shield.fill", "Insurance Policies", "Life, health, or travel insurance contracts"),
        ("creditcard.fill", "Credit Cards / Personal Banking", "Banking agreements, credit card terms, fees, T&Cs"),
        ("chart.line.uptrend.xyaxis", "Investments", "SGX stocks, ETFs, CPF investments"),
        ("scale.3d", "Other Financial Services", "Subscriptions, loans, or miscellaneous agreements"),
      
    ] //Icon, title, description
    
    var subtitle = UILabel()
    var question3Options: [UIView] = []
    var selectedCommonDocuments: Set<String> = []
    
    //Question4 variables
    var nameTextField = UITextField()
    var textFieldContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad( )
        
        //Load the first question
        setupBackground()
        setupLayout()
        setupQuestion1()
        setupButton()
    
    }
    
    func setupButton(){
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        nextButton.backgroundColor = .white
        nextButton.setTitleColor(.systemBlue, for: .normal)
        nextButton.layer.cornerRadius = 12
        nextButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        nextButton.layer.shadowColor = UIColor.black.cgColor
        nextButton.layer.shadowOpacity = 0.25
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        nextButton.layer.shadowRadius = 6

        nextButton.isHidden = true
        
        // Add this line here:
        view.bringSubviewToFront(nextButton)
    }
    
    
    // MARK: TEAR DOWN FUNCTIONS
    func tearDownQ1(){
        //Reset
        questionLabel.text = ""
        for card in question1Options {
                  card.removeFromSuperview()
              }
        question1Options.removeAll()
    }
    
    func tearDownQ2(){
        questionLabel.text = ""
        slider.removeFromSuperview( )
        labelStack.removeFromSuperview()
        minLabel.removeFromSuperview()
        maxLabel.removeFromSuperview()
        
    }
    
    func tearDownQ3(){
        questionLabel.text = ""
        for card in question3Options{
            card.removeFromSuperview()
        }
        question3Options.removeAll()
        subtitle.removeFromSuperview()
        
    }
    
    
    func setupBackground() {
        let gradientView = GradientView()
        gradientView.frame = view.bounds
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gradientView.setupGradient()
        view.insertSubview(gradientView, at: 0)
    }
    
    
    func setupLayout(){
        view.backgroundColor = .white

       stack.axis = .vertical
       stack.spacing = 12
       stack.translatesAutoresizingMaskIntoConstraints = false

       view.addSubview(stack)
       stack.addArrangedSubview(questionLabel)
       //stack.addArrangedSubview(nextButton)

       NSLayoutConstraint.activate([
           stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
           
       ])
    
    }
    
    //MARK: Set Up Questions
    func setupQuestion1(){
        //Set the question
        questionLabel.text = "Which age group do you belong in?"
        questionLabel.font = .systemFont(ofSize: 20, weight: .medium)
    
        //Containers
        for (age, details) in ageGroup {
            let question1Card = createCard(title: age, iconName: details[0], description: details[1])
            question1Options.append(question1Card)
            
            //Setup tap gesture recogniser for each card
            //add tap gesture
            let tap = UITapGestureRecognizer(target: self, action: #selector(ageCardSelected(_:)))
            question1Card.addGestureRecognizer(tap)
            stack.addArrangedSubview(question1Card)
        }

    }
    
    func setupQuestion2(){
        nextButton.isHidden = true
        questionLabel.text = "How comfortable are you with financial documents?"
        questionLabel.font = .systemFont(ofSize: 20, weight: .medium)
        questionLabel.numberOfLines = 0

        //Configure slider
        slider.minimumValue = 0
        slider.maximumValue = 4
        slider.value = 0
        slider.isContinuous = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(slider)
        
        //Configure min and max labels
        minLabel.text = "Lost 😵‍💫"
        minLabel.font = .systemFont(ofSize: 14, weight: .light)
        minLabel.textColor = .secondaryLabel
        
        //Configure max label
        maxLabel.text = "Confident 😎"
        maxLabel.font = .systemFont(ofSize: 14, weight: .light)
        maxLabel.textColor = .secondaryLabel
        
        let labelStack = UIStackView(arrangedSubviews: [minLabel, maxLabel])
          labelStack.axis = .horizontal
          labelStack.distribution = .equalSpacing
          
        stack.addArrangedSubview(labelStack)
        
        //Configure on change slider
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        
    }
    
    func setupQuestion3(){
        questionLabel.text = "What types of documents do you usually deal with?"
        questionLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        subtitle.text = "Select all that applies"
        subtitle.textColor = .secondaryLabel
        stack.addArrangedSubview(subtitle)
        
        //Setup cards
        for (icon, title, desc) in commonDocuments{
            let question3Card = createCard(title: title, iconName: icon, description: desc)
            let tap = UITapGestureRecognizer(target: self, action: #selector(commonDocCardSelected(_:)))
            question3Card.addGestureRecognizer(tap)
            question3Options.append(question3Card)
            stack.addArrangedSubview(question3Card)
        }
    }
    
    func setupQuestion4() {
        questionLabel.text = "Lastly, how should we call you?"
        questionLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        // Create a container for nicer background
        textFieldContainer.backgroundColor = .white // light gray
        textFieldContainer.layer.cornerRadius = 12
        textFieldContainer.layer.shadowColor = UIColor.black.cgColor
        textFieldContainer.layer.shadowOpacity = 0.05
        textFieldContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        textFieldContainer.layer.shadowRadius = 4
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup textfield
        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .none
        nameTextField.font = .systemFont(ofSize: 16)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add textfield inside container
        textFieldContainer.addSubview(nameTextField)
        
        // Padding for textfield
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 12),
            nameTextField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -12),
            nameTextField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: 8),
            nameTextField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -8)
        ])
        
        // Add container to stack
        stack.addArrangedSubview(textFieldContainer)
        
        // Optional: limit height
        NSLayoutConstraint.activate([
            textFieldContainer.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
    @objc func commonDocCardSelected(_ sender: UITapGestureRecognizer){
        guard let selectedCard = sender.view else { return}
        let identifier = selectedCard.accessibilityIdentifier ?? ""
      
        //Check if its inside the
        if selectedCommonDocuments.contains(identifier){
            //remove and uncolor
            selectedCommonDocuments.remove(identifier)
            selectedCard.backgroundColor = .white
            selectedCard.layer.shadowOpacity = 0
            
        }
        else{
            //add and color
            selectedCommonDocuments.insert(identifier)
            UIView.animate(withDuration: 0.2) {
                selectedCard.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
                selectedCard.layer.borderColor = UIColor.systemBlue.cgColor
                selectedCard.layer.shadowColor = UIColor.systemBlue.cgColor
                selectedCard.layer.shadowOpacity = 0.3
                selectedCard.layer.shadowRadius = 6
                selectedCard.layer.shadowOffset = CGSize(width: 0, height: 2)
                selectedCard.layer.masksToBounds = false
                self.view.layoutIfNeeded()
            }
            
        }
    }
    

    
    @objc func sliderValueChanged(_ sender: UISlider){
        let roundedValue = Int(sender.value)
        let comfortLevel = FinancialDocumentComfortLevel(rawValue: roundedValue)
        selectedComfortLevel = comfortLevel?.description ?? ""
        nextButton.isHidden = false
        view.bringSubviewToFront(nextButton)
    }
    
    //Card creation for question1
    func createCard(title: String, iconName: String, description: String) -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.borderColor = UIColor.systemBlue.cgColor
        card.layer.cornerRadius = 12
        card.layer.shadowOpacity = 0
        card.translatesAutoresizingMaskIntoConstraints = false
       
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Set accessibility label
        card.accessibilityIdentifier =  "\(title): \(description)"
        
        let descriptionLabel = UILabel()
       descriptionLabel.text = description
       descriptionLabel.font = .systemFont(ofSize: 14)
       descriptionLabel.textColor = .secondaryLabel
       descriptionLabel.numberOfLines = 0
       descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(iconImageView)
        card.addSubview(titleLabel)
        card.addSubview(descriptionLabel)
        
        //Setup constraints
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(greaterThanOrEqualToConstant: 90),

            // Icon left
            iconImageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),

            // Title to the right of icon
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            // Description below title
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16),
                    
          ])
        
     
        
        return card

    }
    
    @objc func ageCardSelected(_ sender: UITapGestureRecognizer){
        guard let selectedCard = sender.view else { return }
    
        
        if hasSelectedAgeGroup{
            //Iterate through the cards and check wheterh their color has been changed
            //Change all the card background to white first
            for card in question1Options{
                if card != selectedCard {
                       card.backgroundColor = .white
                       card.layer.shadowOpacity = 0
               }
            }
        }
        //Change the color of the selected card to secondary
        UIView.animate(withDuration: 0.2) {
            selectedCard.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
            selectedCard.layer.borderColor = UIColor.systemBlue.cgColor
            selectedCard.layer.shadowColor = UIColor.systemBlue.cgColor
            selectedCard.layer.shadowOpacity = 0.3
            selectedCard.layer.shadowRadius = 6
            selectedCard.layer.shadowOffset = CGSize(width: 0, height: 2)
            selectedCard.layer.masksToBounds = false
            self.view.layoutIfNeeded()
        }

        hasSelectedAgeGroup = true
        selectedAgeGroup = selectedCard.accessibilityIdentifier ?? ""
        nextButton.isHidden  = false
        
    
    }
    
    @objc func nextButtonTapped(_ sender: UIButton){
        UIView.animate(withDuration: 0.1,
           animations: {
               sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
           }, completion: { _ in
               UIView.animate(withDuration: 0.1) {
                   sender.transform = .identity
               }
           })
        
        if currQuestion == 1 {
            userPrefs["Age Group"] = selectedAgeGroup
            print(userPrefs)  // ← Now it will show the updated value
            tearDownQ1()
            setupQuestion2()
            currQuestion += 1 // become 2
        }
        
        else if currQuestion == 2{
            userPrefs["Comfort Level"] = selectedComfortLevel
            print(userPrefs)
            currQuestion += 1
            tearDownQ2()
            setupQuestion3()
        }
        
        else if currQuestion == 3{
            userPrefs["Commonly Read Documents"] = Array(selectedCommonDocuments).joined(separator: " | ")
            print(userPrefs)
            tearDownQ3()
            setupQuestion4()
            currQuestion += 1
        }
        
        else if currQuestion == 4 {
            //set user prefs and direct them to the main page
            userPrefs["Name"] = nameTextField.text ?? "John AppleSeed"
            print("final user prefs", userPrefs)
            
            //Async - to create user profile, place in shared so it doesnt get deleted unless use deletes app
            //Give a loading page of 7 seconds
            
            //direct user to main page
            
        }
    }


}

#Preview {
    QuestionnaireViewController()
}
