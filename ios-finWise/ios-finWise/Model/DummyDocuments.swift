//
//  DummyDocuments.swift
//  ios-finWise
//
//  Dummy financial documents for testing ProcessedDocument
//

import Foundation

struct DummyDocuments {
    
    // MARK: - All Dummy Documents
    static let all: [ProcessedDocument] = [
        creditCardAgreement,
        personalLoan,
        investmentAccount,
        insurancePolicy
    ]
    
    // MARK: - 1. Credit Card Agreement
    static let creditCardAgreement = ProcessedDocument(
        documentIdentifier: "CC-2024-8891",
        summary: ProcessedDocument.Summary(
            documentType: "Credit Card Agreement",
            purpose: "Revolving credit facility with rewards program and cashback benefits",
            parties: ["CitiBank Singapore", "Cardholder"],
            duration: "Indefinite (subject to annual review)",
            keyDates: [
                "Account opened: Oct 15, 2024",
                "First payment due: Nov 20, 2024",
                "Annual fee due: Oct 15, 2025"
            ],
            mainPoints: [
                "Credit limit: $15,000",
                "1.5% cashback on all purchases",
                "Interest rate: 26% p.a. on outstanding balance",
                "Minimum payment: 3% of balance or $50 (whichever is higher)"
            ],
            limitations: [
                "Cashback capped at $50 per month",
                "Foreign transaction fee: 3.25%",
                "Balance transfer offers excluded from cashback",
                "Late payment affects credit score"
            ],
            topThreeThings: [
                "Pay full balance by due date to avoid 26% interest charges",
                "$120 annual fee waived first year, then charged automatically",
                "Missing payment deadline incurs $100 late fee and affects credit rating"
            ]
        ),
        obligations: [
            ProcessedDocument.Obligation(
                item: "Make minimum monthly payment",
                critical: true,
                deadline: "20th of each month",
                penaltyForNonCompliance: "$100 late payment fee + interest charges",
                severity: .critical
            ),
            ProcessedDocument.Obligation(
                item: "Keep account in good standing",
                critical: true,
                deadline: nil,
                penaltyForNonCompliance: "Account suspension and credit score impact",
                severity: .high
            ),
            ProcessedDocument.Obligation(
                item: "Update contact information within 14 days of changes",
                critical: false,
                deadline: "Within 14 days of change",
                penaltyForNonCompliance: "May miss important notifications",
                severity: .low
            ),
            ProcessedDocument.Obligation(
                item: "Report lost or stolen card immediately",
                critical: true,
                deadline: "Immediately upon discovery",
                penaltyForNonCompliance: "Liable for unauthorized transactions",
                severity: .critical
            )
        ],
        feesAndPayments: [
            ProcessedDocument.Fee(
                type: "recurring",
                amount: "$120",
                description: "Annual card fee",
                frequency: "Annually",
                dueDate: "Oct 15, 2025",
                latePenalty: "Automatic charge to account",
                severity: .medium
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "$100",
                description: "Late payment fee",
                frequency: "Per occurrence",
                dueDate: nil,
                latePenalty: "Additional interest charges",
                severity: .high
            ),
            ProcessedDocument.Fee(
                type: "variable",
                amount: "26% p.a.",
                description: "Interest on outstanding balance",
                frequency: "Monthly",
                dueDate: nil,
                latePenalty: "Compounding interest",
                severity: .critical
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "3.25%",
                description: "Foreign transaction fee",
                frequency: "Per transaction",
                dueDate: nil,
                latePenalty: nil,
                severity: .medium
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "$15",
                description: "Cash advance fee",
                frequency: "Per transaction",
                dueDate: nil,
                latePenalty: "Higher interest rate applies",
                severity: .high
            )
        ],
        termination: ProcessedDocument.Termination(
            howToTerminate: "Call customer service at 1800-123-4567 or visit any branch. Written request required.",
            noticePeriod: "None required, but outstanding balance must be cleared",
            terminationFees: [
                ProcessedDocument.Termination.TerminationFee(
                    condition: "Outstanding balance",
                    amount: "Full balance + accrued interest",
                    description: "All outstanding amounts must be paid in full"
                ),
                ProcessedDocument.Termination.TerminationFee(
                    condition: "Annual fee already charged",
                    amount: "No refund",
                    description: "Annual fees are non-refundable"
                )
            ],
            refundPolicy: "No refunds on annual fees or other charges",
            autoRenewal: ProcessedDocument.Termination.AutoRenewal(
                applies: false,
                renewalDate: nil,
                howToPrevent: nil,
                deadlineToCancel: nil
            ),
            coolingOffPeriod: ProcessedDocument.Termination.CoolingOffPeriod(
                applies: true,
                duration: "5 business days",
                endDate: "Oct 22, 2024"
            ),
            postTerminationObligations: [
                "Pay all outstanding balances",
                "Return physical card (cut in half)",
                "Update automatic payment arrangements",
                "Outstanding balance continues to accrue interest until paid"
            ],
            severity: .medium
        ),
        confidentiality: [
            ProcessedDocument.Confidentiality(
                category: "data_collection",
                details: "Bank collects personal information, transaction history, credit history, income details, and device information",
                thirdParties: nil,
                severity: .medium
            ),
            ProcessedDocument.Confidentiality(
                category: "sharing",
                details: "Information may be shared with credit bureaus, fraud prevention agencies, and marketing partners",
                thirdParties: ["Credit Bureau Singapore", "Fraud Prevention Partners", "Marketing Affiliates"],
                severity: .high
            ),
            ProcessedDocument.Confidentiality(
                category: "usage",
                details: "Data used for credit assessment, fraud detection, personalized offers, and account management",
                thirdParties: nil,
                severity: .medium
            ),
            ProcessedDocument.Confidentiality(
                category: "rights",
                details: "You can request data access, correction, or deletion. Opt-out of marketing communications anytime.",
                thirdParties: nil,
                severity: .low
            )
        ],
        tips: [
            ProcessedDocument.Tip(
                category: "watch_out",
                title: "High Interest Rate Alert",
                description: "26% annual interest is very high. Always pay full balance to avoid interest charges.",
                actionRequired: true,
                deadline: "Every payment due date",
                reference: "Section 4.2: Interest Charges",
                severity: .critical
            ),
            ProcessedDocument.Tip(
                category: "save_money",
                title: "Maximize Cashback",
                description: "Use this card for all purchases to get 1.5% cashback, but remember the $50/month cap",
                actionRequired: false,
                deadline: nil,
                reference: "Section 7.1: Rewards Program",
                severity: .low
            ),
            ProcessedDocument.Tip(
                category: "dont_miss",
                title: "Annual Fee Coming Up",
                description: "Your $120 annual fee will be charged on Oct 15, 2025. Consider if you're getting enough value.",
                actionRequired: true,
                deadline: "Oct 15, 2025",
                reference: "Section 5.1: Annual Fees",
                severity: .medium
            ),
            ProcessedDocument.Tip(
                category: "protect_yourself",
                title: "Credit Score Impact",
                description: "Late payments are reported to credit bureaus and can significantly damage your credit score",
                actionRequired: true,
                deadline: "Ongoing",
                reference: "Section 9.3: Credit Reporting",
                severity: .high
            )
        ]
    )
    
