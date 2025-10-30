//
//  AppDelegate.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    
    //Set dummy user d
    
    var user: User? {
        didSet {
            saveUser()
        }
    }
    
    /*
     class AppDelegate: UIResponder, UIApplicationDelegate {
         static var shared: AppDelegate { UIApplication.shared.delegate as! AppDelegate }
         
         var savedAnalysis: Set<ProcessedDocument> = []

         func application(
             _ application: UIApplication,
             didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
         ) -> Bool {
             // Load saved analysis on launch
             savedAnalysis = DocumentManager.shared.loadSavedDocuments()
             return true
         }
     }

     */
    
    
    //Set variables for savedAnalysis
    var savedAnalysis = Set<ProcessedDocument>()
    
    static var shared: AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        loadUser()
        // Load saved analysis on launch
        savedAnalysis = DocumentManager.shared.loadSavedDocuments()
        return true
    }
    
    private func saveUser() {
           guard let user = user else {
               UserDefaults.standard.removeObject(forKey: "savedUser")
               return
           }
           
           if let encoded = try? JSONEncoder().encode(user) {
               UserDefaults.standard.set(encoded, forKey: "savedUser")
           }
    }
    
    private func loadUser() {
           if let savedData = UserDefaults.standard.data(forKey: "savedUser"),
              let decoded = try? JSONDecoder().decode(User.self, from: savedData) {
               user = decoded
           }
       }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

class DocumentManager {
    static let shared = DocumentManager()
    private let savedKey = "savedAnalysis"
    
    private init() {}
    
    func save(documents: Set<ProcessedDocument>) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(Array(documents))
            UserDefaults.standard.set(data, forKey: savedKey)
        } catch {
            print("Failed to save documents: \(error)")
        }
    }
    
    func loadSavedDocuments() -> Set<ProcessedDocument> {
        guard let data = UserDefaults.standard.data(forKey: savedKey) else { return [] }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let array = try decoder.decode([ProcessedDocument].self, from: data)
            return Set(array)
        } catch {
            print("Failed to load documents: \(error)")
            return []
        }
    }
}
