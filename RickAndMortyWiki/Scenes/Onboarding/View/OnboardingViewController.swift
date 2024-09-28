//
//  OnboardingViewController.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import UIKit
import DesignKit

class OnboardingViewController: UIViewController {
    var viewModel: OnboardingViewModelProtocol?
    
    // MARK: - Init
    init(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension OnboardingViewController {
    private func setupUI() {
        if let viewModel = viewModel as? OnboardingViewModel {
            let swiftuiView = OnboardingSwiftUI(viewModel: viewModel)
            addSubSwiftUIView(swiftuiView, to: view, backgroundColor: .white)
        }
    }
}