    // MARK: - 2. Personal Loan Agreement
    static let personalLoan = ProcessedDocument(
        documentIdentifier: "LOAN-2024-5532",
        summary: ProcessedDocument.Summary(
            documentType: "Personal Loan Agreement",
            purpose: "Unsecured personal loan for debt consolidation and home renovation",
            parties: ["Standard Chartered Bank", "Borrower"],
            duration: "5 years (60 months)",
            keyDates: [
                "Loan disbursement: Nov 1, 2024",
                "First payment: Dec 1, 2024",
                "Final payment: Nov 1, 2029"
            ],
            mainPoints: [
                "Loan amount: $50,000",
                "Interest rate: 8.88% p.a. (fixed)",
                "Monthly installment: $1,028",
                "Processing fee: $500 (one-time)"
            ],
            limitations: [
                "Early repayment penalty: 5% of outstanding balance",
                "No payment holidays allowed",
                "Late payment affects credit rating",
                "Cannot restructure without bank approval"
            ],
            topThreeThings: [
                "Must make $1,028 payment by 1st of every month for 60 months",
                "5% penalty ($2,500 initially) if you pay off loan early",
                "Missing even one payment triggers default proceedings and credit score damage"
            ]
        ),
        obligations: [
            ProcessedDocument.Obligation(
                item: "Make monthly loan repayment",
                critical: true,
                deadline: "1st of each month",
                penaltyForNonCompliance: "$80 late fee + 18% penalty interest on overdue amount",
                severity: .critical
            ),
            ProcessedDocument.Obligation(
                item: "Maintain valid bank account for auto-debit",
                critical: true,
                deadline: "Throughout loan tenure",
                penaltyForNonCompliance: "Missed payments and additional charges",
                severity: .high
            ),
            ProcessedDocument.Obligation(
                item: "Notify bank of employment changes within 30 days",
                critical: false,
                deadline: "Within 30 days of change",
                penaltyForNonCompliance: "Breach of contract terms",
                severity: .medium
            ),
            ProcessedDocument.Obligation(
                item: "Not take additional unsecured loans exceeding $30,000 without bank consent",
                critical: true,
                deadline: nil,
                penaltyForNonCompliance: "Immediate loan recall",
                severity: .high
            )
        ],
        feesAndPayments: [
            ProcessedDocument.Fee(
                type: "one-time",
                amount: "$500",
                description: "Loan processing fee",
                frequency: nil,
                dueDate: "Upon loan approval",
                latePenalty: nil,
                severity: .low
            ),
            ProcessedDocument.Fee(
                type: "recurring",
                amount: "$1,028",
                description: "Monthly loan installment",
                frequency: "Monthly",
                dueDate: "1st of each month",
                latePenalty: "$80 + penalty interest",
                severity: .critical
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "$80",
                description: "Late payment charge",
                frequency: "Per occurrence",
                dueDate: nil,
                latePenalty: "18% p.a. on overdue amount",
                severity: .high
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "5% of outstanding balance",
                description: "Early repayment penalty",
                frequency: "One-time if applicable",
                dueDate: nil,
                latePenalty: nil,
                severity: .high
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "$150",
                description: "Dishonored payment fee",
                frequency: "Per occurrence",
                dueDate: nil,
                latePenalty: "Additional late payment charges",
                severity: .high
            )
        ],
        termination: ProcessedDocument.Termination(
            howToTerminate: "Submit written early repayment request 14 days in advance. Must pay full outstanding balance + penalty.",
            noticePeriod: "14 days written notice",
            terminationFees: [
                ProcessedDocument.Termination.TerminationFee(
                    condition: "Early repayment within 5 years",
                    amount: "5% of outstanding balance",
                    description: "Early settlement penalty applies"
                ),
                ProcessedDocument.Termination.TerminationFee(
                    condition: "Outstanding balance",
                    amount: "Full remaining principal + accrued interest",
                    description: "All amounts must be settled in full"
                )
            ],
            refundPolicy: "No refunds on processing fees or interest already paid",
            autoRenewal: nil,
            coolingOffPeriod: ProcessedDocument.Termination.CoolingOffPeriod(
                applies: true,
                duration: "7 calendar days",
                endDate: "Nov 8, 2024"
            ),
            postTerminationObligations: [
                "Settle all outstanding amounts including interest",
                "Pay early repayment penalty if applicable",
                "Request loan discharge letter",
                "Verify credit bureau records updated"
            ],
            severity: .high
        ),
        confidentiality: [
            ProcessedDocument.Confidentiality(
                category: "data_collection",
                details: "Bank collects employment details, income proof, credit history, CPF statements, and bank statements",
                thirdParties: nil,
                severity: .medium
            ),
            ProcessedDocument.Confidentiality(
                category: "sharing",
                details: "Information shared with credit bureaus, debt collection agencies (if default), and regulatory authorities",
                thirdParties: ["Credit Bureau Singapore", "Debt Collection Agencies", "MAS (Monetary Authority of Singapore)"],
                severity: .high
            ),
            ProcessedDocument.Confidentiality(
                category: "retention",
                details: "Records retained for 7 years after loan closure as per regulatory requirements",
                thirdParties: nil,
                severity: .low
            )
        ],
        tips: [
            ProcessedDocument.Tip(
                category: "watch_out",
                title: "Early Repayment Penalty Is Significant",
                description: "5% penalty means you'd pay $2,500 extra if you pay off the $50,000 loan early. Calculate if refinancing makes sense.",
                actionRequired: false,
                deadline: nil,
                reference: "Section 6.2: Early Settlement",
                severity: .high
            ),
            ProcessedDocument.Tip(
                category: "dont_miss",
                title: "Set Up Auto-Debit Immediately",
                description: "Ensure your bank account has sufficient funds by the 1st of every month. Set up low balance alerts.",
                actionRequired: true,
                deadline: "Before Dec 1, 2024",
                reference: "Section 4.1: Payment Terms",
                severity: .critical
            ),
            ProcessedDocument.Tip(
                category: "protect_yourself",
                title: "Track Your Credit Score",
                description: "This loan will appear on your credit report. Monitor it regularly to ensure accurate reporting.",
                actionRequired: true,
                deadline: "Ongoing",
                reference: "Section 11.4: Credit Reporting",
                severity: .medium
            ),
            ProcessedDocument.Tip(
                category: "save_money",
                title: "Consider Bi-Weekly Payments",
                description: "If allowed, bi-weekly payments can reduce total interest paid. Check with bank.",
                actionRequired: false,
                deadline: nil,
                reference: "Section 4.3: Payment Options",
                severity: .low
            )
        ]
    )
    
