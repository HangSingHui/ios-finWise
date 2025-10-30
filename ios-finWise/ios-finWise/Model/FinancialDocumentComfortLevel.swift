//
//  Financial.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 30/10/25.
//

enum FinancialDocumentComfortLevel: Int {
    case lost = 0
    case beginner = 1
    case intermediate = 2
    case confident = 3
    
    var description: String {
            switch self {
            case .lost:
                return "Lost - The user finds financial documents overwhelming and confusing. They struggle with financial terminology, have difficulty understanding statements, reports, and formal financial language. They need explanations in very simple terms with minimal jargon, step-by-step guidance, and extensive context for any financial concepts."
            case .beginner:
                return "Beginner - The user has basic familiarity with financial documents but often needs assistance. They understand simple concepts like income and expenses but may struggle with more complex terms like amortization, compound interest, or tax deductions. They benefit from clear explanations with examples and occasional definitions of technical terms."
            case .intermediate:
                return "Intermediate - The user is comfortable reading most common financial documents such as bank statements, credit card bills, loan agreements, and basic investment reports. They understand standard financial terminology and concepts but may need clarification on complex financial instruments, advanced tax strategies, or specialized investment products. They appreciate concise explanations with relevant details."
            case .confident:
                return "Confident - The user is highly comfortable with financial documents and terminology. They easily understand complex financial statements, investment portfolios, tax documents, legal financial contracts, and technical financial analysis. They prefer efficient, detailed responses without oversimplification and can handle technical financial jargon and nuanced discussions."
            }
        }
}
