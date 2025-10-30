//
//  SettingsViewController.swift
//  ios-finWise
//
//  Created by Sing Hui Hang on 24/10/25.

import UIKit

class SettingsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let settings: [[String]] = [
        ["Profile", "Notifications", "Privacy"],
        ["About", "Version"],
        ["Log Out"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        setupBackground()
        setupTableView()
    }
    
    private func setupBackground() {
        let gradientView = GradientView()
        gradientView.frame = view.bounds
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gradientView.setupGradient()
        view.insertSubview(gradientView, at: 0)
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = settings[indexPath.section][indexPath.row]
        cell.textLabel?.text = item
        cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
        cell.textLabel?.textColor = .white
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = settings[indexPath.section][indexPath.row]
        
        switch item {
        case "Log Out":
            let alert = UIAlertController(title: "Log Out",
                                          message: "Are you sure you want to log out?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
                print("User logged out")
                // TODO: Implement actual logout logic
            }))
            present(alert, animated: true)
        default:
            print("\(item) tapped")
        }
    }
}

#Preview {
    UINavigationController(rootViewController: SettingsViewController())
}
