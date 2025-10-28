//
//  DetailView.swift
//  ios-finWise
//

import UIKit

class DetailView: UIViewController {
    
    var details: [Any] = []
    
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    init(currDetails: [Any]) {
        self.details = currDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupScrollView()
        buildCollapsibleCards()
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .plain,
            target: self,
            action: #selector(handleDismiss)
        )
        navigationItem.leftBarButtonItem = backButton
        title = "Details"
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentView.axis = .vertical
        contentView.spacing = 12
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
    
    private func buildCollapsibleCards() {
        for detail in details {
            // MARK: Obligations
            if let obligations = detail as? [ProcessedDocument.Obligation], !obligations.isEmpty {
                let items = obligations.map { obligation in
                    var text = obligation.item
                    if let deadline = obligation.deadline { text += "\nDeadline: \(deadline)" }
                    if let penalty = obligation.penaltyForNonCompliance { text += "\nPenalty: \(penalty)" }
                    return text
                }
                contentView.addArrangedSubview(createCard(title: "Obligations", items: items))
            }
            
            // MARK: Fees & Payments
            else if let fees = detail as? [ProcessedDocument.Fee], !fees.isEmpty {
                let items = fees.map { fee in
                    var text = "\(fee.displayType): \(fee.amount)\n\(fee.description)"
                    if let frequency = fee.frequency { text += "\nFrequency: \(frequency)" }
                    if let dueDate = fee.dueDate { text += "\nDue: \(dueDate)" }
                    if let latePenalty = fee.latePenalty { text += "\nLate penalty: \(latePenalty)" }
                    return text
                }
                contentView.addArrangedSubview(createCard(title: "Fees & Payments", items: items))
            }
            
            // MARK: Termination
            else if let terminations = detail as? [ProcessedDocument.Termination], !terminations.isEmpty {
                let items = terminations.map { t -> String in
                    var text = ""
                    if let how = t.howToTerminate { text += "How to terminate: \(how)\n" }
                    if let notice = t.noticePeriod { text += "Notice period: \(notice)\n" }
                    if !t.terminationFees.isEmpty {
                        text += "Termination Fees:\n"
                        for fee in t.terminationFees {
                            text += "- \(fee.condition): \(fee.amount ?? "N/A") (\(fee.description))\n"
                        }
                    }
                    if let refund = t.refundPolicy { text += "Refund policy: \(refund)\n" }
                    if let auto = t.autoRenewal {
                        text += "Auto Renewal: \(auto.applies ? "Yes" : "No")\n"
                        if let deadline = auto.deadlineToCancel { text += "Cancel by: \(deadline)\n" }
                    }
                    if let cooling = t.coolingOffPeriod, cooling.applies {
                        text += "Cooling off period: \(cooling.duration ?? "") until \(cooling.endDate ?? "")\n"
                    }
                    if !t.postTerminationObligations.isEmpty {
                        text += "Post-Termination Obligations:\n"
                        for post in t.postTerminationObligations { text += "- \(post)\n" }
                    }
                    return text
                }
                contentView.addArrangedSubview(createCard(title: "Termination", items: items))
            }
            
            // MARK: Confidentiality
            else if let confs = detail as? [ProcessedDocument.Confidentiality], !confs.isEmpty {
                let items = confs.map { conf in
                    var text = "\(conf.displayCategory): \(conf.details)"
                    if let third = conf.thirdParties, !third.isEmpty { text += "\nThird parties: \(third.joined(separator: ", "))" }
                    return text
                }
                contentView.addArrangedSubview(createCard(title: "Confidentiality", items: items))
            }
            
            // MARK: Tips
            else if let tips = detail as? [ProcessedDocument.Tip], !tips.isEmpty {
                let items = tips.map { tip in
                    "\(tip.icon) \(tip.displayName): \(tip.description)"
                }
                contentView.addArrangedSubview(createCard(title: "Tips", items: items))
            }
        }
    }
    
    private func createCard(title: String, items: [String]) -> UIView {
        let card = UIView()
        card.backgroundColor = .secondarySystemBackground
        card.layer.cornerRadius = 12
        card.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        stack.addArrangedSubview(titleLabel)
        
        let detailsLabel = UILabel()
        detailsLabel.numberOfLines = 0
        detailsLabel.font = .systemFont(ofSize: 15)
        detailsLabel.textColor = .secondaryLabel
        detailsLabel.text = items.joined(separator: "\n\n")
        detailsLabel.isHidden = true
        stack.addArrangedSubview(detailsLabel)
        
        card.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleCard(_:)))
        card.addGestureRecognizer(tap)
        card.accessibilityLabel = title
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.1
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 4
        
        return card
    }
    
    @objc private func toggleCard(_ sender: UITapGestureRecognizer) {
        guard let card = sender.view,
              let stack = card.subviews.first as? UIStackView,
              stack.arrangedSubviews.count > 1 else { return }
        
        let detailsLabel = stack.arrangedSubviews[1]
        UIView.animate(withDuration: 0.3) {
            detailsLabel.isHidden.toggle()
            card.layoutIfNeeded()
        }
    }
    
    @objc private func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
}


#Preview{
    DetailView(currDetails: [
        ProcessedDocument.Fee(
            type: "recurring",
            amount: "$100",
            description: "Monthly fee",
            frequency: "monthly",
            dueDate: nil,
            latePenalty: nil,
            severity: .medium
        )
    ])
}
