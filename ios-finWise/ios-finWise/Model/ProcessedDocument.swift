// ProcessedDocument.swift
// ios-finWise

//Created by Sing Hui Hang on 24/10/25.
 
import Foundation
import UIKit

struct ProcessedDocument: Codable {
    let id = UUID()
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
        let severity: ObligationSeverity?
        
        enum CodingKeys: String, CodingKey {
            case item, critical, deadline
            case penaltyForNonCompliance = "penalty_for_non_compliance"
            case severity
        }
        
        enum ObligationSeverity: String, Codable {
            case low, medium, high, critical
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
         let severity: FeeSeverity?
         
         enum CodingKeys: String, CodingKey {
             case type, amount, description, frequency
             case dueDate = "due_date"
             case latePenalty = "late_penalty"
             case severity
         }
         
         enum FeeSeverity: String, Codable {
             case low, medium, high, critical
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
         let severity: ConfidentialitySeverity?
         
         enum CodingKeys: String, CodingKey {
             case category, details
             case thirdParties = "third_parties"
             case severity
         }
         
         enum ConfidentialitySeverity: String, Codable {
             case low, medium, high, critical
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
         let severity: TipSeverity?
         
         enum CodingKeys: String, CodingKey {
             case category, title, description
             case actionRequired = "action_required"
             case deadline, reference, severity
         }
         
         enum TipSeverity: String, Codable {
             case low, medium, high, critical
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
         let severity: TerminationSeverity?
         
         enum CodingKeys: String, CodingKey {
             case howToTerminate = "how_to_terminate"
             case noticePeriod = "notice_period"
             case terminationFees = "termination_fees"
             case refundPolicy = "refund_policy"
             case autoRenewal = "auto_renewal"
             case coolingOffPeriod = "cooling_off_period"
             case postTerminationObligations = "post_termination_obligations"
             case severity
         }
         
         enum TerminationSeverity: String, Codable {
             case low, medium, high, critical
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

extension ProcessedDocument: Hashable {
    static func == (lhs: ProcessedDocument, rhs: ProcessedDocument) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Severity Display Helper
extension ProcessedDocument {
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
    
    // Convert from JSON severity to display severity
    private func convertSeverity(_ severity: String?) -> Severity {
        guard let severity = severity else { return .medium }
        switch severity.lowercased() {
        case "low": return .low
        case "medium": return .medium
        case "high": return .high
        case "critical": return .critical
        default: return .medium
        }
    }
    
    // Calculated severity properties for each section
    var obligationsSeverity: Severity {
        // If any obligation has explicit severity, use the highest one
        let explicitSeverities = obligations.compactMap { $0.severity?.rawValue }
        if let highest = explicitSeverities.max(by: { severityRank($0) < severityRank($1) }) {
            return convertSeverity(highest)
        }
        
        // Otherwise calculate based on critical count
        let criticalCount = obligations.filter { $0.critical }.count
        if criticalCount >= 3 { return .critical }
        if criticalCount >= 2 { return .high }
        if criticalCount >= 1 { return .medium }
        return .low
    }
    
    var feesSeverity: Severity {
        // If any fee has explicit severity, use the highest one
        let explicitSeverities = feesAndPayments.compactMap { $0.severity?.rawValue }
        if let highest = explicitSeverities.max(by: { severityRank($0) < severityRank($1) }) {
            return convertSeverity(highest)
        }
        
        // Otherwise calculate based on recurring fees
        let recurringFees = feesAndPayments.filter { $0.type == "recurring" }.count
        if recurringFees >= 3 { return .high }
        if recurringFees >= 1 { return .medium }
        return .low
    }
    
    var terminationSeverity: Severity {
        // Use explicit severity if available
        if let severity = termination.severity?.rawValue {
            return convertSeverity(severity)
        }
        
        // Otherwise calculate based on conditions
        let hasAutoRenewal = termination.autoRenewal?.applies ?? false
        let hasTerminationFees = !termination.terminationFees.isEmpty
        
        if hasAutoRenewal && hasTerminationFees { return .high }
        if hasAutoRenewal || hasTerminationFees { return .medium }
        return .low
    }
    
    var confidentialitySeverity: Severity {
        // If any confidentiality item has explicit severity, use the highest one
        let explicitSeverities = confidentiality.compactMap { $0.severity?.rawValue }
        if let highest = explicitSeverities.max(by: { severityRank($0) < severityRank($1) }) {
            return convertSeverity(highest)
        }
        
        // Otherwise calculate based on third-party sharing
        let hasThirdParties = confidentiality.contains {
            $0.thirdParties != nil && !($0.thirdParties?.isEmpty ?? true)
        }
        if hasThirdParties { return .medium }
        return .low
    }
    
    // Helper to rank severity strings for comparison
    private func severityRank(_ severity: String) -> Int {
        switch severity.lowercased() {
        case "low": return 1
        case "medium": return 2
        case "high": return 3
        case "critical": return 4
        default: return 0
        }
    }
}