    // MARK: - 3. Investment Account Agreement
    static let investmentAccount = ProcessedDocument(
        documentIdentifier: "INV-2024-7721",
        summary: ProcessedDocument.Summary(
            documentType: "Investment Account Agreement",
            purpose: "Brokerage account for trading stocks, bonds, ETFs, and mutual funds",
            parties: ["DBS Vickers Securities", "Account Holder"],
            duration: "Indefinite (ongoing)",
            keyDates: [
                "Account opened: Oct 20, 2024",
                "First quarterly statement: Jan 31, 2025"
            ],
            mainPoints: [
                "Access to SGX, US, Hong Kong markets",
                "Commission: 0.28% per trade (min $25)",
                "No account maintenance fee if trading 4+ times per quarter",
                "Real-time market data subscription: $30/month"
            ],
            limitations: [
                "Cannot trade on margin without separate approval",
                "Account dormant after 24 months of inactivity",
                "Limited to cash trading initially",
                "Withdrawal processing takes 3-5 business days"
            ],
            topThreeThings: [
                "Trade at least 4 times per quarter or pay $50 quarterly maintenance fee",
                "All losses are your responsibility - investments are not guaranteed",
                "Inactive accounts over 24 months will be charged $100 dormancy fee"
            ]
        ),
        obligations: [
            ProcessedDocument.Obligation(
                item: "Maintain minimum trading activity (4 trades per quarter)",
                critical: false,
                deadline: "Each quarter",
                penaltyForNonCompliance: "$50 quarterly maintenance fee",
                severity: .medium
            ),
            ProcessedDocument.Obligation(
                item: "Ensure sufficient funds before placing trades",
                critical: true,
                deadline: "Before each trade",
                penaltyForNonCompliance: "Account suspension + $100 penalty",
                severity: .high
            ),
            ProcessedDocument.Obligation(
                item: "Update investment risk profile annually",
                critical: false,
                deadline: "Oct 20, 2025",
                penaltyForNonCompliance: "Restricted trading until updated",
                severity: .medium
            ),
            ProcessedDocument.Obligation(
                item: "Report suspicious activity within 24 hours",
                critical: true,
                deadline: "Within 24 hours",
                penaltyForNonCompliance: "Liability for unauthorized trades",
                severity: .high
            )
        ],
        feesAndPayments: [
            ProcessedDocument.Fee(
                type: "variable",
                amount: "0.28% (min $25)",
                description: "Trading commission per transaction",
                frequency: "Per trade",
                dueDate: nil,
                latePenalty: nil,
                severity: .medium
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "$50",
                description: "Quarterly maintenance fee (if < 4 trades)",
                frequency: "Quarterly",
                dueDate: "End of each quarter",
                latePenalty: "Auto-deducted from account",
                severity: .medium
            ),
            ProcessedDocument.Fee(
                type: "recurring",
                amount: "$30",
                description: "Real-time market data subscription",
                frequency: "Monthly",
                dueDate: "1st of each month",
                latePenalty: "Service suspension",
                severity: .low
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "$100",
                description: "Dormant account fee (inactive > 24 months)",
                frequency: "One-time",
                dueDate: nil,
                latePenalty: "Account closure if not resolved",
                severity: .high
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "$25",
                description: "Failed trade penalty",
                frequency: "Per occurrence",
                dueDate: nil,
                latePenalty: "Account restrictions",
                severity: .high
            )
        ],
        termination: ProcessedDocument.Termination(
            howToTerminate: "Submit account closure form online or at any branch. Sell all holdings first or transfer to another broker.",
            noticePeriod: "None, but all positions must be closed",
            terminationFees: [
                ProcessedDocument.Termination.TerminationFee(
                    condition: "Open positions exist",
                    amount: "Normal trading commissions apply",
                    description: "Must liquidate or transfer all holdings"
                ),
                ProcessedDocument.Termination.TerminationFee(
                    condition: "Outstanding fees",
                    amount: "All accumulated fees",
                    description: "Any unpaid fees must be settled"
                )
            ],
            refundPolicy: "No refunds on commissions or subscription fees already paid",
            autoRenewal: nil,
            coolingOffPeriod: ProcessedDocument.Termination.CoolingOffPeriod(
                applies: true,
                duration: "7 calendar days",
                endDate: "Oct 27, 2024"
            ),
            postTerminationObligations: [
                "Liquidate or transfer all securities holdings",
                "Settle all outstanding fees and charges",
                "Return any issued trading cards or tokens",
                "Tax reporting remains your responsibility"
            ],
            severity: .medium
        ),
        confidentiality: [
            ProcessedDocument.Confidentiality(
                category: "data_collection",
                details: "Collects trading history, portfolio holdings, transaction patterns, and financial risk profile",
                thirdParties: nil,
                severity: .medium
            ),
            ProcessedDocument.Confidentiality(
                category: "sharing",
                details: "Trading data shared with SGX, regulatory bodies (MAS), and tax authorities. Portfolio data may be used for research (anonymized).",
                thirdParties: ["Singapore Exchange (SGX)", "MAS", "IRAS", "Research Partners"],
                severity: .high
            ),
            ProcessedDocument.Confidentiality(
                category: "marketing",
                details: "May receive investment product recommendations based on your portfolio and trading patterns",
                thirdParties: ["Marketing Partners"],
                severity: .low
            ),
            ProcessedDocument.Confidentiality(
                category: "security",
                details: "Two-factor authentication required. Trading activities monitored for suspicious patterns.",
                thirdParties: nil,
                severity: .medium
            )
        ],
        tips: [
            ProcessedDocument.Tip(
                category: "save_money",
                title: "Avoid Quarterly Maintenance Fee",
                description: "Make at least 4 trades per quarter to waive the $50 fee. Even small trades count.",
                actionRequired: true,
                deadline: "End of each quarter",
                reference: "Fee Schedule Section 2.1",
                severity: .medium
            ),
            ProcessedDocument.Tip(
                category: "watch_out",
                title: "Investment Risk Disclosure",
                description: "All investments carry risk. You can lose more than your initial investment. Brokerage is not liable for losses.",
                actionRequired: false,
                deadline: nil,
                reference: "Section 8: Risk Disclosures",
                severity: .critical
            ),
            ProcessedDocument.Tip(
                category: "protect_yourself",
                title: "Enable 2FA and Trading Alerts",
                description: "Set up two-factor authentication and SMS alerts for all trades to protect against unauthorized access.",
                actionRequired: true,
                deadline: "Immediately",
                reference: "Section 10: Account Security",
                severity: .high
            ),
            ProcessedDocument.Tip(
                category: "dont_miss",
                title: "Annual Risk Profile Update",
                description: "Update your investment risk profile by Oct 20, 2025 or trading will be restricted.",
                actionRequired: true,
                deadline: "Oct 20, 2025",
                reference: "Section 3.4: KYC Requirements",
                severity: .medium
            )
        ]
    )
    
