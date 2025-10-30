//
//  AnalyserService.swift
//  ios-finWise
//

import Foundation
import UIKit
import Vision
import OpenAI

class AnalyserService {
    
    private let openAI: OpenAI
    private let systemPrompt: String
    
    init() {
        guard let key = ProcessInfo.processInfo.environment["OPENAI_API_KEY"], !key.isEmpty else {
            fatalError("⚠️ OPENAI_API_KEY not set in environment")
        }
        
        let configuration = OpenAI.Configuration(token: key)
        self.openAI = OpenAI(configuration: configuration)
        
        if let path = Bundle.main.path(forResource: "SystemPrompt", ofType: "md"),
           let prompt = try? String(contentsOfFile: path) {
            self.systemPrompt = prompt
        } else {
            self.systemPrompt = "You are an expert financial document analyzer..."
        }
    }
    
    func analyzeDocument(documentImages: [UIImage], userProfile: String, userQuery: String = "") async throws -> ProcessedDocument {
        
        print("🔍 Starting document analysis...")
        
        // 1️⃣ Extract text from images
        let documentText = try await extractText(from: documentImages)
        print("📊 OCR extracted \(documentText.count) characters")
        
        // 2️⃣ Build final input string
        var fullText = "Please analyze the following financial document(s):\n\n"
        fullText += documentText + "\n\n"
        fullText += "User Profile:\n\(userProfile)\n\n"
        if !userQuery.isEmpty {
            fullText += "User Query:\n\(userQuery)\n\n"
        }
        fullText += "Return the answer strictly in JSON."
        
        print("📝 Total prompt: \(fullText.count) characters")
        print("📋 System prompt: \(systemPrompt.count) characters")
        
        // 3️⃣ Build messages
        let messages: [ChatQuery.ChatCompletionMessageParam] = [
            .system(.init(content: .textContent(systemPrompt))),
            .user(.init(content: .string(fullText)))
        ]
        
        // 4️⃣ Send to OpenAI
        let query = ChatQuery(
            messages: messages,
            model: .gpt4
        )
        
        print("🚀 Sending request to OpenAI...")
        let startTime = Date()
        
        let result = try await openAI.chats(query: query)
        
        let elapsed = Date().timeIntervalSince(startTime)
        print("✅ Received response in \(String(format: "%.1f", elapsed))s")
        
        let responseText = result.choices.first?.message.content ?? ""
        print("📥 Response length: \(responseText.count) characters")
        
        // 5️⃣ Extract JSON
        let jsonString = extractJSON(from: responseText)
        
        // 🔧 Clean the JSON string (remove BOM and trim)
        let cleanedJSON = jsonString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\u{FEFF}", with: "") // Remove BOM
        
        print("🧹 Cleaned JSON length: \(cleanedJSON.count) characters")
        
        // 6️⃣ Decode JSON
        guard let jsonData = cleanedJSON.data(using: .utf8) else {
            throw AnalyserError.invalidJSON("Could not convert response to data")
        }

        let decoder = JSONDecoder()
        // ✅ Don't use convertFromSnakeCase since we have custom CodingKeys

        do {
            let document = try decoder.decode(ProcessedDocument.self, from: jsonData)
            print("✅ Successfully decoded ProcessedDocument")
            return document
        } catch let DecodingError.keyNotFound(key, context) {
            print("❌ Missing key: \(key.stringValue)")
            print("❌ Context: \(context.debugDescription)")
            print("❌ Coding path: \(context.codingPath)")
            
            // Try to see what keys ARE available
            if let data = cleanedJSON.data(using: .utf8),
               let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print("📋 Available top-level keys: \(jsonObject.keys)")
            }
            
            throw AnalyserError.decodingFailed(DecodingError.keyNotFound(key, context))
        } catch {
            print("❌ Decoding error: \(error)")
            throw AnalyserError.decodingFailed(error)
        }
    }
    
    // MARK: - OCR helper
    private func extractText(from images: [UIImage]) async throws -> String {
        var allText = ""
        
        for image in images {
            guard let cgImage = image.cgImage else { continue }
            
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            let request = VNRecognizeTextRequest()
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true
            
            try requestHandler.perform([request])
            
            let imageText = request.results?
                .compactMap { ($0 as? VNRecognizedTextObservation)?.topCandidates(1).first?.string }
                .joined(separator: "\n") ?? ""
            
            allText += imageText + "\n\n"
        }
        
        return allText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // MARK: - JSON extraction helper
    private func extractJSON(from text: String) -> String {
        if text.contains("```json") {
            let pattern = "```json\\s*([\\s\\S]*?)```"
            if let regex = try? NSRegularExpression(pattern: pattern),
               let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
               let range = Range(match.range(at: 1), in: text) {
                return String(text[range]).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        if text.contains("```") {
            let pattern = "```\\s*([\\s\\S]*?)```"
            if let regex = try? NSRegularExpression(pattern: pattern),
               let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
               let range = Range(match.range(at: 1), in: text) {
                return String(text[range]).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

enum AnalyserError: LocalizedError {
    case noResponse
    case invalidJSON(String)
    case decodingFailed(Error)
}
