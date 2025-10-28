//
//  ResultsViewController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 27/10/25.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - Properties
    let currentAnalysis: ProcessedDocument!
    var savedAnalysis = AppDelegate.shared.savedAnalysis
    var saveButton: UIBarButtonItem!
    var shareButton: UIBarButtonItem!
    
    // UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let summaryContainer = UIView()
    private let summaryTitleLabel = UILabel()
    private let summaryTextView = UITextView()
    private let segmentedControl = UISegmentedControl(items: ["Highlights", "Tips"])
    private let breakdownTitleLabel = UILabel()
    private let cardsStackView = UIStackView()
    
    private enum Section {
        case highlights
        case tips
    }
    
    private var currentSection: Section = .highlights
    
    // MARK: - Initialization
    init(analysis: ProcessedDocument) {
        currentAnalysis = analysis
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupScrollView()
        setupTitle()
        setupSummarySection()
        setupSegmentedControl()
        setupBreakdownSection()
        setupLayout()
        updateCardsForCurrentSection()
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        // Left bar button - Home
        let homeButton = UIBarButtonItem(
            image: UIImage(systemName: "house"),
            style: .plain,
            target: self,
            action: #selector(returnToHome)
        )
        navigationItem.leftBarButtonItem = homeButton
        
        // Right bar buttons - Save and Share (always visible)
        saveButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(toggleSave)
        )
        
        shareButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain,
            target: self,
            action: #selector(shareAnalysis)
        )
        
        navigationItem.rightBarButtonItems = [shareButton, saveButton]
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupTitle() {
        titleLabel.text = "Analysis Results for \(currentAnalysis.documentIdentifier)"
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
    }
    
    private func setupSummarySection() {
        summaryContainer.backgroundColor = .secondarySystemBackground
        summaryContainer.layer.cornerRadius = 12
        summaryContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(summaryContainer)
        
        summaryTitleLabel.text = "Summary"
        summaryTitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        summaryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryContainer.addSubview(summaryTitleLabel)
        
        summaryTextView.text = buildSummaryText()
        summaryTextView.font = .systemFont(ofSize: 15)
        summaryTextView.textColor = .secondaryLabel
        summaryTextView.backgroundColor = .clear
        summaryTextView.isEditable = false
        summaryTextView.isScrollEnabled = false
        summaryTextView.textContainerInset = .zero
        summaryTextView.textContainer.lineFragmentPadding = 0
        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
        summaryContainer.addSubview(summaryTextView)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(segmentedControl)
    }
    
    private func setupBreakdownSection() {
        breakdownTitleLabel.text = "Breakdown"
        breakdownTitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        breakdownTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(breakdownTitleLabel)
        
        cardsStackView.axis = .vertical
        cardsStackView.spacing = 12
        cardsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardsStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // ScrollView (fills entire view)
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // Summary Container
            summaryContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            summaryContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            summaryContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            summaryTitleLabel.topAnchor.constraint(equalTo: summaryContainer.topAnchor, constant: 16),
            summaryTitleLabel.leadingAnchor.constraint(equalTo: summaryContainer.leadingAnchor, constant: 16),
            summaryTitleLabel.trailingAnchor.constraint(equalTo: summaryContainer.trailingAnchor, constant: -16),
            
            summaryTextView.topAnchor.constraint(equalTo: summaryTitleLabel.bottomAnchor, constant: 12),
            summaryTextView.leadingAnchor.constraint(equalTo: summaryContainer.leadingAnchor, constant: 16),
            summaryTextView.trailingAnchor.constraint(equalTo: summaryContainer.trailingAnchor, constant: -16),
            summaryTextView.bottomAnchor.constraint(equalTo: summaryContainer.bottomAnchor, constant: -16),
            
            // Segmented Control
            segmentedControl.topAnchor.constraint(equalTo: summaryContainer.bottomAnchor, constant: 24),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32),
            
            // Breakdown Title
            breakdownTitleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24),
            breakdownTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            breakdownTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // Cards Stack
            cardsStackView.topAnchor.constraint(equalTo: breakdownTitleLabel.bottomAnchor, constant: 16),
            cardsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cardsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cardsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    // MARK: - Helper Methods
    private func buildSummaryText() -> String {
        let summary = currentAnalysis.summary
        var text = ""
        
        text += "Document Type: \(summary.documentType)\n\n"
        text += "Purpose: \(summary.purpose)\n\n"
        
        if !summary.parties.isEmpty {
            text += "Parties:\n"
            summary.parties.forEach { text += "• \($0)\n" }
            text += "\n"
        }
        
        if let duration = summary.duration {
            text += "Duration: \(duration)\n\n"
        }
        
        if !summary.topThreeThings.isEmpty {
            text += "Top 3 Things to Know:\n"
            for (index, thing) in summary.topThreeThings.enumerated() {
                text += "\(index + 1). \(thing)\n"
            }
        }
        
        return text
    }
    
    private func updateCardsForCurrentSection() {
        cardsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if currentSection == .highlights {
            addHighlightCards()
        } else {
            addTipCards()
        }
    }
    
    private func addHighlightCards() {
        let sections: [(String, String, Severity)] = [
            ("Obligations", "clipboard", calculateObligationsSeverity()),
            ("Fees & Payments", "creditcard", calculateFeesSeverity()),
            ("Termination", "bolt.horizontal", calculateTerminationSeverity()),
            ("Confidentiality", "lock", calculateConfidentialitySeverity())
        ]
        
        for (title, iconName, severity) in sections {
            let card = createCard(title: title, iconName: iconName, severity: severity)
            cardsStackView.addArrangedSubview(card)
        }
    }
    
    private func addTipCards() {
        for tip in currentAnalysis.tips {
            let iconName = getIconName(for: tip.category)
            let card = createCard(title: tip.title, iconName: iconName, severity: nil)
            cardsStackView.addArrangedSubview(card)
        }
    }
    
    private func createCard(title: String, iconName: String, severity: Severity?) -> UIView {
        let card = UIView()
        card.backgroundColor = .secondarySystemBackground
        card.layer.cornerRadius = 12
        card.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.tintColor = .label
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let severityLabel = UILabel()
        if let severity = severity {
            severityLabel.text = severity.displayName
            severityLabel.textColor = severity.color
            severityLabel.font = .systemFont(ofSize: 14, weight: .medium)
        }
        severityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(iconImageView)
        card.addSubview(titleLabel)
        card.addSubview(severityLabel)
        
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            iconImageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            
            severityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            severityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            severityLabel.bottomAnchor.constraint(lessThanOrEqualTo: card.bottomAnchor, constant: -16)
        ])
        
        return card
    }
    
    // MARK: - Severity Calculations
    enum Severity {
        case low, medium, high, critical
        
        var displayName: String {
            switch self {
            case .low: return "Low"
            case .medium: return "Medium"
            case .high: return "High"
            case .critical: return "Critical"
            }
        }
        
        var color: UIColor {
            switch self {
            case .low: return UIColor.systemGreen
            case .medium: return UIColor.systemOrange
            case .high: return UIColor.systemRed
            case .critical: return UIColor.systemPurple
            }
        }
    }
    
    private func calculateObligationsSeverity() -> Severity {
        let criticalCount = currentAnalysis.obligations.filter { $0.critical }.count
        if criticalCount >= 3 { return .critical }
        if criticalCount >= 2 { return .high }
        if criticalCount >= 1 { return .medium }
        return .low
    }
    
    private func calculateFeesSeverity() -> Severity {
        let recurringFees = currentAnalysis.feesAndPayments.filter { $0.type == "recurring" }.count
        if recurringFees >= 3 { return .high }
        if recurringFees >= 1 { return .medium }
        return .low
    }
    
    private func calculateTerminationSeverity() -> Severity {
        let hasAutoRenewal = currentAnalysis.termination.autoRenewal?.applies ?? false
        let hasTerminationFees = !currentAnalysis.termination.terminationFees.isEmpty
        
        if hasAutoRenewal && hasTerminationFees { return .high }
        if hasAutoRenewal || hasTerminationFees { return .medium }
        return .low
    }
    
    private func calculateConfidentialitySeverity() -> Severity {
        let hasThirdParties = currentAnalysis.confidentiality.contains {
            $0.thirdParties != nil && !($0.thirdParties?.isEmpty ?? true)
        }
        if hasThirdParties { return .medium }
        return .low
    }
    
    private func getIconName(for category: String) -> String {
        switch category {
        case "watch_out": return "exclamationmark.triangle.fill"
        case "save_money": return "dollarsign.circle.fill"
        case "maximize_benefits": return "checkmark.seal.fill"
        case "dont_miss": return "calendar.badge.exclamationmark"
        case "connect_dots": return "link.circle.fill"
        case "protect_yourself": return "shield.fill"
        default: return "info.circle.fill"
        }
    }
    
    private func updateSaveButtonState() {
        let isSaved = savedAnalysis.contains(currentAnalysis)
        let imageName = isSaved ? "heart.fill" : "heart"
        
        // Create UIImage with optional size/weight configuration if needed
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let image = UIImage(systemName: imageName)?.withConfiguration(config)
        
        saveButton.image = image
    }

    
    // MARK: - Actions
    @objc private func returnToHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func toggleSave() {
        if savedAnalysis.contains(currentAnalysis) {
            savedAnalysis.remove(currentAnalysis)
            saveButton.image = UIImage(systemName: "heart") // normal state
        } else {
            savedAnalysis.insert(currentAnalysis)
            saveButton.image = UIImage(systemName: "heart.fill") // filled state
        }
    }
    
    @objc private func shareAnalysis() {
        let shareText = """
        Document Analysis: \(currentAnalysis.documentIdentifier)
        Type: \(currentAnalysis.summary.documentType)
        
        \(currentAnalysis.summary.purpose)
        """
        
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        // iPad popover fix
        if let popover = activityVC.popoverPresentationController {
            popover.barButtonItem = shareButton
        }
        
        present(activityVC, animated: true)
    }

    
    @objc private func segmentChanged() {
        currentSection = segmentedControl.selectedSegmentIndex == 0 ? .highlights : .tips
        updateCardsForCurrentSection()
    }
}