    // MARK: - 4. Insurance Policy
    static let insurancePolicy = ProcessedDocument(
        documentIdentifier: "INS-2024-3345",
        summary: ProcessedDocument.Summary(
            documentType: "Term Life Insurance Policy",
            purpose: "Life insurance coverage with critical illness rider for financial protection",
            parties: ["AIA Singapore", "Policyholder"],
            duration: "20 years (renewable)",
            keyDates: [
                "Policy start: Nov 1, 2024",
                "First premium due: Nov 1, 2024",
                "Free look period ends: Nov 15, 2024",
                "Policy anniversary: Nov 1 each year"
            ],
            mainPoints: [
                "Death benefit: $500,000",
                "Critical illness coverage: $100,000",
                "Monthly premium: $185",
                "Coverage until age 65"
            ],
            limitations: [
                "Pre-existing conditions excluded for first 2 years",
                "Suicide exclusion for first 12 months",
                "Hazardous activities not covered",
                "Premium increases upon renewal after 20 years"
            ],
            topThreeThings: [
                "Must pay $185 premium every month or policy lapses after 30-day grace period",
                "Critical illness claim reduces death benefit by claimed amount",
                "Free look period ends Nov 15 - last chance to cancel for full refund"
            ]
        ),
        obligations: [
            ProcessedDocument.Obligation(
                item: "Pay monthly premiums on time",
                critical: true,
                deadline: "1st of each month",
                penaltyForNonCompliance: "30-day grace period, then policy lapses",
                severity: .critical
            ),
            ProcessedDocument.Obligation(
                item: "Notify insurer of health changes that increase risk",
                critical: true,
                deadline: "Within 30 days",
                penaltyForNonCompliance: "Claim may be denied",
                severity: .high
            ),
            ProcessedDocument.Obligation(
                item: "Submit claims within 90 days of diagnosis/incident",
                critical: true,
                deadline: "Within 90 days",
                penaltyForNonCompliance: "Claim rejection possible",
                severity: .high
            ),
            ProcessedDocument.Obligation(
                item: "Undergo medical examination if requested",
                critical: false,
                deadline: "Within 30 days of request",
                penaltyForNonCompliance: "Policy may be terminated",
                severity: .medium
            )
        ],
        feesAndPayments: [
            ProcessedDocument.Fee(
                type: "recurring",
                amount: "$185",
                description: "Monthly insurance premium",
                frequency: "Monthly",
                dueDate: "1st of each month",
                latePenalty: "30-day grace period, then policy lapse",
                severity: .critical
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "$50",
                description: "Policy reinstatement fee",
                frequency: "One-time if applicable",
                dueDate: nil,
                latePenalty: "Medical underwriting required",
                severity: .high
            ),
            ProcessedDocument.Fee(
                type: "conditional",
                amount: "$30",
                description: "Duplicate policy document fee",
                frequency: "Per request",
                dueDate: nil,
                latePenalty: nil,
                severity: .low
            )
        ],
        termination: ProcessedDocument.Termination(
            howToTerminate: "Submit written cancellation request. Can be done during 14-day free look period for full refund.",
            noticePeriod: "None required",
            terminationFees: [
                ProcessedDocument.Termination.TerminationFee(
                    condition: "Cancellation after free look period",
                    amount: "No refund of premiums paid",
                    description: "No surrender value for term insurance"
                ),
                ProcessedDocument.Termination.TerminationFee(
                    condition: "During free look period",
                    amount: "$0",
                    description: "Full refund of premiums paid"
                )
            ],
            refundPolicy: "Full refund if cancelled within 14-day free look period. No refund thereafter.",
            autoRenewal: ProcessedDocument.Termination.AutoRenewal(
                applies: true,
                renewalDate: "Nov 1, 2044",
                howToPrevent: "Submit non-renewal notice 60 days before policy end date",
                deadlineToCancel: "Sep 2, 2044"
            ),
            coolingOffPeriod: ProcessedDocument.Termination.CoolingOffPeriod(
                applies: true,
                duration: "14 calendar days",
                endDate: "Nov 15, 2024"
            ),
            postTerminationObligations: [
                "No further premium payments required",
                "Coverage ends immediately upon cancellation",
                "Cannot reinstate policy after voluntary cancellation",
                "Outstanding premiums must be paid"
            ],
            severity: .low
        ),
        confidentiality: [
            ProcessedDocument.Confidentiality(
                category: "data_collection",
                details: "Collects medical records, health declarations, lifestyle information, and claims history",
                thirdParties: nil,
                severity: .high
            ),
            ProcessedDocument.Confidentiality(
                category: "sharing",
                details: "Medical information shared with reinsurers, medical practitioners for assessment, and Life Insurance Association of Singapore",
                thirdParties: ["Reinsurance Partners", "Medical Examiners", "LIA Singapore"],
                severity: .critical
            ),
            ProcessedDocument.Confidentiality(
                category: "usage",
                details: "Health data used for underwriting, claims assessment, and fraud prevention",
                thirdParties: nil,
                severity: .high
            ),
            ProcessedDocument.Confidentiality(
                category: "retention",
                details: "Medical records retained for duration of policy plus 7 years after termination",
                thirdParties: nil,
                severity: .medium
            )
        ],
        tips: [
            ProcessedDocument.Tip(
                category: "dont_miss",
                title: "Free Look Period Ending Soon",
                description: "You have until Nov 15, 2024 to cancel for a full refund if you change your mind. After that, no refunds.",
                actionRequired: true,
                deadline: "Nov 15, 2024",
                reference: "Section 12: Free Look Provision",
                severity: .high
            ),
            ProcessedDocument.Tip(
                category: "watch_out",
                title: "Critical Illness Reduces Death Benefit",
                description: "If you claim $100,000 for critical illness, death benefit reduces to $400,000. Plan accordingly.",
                actionRequired: false,
                deadline: nil,
                reference: "Section 5.3: Benefit Reduction",
                severity: .high
            ),
            ProcessedDocument.Tip(
                category: "protect_yourself",
                title: "Be Truthful in Health Declarations",
                description: "Non-disclosure or false information will void your policy. Your beneficiaries get nothing if claim is denied.",
                actionRequired: true,
                deadline: "Ongoing",
                reference: "Section 9: Material Disclosure",
                severity: .critical
            ),
            ProcessedDocument.Tip(
                category: "maximize_benefits",
                title: "Update Beneficiaries Regularly",
                description: "Review and update beneficiary designations after major life events (marriage, children, divorce).",
                actionRequired: false,
                deadline: nil,
                reference: "Section 7: Beneficiary Designation",
                severity: .medium
            ),
            ProcessedDocument.Tip(
                category: "connect_dots",
                title: "Premium Increases at Renewal",
                description: "After 20 years, premiums will increase based on your age. Budget for this or consider alternatives before then.",
                actionRequired: false,
                deadline: "Nov 1, 2044",
                reference: "Section 15: Renewal Terms",
                severity: .medium
            )
        ]
    )
}

// MARK: - Helper Extension
extension DummyDocuments {
    /// Get a random document
    static var random: ProcessedDocument {
        all.randomElement()!
    }
    
    /// Get documents by type
    static func byType(_ type: String) -> [ProcessedDocument] {
        all.filter { $0.summary.documentType.lowercased().contains(type.lowercased()) }
    }
    
    /// Get high severity documents (for testing alerts)
    static var highSeverityDocuments: [ProcessedDocument] {
        all.filter { document in
            document.obligationsSeverity == .high ||
            document.obligationsSeverity == .critical ||
            document.feesSeverity == .high ||
            document.feesSeverity == .critical
        }
    }
}
