//Document.swift
// ios-finWise

//Created by Sing Hui Hang on 24/10/25.
 

 import Foundation

 struct ProcessedDocument: Codable {
     let documentIdentifier: String
    
     let summary: Summary
     let obligations: [Obligation]
     let feesAndPayments: [Fee]
     let termination: Termination
     let confidentiality: [Confidentiality]
     let tips: [Tip]
     
     enum CodingKeys: String, CodingKey {
         case documentIdentifier = "document_identifier"
         case summary, obligations
         case feesAndPayments = "fees_and_payments"
         case termination, confidentiality, tips
     }
     
     //MARK: - Summary
     struct Summary: Codable {
         let documentType: String
         let purpose: String
         let parties: [String]
         let duration: String?
         let keyDates: [String]
         let mainPoints: [String]
         let limitations: [String]
         let topThreeThings: [String]
         
         enum CodingKeys: String, CodingKey {
             case documentType = "document_type"
             case purpose, parties, duration
             case keyDates = "key_dates"
             case mainPoints = "main_points"
             case limitations
             case topThreeThings = "top_three_things"
         }
     }
     
      //MARK: - Obligation
     struct Obligation: Codable {
         let item: String
         let critical: Bool
         let deadline: String?
         let penaltyForNonCompliance: String?
         
         enum CodingKeys: String, CodingKey {
             case item, critical, deadline
             case penaltyForNonCompliance = "penalty_for_non_compliance"
         }
     }
     
     // MARK: - Fee
     struct Fee: Codable {
         let type: String // "one-time", "recurring", "conditional", "variable"
         let amount: String
         let description: String
         let frequency: String?
         let dueDate: String?
         let latePenalty: String?
         
         enum CodingKeys: String, CodingKey {
             case type, amount, description, frequency
             case dueDate = "due_date"
             case latePenalty = "late_penalty"
         }
         
         // Helper for display
         var displayType: String {
             type.replacingOccurrences(of: "-", with: " ").capitalized
         }
     }
     
     // MARK: - Confidentiality
     struct Confidentiality: Codable {
         let category: String // "data_collection", "usage", "sharing", "rights", "retention", "security", "marketing"
         let details: String
         let thirdParties: [String]?
         
         enum CodingKeys: String, CodingKey {
             case category, details
             case thirdParties = "third_parties"
         }
        
         var displayCategory: String {
             category.replacingOccurrences(of: "_", with: " ").capitalized
         }
     }
     
      //MARK: - Tip
     struct Tip: Codable {
         let category: String // "watch_out", "save_money", "maximize_benefits", "dont_miss", "connect_dots", "protect_yourself"
         let title: String
         let description: String
         let actionRequired: Bool
         let deadline: String?
         let reference: String
         
         enum CodingKeys: String, CodingKey {
             case category, title, description
             case actionRequired = "action_required"
             case deadline, reference
         }
         
        //  Helper computed property for icon
         var icon: String {
             switch category {
             case "watch_out": return "🚨"
             case "save_money": return "💰"
             case "maximize_benefits": return "✓"
             case "dont_miss": return "📅"
             case "connect_dots": return "🔗"
             case "protect_yourself": return "🛡️"
             default: return "ℹ️"
             }
         }
         
        //  Helper for display name
         var displayName: String {
             switch category {
             case "watch_out": return "Watch Out"
             case "save_money": return "Save Money"
             case "maximize_benefits": return "Maximize Benefits"
             case "dont_miss": return "Don't Miss"
             case "connect_dots": return "Connect the Dots"
             case "protect_yourself": return "Protect Yourself"
             default: return category.replacingOccurrences(of: "_", with: " ").capitalized
             }
         }
         
       //   Helper for color (for SwiftUI)
         var colorName: String {
             switch category {
             case "watch_out": return "red"
             case "save_money": return "green"
             case "maximize_benefits": return "blue"
             case "dont_miss": return "orange"
             case "connect_dots": return "purple"
             case "protect_yourself": return "indigo"
             default: return "gray"
             }
         }
     }
     
    //  MARK: - Termination
     struct Termination: Codable {
         let howToTerminate: String?
         let noticePeriod: String?
         let terminationFees: [TerminationFee]
         let refundPolicy: String?
         let autoRenewal: AutoRenewal?
         let coolingOffPeriod: CoolingOffPeriod?
         let postTerminationObligations: [String]
         
         enum CodingKeys: String, CodingKey {
             case howToTerminate = "how_to_terminate"
             case noticePeriod = "notice_period"
             case terminationFees = "termination_fees"
             case refundPolicy = "refund_policy"
             case autoRenewal = "auto_renewal"
             case coolingOffPeriod = "cooling_off_period"
             case postTerminationObligations = "post_termination_obligations"
         }
         
         struct TerminationFee: Codable {
             let condition: String
             let amount: String?
             let description: String
         }
         
         struct AutoRenewal: Codable {
             let applies: Bool
             let renewalDate: String?
             let howToPrevent: String?
             let deadlineToCancel: String?
             
             enum CodingKeys: String, CodingKey {
                 case applies
                 case renewalDate = "renewal_date"
                 case howToPrevent = "how_to_prevent"
                 case deadlineToCancel = "deadline_to_cancel"
             }
         }
         
         struct CoolingOffPeriod: Codable {
             let applies: Bool
             let duration: String?
             let endDate: String?
             
             enum CodingKeys: String, CodingKey {
                 case applies, duration
                 case endDate = "end_date"
             }
         }
     }
 }

 // MARK: - Helper Methods
 extension ProcessedDocument {
   // Decode ProcessedDocument from JSON string
     static func decode(from jsonString: String) throws -> ProcessedDocument {
         guard let data = jsonString.data(using: .utf8) else {
             throw DecodingError.dataCorrupted(
                 DecodingError.Context(
                     codingPath: [],
                     debugDescription: "Invalid UTF-8 string"
                 )
             )
         }
         let decoder = JSONDecoder()
         return try decoder.decode(ProcessedDocument.self, from: data)
     }
     
     // Decode ProcessedDocument from JSON data
     static func decode(from data: Data) throws -> ProcessedDocument {
         let decoder = JSONDecoder()
         return try decoder.decode(ProcessedDocument.self, from: data)
     }
     
     // Get all urgent tips (action required)
     var urgentTips: [Tip] {
         tips.filter { $0.actionRequired }
     }
     
     // Get all critical obligations
     var criticalObligations: [Obligation] {
         obligations.filter { $0.critical }
     }
     
     // Get upcoming deadlines (tips and obligations with deadlines)
     var upcomingDeadlines: [(String, String?)] {
         var deadlines: [(String, String?)] = []
         
         // Add tip deadlines
         for tip in tips where tip.deadline != nil {
             deadlines.append((tip.title, tip.deadline))
         }
         
         //  Add obligation deadlines
         for obligation in obligations where obligation.deadline != nil {
             deadlines.append((obligation.item, obligation.deadline))
         }
         
         return deadlines
     }
 }