// MARK: - Preview
#Preview {
    let dummySummary = ProcessedDocument.Summary(
        documentType: "Personal Loan Agreement",
        purpose: "This loan agreement provides financing for personal use with a fixed interest rate of 5% per annum. The borrower agrees to repay the principal amount plus interest over a 12-month period through monthly installments.",
        parties: ["John Doe (Borrower)", "ABC Bank Ltd (Lender)"],
        duration: "12 months (1 Jan 2024 - 31 Dec 2024)",
        keyDates: ["Loan Start: 1 Jan 2024"],
        mainPoints: ["Total loan amount: $6,000"],
        limitations: ["No early withdrawal without penalty"],
        topThreeThings: [
            "Pay on time to avoid $50 late fees",
            "Early exit costs $200 penalty",
            "You have 7 days to cancel without penalty"
        ]
    )
    
    let dummyDocument = ProcessedDocument(
        documentIdentifier: "Policy456",
        summary: dummySummary,
        obligations: [
            ProcessedDocument.Obligation(
                item: "Monthly payment",
                critical: true,
                deadline: nil,
                penaltyForNonCompliance: nil,
                severity: .medium
            )
        ],
        feesAndPayments: [
            ProcessedDocument.Fee(
                type: "recurring",
                amount: "$100",
                description: "Monthly fee",
                frequency: "monthly",
                dueDate: nil,
                latePenalty: nil,
                severity: .medium
            )
        ],
        termination: ProcessedDocument.Termination(
            howToTerminate: nil,
            noticePeriod: nil,
            terminationFees: [],
            refundPolicy: nil,
            autoRenewal: nil,
            coolingOffPeriod: nil,
            postTerminationObligations: [],
            severity: .low
        ),
        confidentiality: [],
        tips: [
            ProcessedDocument.Tip(
                category: "save_money",
                title: "Set up autopay",
                description: "Save on fees",
                actionRequired: true,
                deadline: nil,
                reference: "Clause 4",
                severity: .low
            )
        ]
    )
    
    return UINavigationController(rootViewController: ResultsViewController(analysis: dummyDocument))
}
