//
//  AppDelegate.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import UIKit
import Logger
import CoreDomain

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var shared: AppDelegate!

    var window: UIWindow?
    var coordinator: OnboardingCoordinator?
    
    var appConfig: AppConfig = {
        guard let appConfig = AppConfig() else {
            let errorMessage = "Invalid app config"
            consoleLogger.error(errorMessage)
            fatalError(errorMessage)
        }
        return appConfig
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp()
        startApp()
        return true
    }
    
    func configureApp() {
        _ = [DataConfigurator.shared,
             DesignSystemConfigurator.shared
        ].map({$0.configure()})
    }
    
    func startApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        struct UseCase: OnboardingCoordinatorUseCaseProtocol {
            var window: UIWindow?
        }
        
        coordinator = OnboardingCoordinator(useCase: UseCase(window: window))
        coordinator?.start()
        
        Self.shared = self
    }
}
