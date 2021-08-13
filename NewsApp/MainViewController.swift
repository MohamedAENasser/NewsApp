//
//  MainViewController.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 10/08/2021.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.shouldSkipOnboarding {
            presentViewController(type: DashboardViewController.self, viewController: .dashboard)
        } else {
            presentViewController(type: OnboardingViewController.self, viewController: .onboarding)
        }
    }
}