// MARK: - Sample Data for Testing
// #if DEBUG
// extension ProcessedDocument {
//     static var sample: ProcessedDocument {
//         ProcessedDocument(
//             documentIdentifier: "sample-insurance-policy-001",
//             summary: Summary(
//                 documentType: "Health Insurance Policy",
//                 purpose: "Comprehensive health coverage",
//                 parties: ["ABC Insurance Co.", "John Doe"],
//                 duration: "12 months",
//                 keyDates: ["2025-01-01", "2025-12-31"],
//                 mainPoints: [
//                     "Coverage up to $100,000 per year",
//                     "Includes dental and vision",
//                     "30-day claim submission window"
//                 ],
//                 limitations: [
//                     "Pre-existing conditions excluded for first 6 months",
//                     "Specialist visits require pre-authorization"
//                 ],
//                 topThreeThings: [
//                     "You must submit claims within 30 days",
//                     "Annual renewal is automatic unless you cancel 60 days prior",
//                     "You have a 14-day cooling-off period"
//                 ]
//             ),
//             obligations: [
//                 Obligation(
//                     item: "Pay monthly premium of $500",
//                     critical: true,
//                     deadline: "1st of each month",
//                     penaltyForNonCompliance: "$50 late fee after 5 days"
//                 ),
//                 Obligation(
//                     item: "Submit claims within 30 days of service",
//                     critical: true,
//                     deadline: "30 days from service date",
//                     penaltyForNonCompliance: "Claim may be denied"
//                 )
//             ],
//             feesAndPayments: [
//                 Fee(
//                     type: "recurring",
//                     amount: "$500",
//                     description: "Monthly premium",
//                     frequency: "monthly",
//                     dueDate: "1st of each month",
//                     latePenalty: "$50 after 5 days"
//                 )
//             ],
//             termination: Termination(
//                 howToTerminate: "Written notice via email or postal mail",
//                 noticePeriod: "60 days",
//                 terminationFees: [
//                     Termination.TerminationFee(
//                         condition: "Cancellation within first 12 months",
//                         amount: "$150",
//                         description: "Early termination fee"
//                     )
//                 ],
//                 refundPolicy: "Pro-rated refund for unused months",
//                 autoRenewal: Termination.AutoRenewal(
//                     applies: true,
//                     renewalDate: "2026-01-01",
//                     howToPrevent: "Submit cancellation notice 60 days before renewal",
//                     deadlineToCancel: "2025-11-02"
//                 ),
//                 coolingOffPeriod: Termination.CoolingOffPeriod(
//                     applies: true,
//                     duration: "14 days",
//                     endDate: "2025-01-15"
//                 ),
//                 postTerminationObligations: [
//                     "Return insurance card",
//                     "Pay any outstanding premiums"
//                 ]
//             ),
//             confidentiality: [
//                 Confidentiality(
//                     category: "data_collection",
//                     details: "Collects personal health information, contact details, and payment information",
//                     thirdParties: nil
//                 ),
//                 Confidentiality(
//                     category: "sharing",
//                     details: "May share information with healthcare providers and payment processors",
//                     thirdParties: ["Healthcare providers", "Payment processors"]
//                 )
//             ],
//             tips: [
//                 Tip(
//                     category: "save_money",
//                     title: "Switch to annual payment and save $120",
//                     description: "You're currently paying monthly ($500/month = $6,000/year). The fee schedule on page 2 shows annual payment is $5,880/year. You'd save $120 by switching at your next renewal.",
//                     actionRequired: true,
//                     deadline: "2025-11-02",
//                     reference: "Page 2, Fee Schedule"
//                 ),
//                 Tip(
//                     category: "dont_miss",
//                     title: "Mark cancellation deadline",
//                     description: "Your policy auto-renews on January 1, 2026. You need to give 60 days notice (clause 15.2), so mark November 2, 2025 on your calendar if you want to review alternatives.",
//                     actionRequired: true,
//                     deadline: "2025-11-02",
//                     reference: "Clause 15.2"
//                 ),
//                 Tip(
//                     category: "protect_yourself",
//                     title: "You have a 14-day cooling-off period",
//                     description: "You can cancel with full refund until January 15, 2025 (clause 3.1). If you're unsure about coverage limits, you have time to review - no questions asked.",
//                     actionRequired: false,
//                     deadline: "2025-01-15",
//                     reference: "Clause 3.1"
//                 )
//             ]
//         )
//     }
// }
// #endif
