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

extension UIViewController {
    func presentViewController<T: UIViewController>(
        type: T.Type,
        viewController: ViewControllersTypes,
        viewControllerID: String = String(describing: T.self)
    ) {
        let storyboard = UIStoryboard(name: viewController.rawValue, bundle: .main)

        guard let newsViewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? T else {
            return
        }
        newsViewController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(newsViewController, animated: true, completion: nil)
        }
    }
}

enum ViewControllersTypes: String {
    case onboarding = "Onboarding"
    case dashboard = "Dashboard"
}
