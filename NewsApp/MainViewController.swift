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
            presentNewsViewController()
        } else {
            presentOnboardingViewController()
        }
    }
}

extension UIViewController {
    func presentOnboardingViewController() {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: .main)

        guard let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController else {
            return
        }
        onboardingViewController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(onboardingViewController, animated: true, completion: nil)
        }
    }

    func presentNewsViewController() {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: .main)

        guard let newsViewController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController else {
            return
        }
        newsViewController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(newsViewController, animated: true, completion: nil)
        }
    }
}
