//
//  AnalyserService.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 25/10/25.
//

import Foundation
import OpenAI
import UIKit

class AnalyserService{
    
    // 1. Initialise OPENAI api
    init(documentImages: [UIImage]){
        guard let key = ProcessInfo.processInfo.environment["OPENAI_API_KEY"], !key.isEmpty else {
            fatalError("Missing OPENAI_API_KEY")
        }
        let configuration = OpenAI.Configuration(token: key)
        self.openAI = OpenAI(configuration: configuration)
    }
    
    private let openAI: OpenAI
    
    
    //2. Set system prompt based on user configuration results - specify the structure to return so that it can be parsed properly
    
    private var systemPrompt = ""
    
    func prepareSystemPrompt(){
        if let filePath = Bundle.main.path(forResource: "SystemPrompt", ofType: "md"){
            do{
                systemPrompt = try String(contentsOfFile: filePath)
            } catch{
                print("Error reading system prompt markdown file: \(error)")
            }
        }
        
    }
    
    //Prepare query
    func respond(to text:String) async throws -> String{
        let query = ChatQuery(
            messages: [.system(.init(content: .textContent(systemPrompt))),
                      .user(.init(content: .string(text)))],
            model: .gpt4
        )
        
        let result = try await openAI.chats(query: query)
        let response = result.choices.first?.message.content ?? ""
        
        //Prepare response and send to view controller
        
        return response

    }
    
    
    
}
