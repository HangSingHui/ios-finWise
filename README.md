# finWise (iOS)

finWise is a native iOS prototype that helps users take photos of contracts and receive an accessible, personalized analysis of key contract elements and risks. Analysis is tailored to each user's financial literacy level, which is assessed the first time the app launches.

> Quick summary: point the camera at a contract, capture a photo (or pick an image), and finWise extracts text, highlights important clauses, explains terms in plain language, and offers recommended next steps based on the user's literacy level.

## Table of contents
- [Key features](#key-features)
- [How it works](#how-it-works)
- [User flow](#user-flow)
- [Privacy & security](#privacy--security)
- [Requirements](#requirements)
- [Getting started](#getting-started)
- [Configuration (API keys & run-time secrets)](#configuration-api-keys--run-time-secrets)
- [Contact](#contact)

## Key features
- Capture contract images with the camera or import from the photo library.
- Automatic OCR to extract contract text (e.g., dates, parties, amounts, durations).
- Clause detection and highlighting: identifies common contract sections (termination, fees, renewal, liabilities).
- Plain-language explanations: translates legal/financial phrasing into simple summaries.
- Personalized advice and risk scoring based on the user's assessed financial literacy level.
- Onboarding literacy assessment: quick quiz at first launch to set explanation depth and action recommendations.

## How it works (high level)
1. User completes a short in-app literacy assessment on first launch.
2. User takes a photo of a contract or uploads a document image.
3. The app runs OCR to extract text and performs NLP/ML-based contract parsing to detect sections and key entities.
4. Based on the parsed content and the user's literacy level, the app:
   - Generates plain-language summaries of critical clauses.
   - Flags potential risks and unusual terms.
   - Suggests next steps (seek lawyer, negotiate fees, ask for clarification) and highlights urgency.
5. User can save or export the annotated contract report.

## User flow
- On first launch
  - Welcome screen -> Short financial literacy quiz -> Save profile settings
- Main screen
  - Camera / Upload -> Capture -> Processing / Analysis -> Annotated report -> Save / Share

## Requirements
- Development: Xcode 14/15+ (adjust to the Xcode version you support)
- Language: Swift (refer to repository for exact Swift version)
- Minimum iOS: iOS 15+ (adjust according to project settings)
- Dependency manager: Swift Package Manager (SPM)

## Getting started

### Clone
```bash
git clone https://github.com/HangSingHui/ios-finWise.git
cd ios-finWise
```

### Install dependencies (Swift Package Manager)
This project uses Swift Package Manager (SPM) for dependencies.

- Open the Xcode project and Xcode will automatically resolve SPM packages:
  - open ios-finWise.xcodeproj
- Or resolve packages from the command line:
```bash
swift package resolve
```
- To add or update packages, use Xcode → File → Add Packages... or edit Package.swift.

> Note: CocoaPods and Carthage are not used in this project.

### Build & Run
1. Open ios-finWise.xcodeproj in Xcode.
2. Make sure you configured any required API keys (see Configuration below).
3. Select a simulator or a connected device.
4. Build and run (Cmd+R).

## Configuration (API keys & run-time secrets)
This project expects API keys (if used by server-side or third-party services) to be provided via your Xcode Run scheme environment variables so keys are not stored in the repo.

Recommended steps to add an API key to your local Run scheme:
1. In Xcode choose Product → Scheme → Edit Scheme...
2. Select "Run" in the left sidebar.
3. Select the "Arguments" tab.
4. In the "Environment Variables" section click the "+" button.
5. Add a variable name and value. Recommended variable name:
   - OPENAI_API_KEY = <your-api-key>
6. Ensure the checkbox next to the variable is checked so it will be available at runtime.
7. Close the scheme editor and run the app.

Access the environment variable in code:
```swift
let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
```

Security notes:
- Never commit real API keys or credentials to the repository.
- For CI/automation, configure secrets in your CI provider's secret store instead of committing keys.
- For production, prefer secure storage (Keychain, Secret Manager) and short-lived tokens; treat environment variables as local developer convenience only.


## Contact
Maintainer: HangSingHui  
GitHub: https://github.com/HangSingHui

Notes
- Dependencies are managed with Swift Package Manager (SPM).
- API keys are configured via Xcode Run scheme environment variables (Edit Scheme → Run → Arguments → Environment Variables).
- Replace placeholders (framework versions, screenshots, config names) with actual project values.
- Add a Privacy Policy and clear consent screens before any server uploads.
